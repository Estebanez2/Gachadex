package com.alejandroestebanez.gachadex

import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.OpenableColumns
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File

class MainActivity : FlutterActivity() {
    private var importChannel: MethodChannel? = null
    private var pendingGachadexFilePath: String? = null

    override fun getInitialRoute(): String {
        return "/home"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        importChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "gachadex/import_files",
        )
        importChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "getInitialGachadexFile" -> {
                    result.success(pendingGachadexFilePath)
                    pendingGachadexFilePath = null
                }
                else -> result.notImplemented()
            }
        }
        pendingGachadexFilePath = cacheGachadexFileFromIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        val path = cacheGachadexFileFromIntent(intent)
        if (path == null) {
            return
        }
        val channel = importChannel
        if (channel == null) {
            pendingGachadexFilePath = path
        } else {
            channel.invokeMethod("openGachadexFile", path)
        }
    }

    private fun cacheGachadexFileFromIntent(intent: Intent?): String? {
        val uri = gachadexUriFromIntent(intent) ?: return null
        val displayName = try {
            displayNameFor(uri)
        } catch (_: Exception) {
            null
        }
        val rawName = displayName ?: uri.lastPathSegment ?: "shared_collection.gachadex"

        return try {
            copyUriToImportCache(uri, rawName)
        } catch (_: Exception) {
            null
        }
    }

    private fun gachadexUriFromIntent(intent: Intent?): Uri? {
        if (intent == null) {
            return null
        }
        return when (intent.action) {
            Intent.ACTION_VIEW -> intent.data ?: intent.clipData?.getItemAt(0)?.uri
            Intent.ACTION_SEND -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    intent.getParcelableExtra(Intent.EXTRA_STREAM, Uri::class.java)
                        ?: intent.clipData?.getItemAt(0)?.uri
                } else {
                    @Suppress("DEPRECATION")
                    intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
                        ?: intent.clipData?.getItemAt(0)?.uri
                }
            }
            else -> null
        }
    }

    private fun displayNameFor(uri: Uri): String? {
        return contentResolver.query(uri, null, null, null, null)?.use { cursor ->
            val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
            if (nameIndex >= 0 && cursor.moveToFirst()) {
                cursor.getString(nameIndex)
            } else {
                null
            }
        }
    }

    private fun copyUriToImportCache(uri: Uri, rawName: String): String? {
        val baseName = rawName
            .substringAfterLast('/')
            .ifBlank { "shared_collection.gachadex" }
        val safeBaseName = baseName.replace(Regex("[^A-Za-z0-9._-]"), "_")
        val safeName = if (safeBaseName.lowercase().endsWith(".gachadex")) {
            safeBaseName
        } else {
            "$safeBaseName.gachadex"
        }
        val targetDir = File(cacheDir, "incoming_gachadex").apply { mkdirs() }
        val targetFile = File(targetDir, "${System.currentTimeMillis()}_$safeName")
        if (uri.scheme == "file") {
            val source = File(uri.path ?: return null)
            source.inputStream().use { input ->
                targetFile.outputStream().use { output ->
                    input.copyTo(output)
                }
            }
        } else {
            contentResolver.openInputStream(uri)?.use { input ->
                targetFile.outputStream().use { output ->
                    input.copyTo(output)
                }
            } ?: return null
        }
        return targetFile.absolutePath
    }
}
