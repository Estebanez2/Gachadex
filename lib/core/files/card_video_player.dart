import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../app/localization/app_localizations.dart';
import '../constants/app_constants.dart';
import '../value_objects/relative_media_path.dart';
import 'file_providers.dart';
import 'stored_media_image.dart';

class CardVideoPlayer extends ConsumerStatefulWidget {
  const CardVideoPlayer({
    super.key,
    required this.videoPath,
    required this.thumbnailPath,
    this.autoplay = false,
  });

  final RelativeMediaPath videoPath;
  final RelativeMediaPath thumbnailPath;
  final bool autoplay;

  @override
  ConsumerState<CardVideoPlayer> createState() => _CardVideoPlayerState();
}

class _CardVideoPlayerState extends ConsumerState<CardVideoPlayer>
    with WidgetsBindingObserver {
  VideoPlayerController? _controller;
  bool _initializing = true;
  bool _hasError = false;
  bool _showThumbnail = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  @override
  void didUpdateWidget(CardVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _disposeController();
      _initialize();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      _pauseToCover();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final controller = _controller;
    final isReady = controller != null && controller.value.isInitialized;
    final isPlaying = controller?.value.isPlaying ?? false;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (!isReady || _showThumbnail)
          StoredMediaImage(path: widget.thumbnailPath)
        else
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller.value.size.width,
              height: controller.value.size.height,
              child: VideoPlayer(controller),
            ),
          ),
        if (_initializing)
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        if (_hasError)
          ColoredBox(
            color: Colors.black.withValues(alpha: 0.45),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.spacingMd),
                child: Text(
                  l10n.videoPlaybackFailed,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        Positioned(
          right: AppConstants.spacingSm,
          bottom: AppConstants.spacingSm,
          child: FilledButton.icon(
            onPressed: isReady ? _togglePlayback : null,
            icon: Icon(isPlaying ? Icons.pause : Icons.replay_outlined),
            label: Text(isPlaying ? l10n.pause : l10n.replay),
          ),
        ),
      ],
    );
  }

  Future<void> _initialize() async {
    if (!mounted) {
      return;
    }
    setState(() {
      _initializing = true;
      _hasError = false;
      _showThumbnail = true;
    });
    try {
      final storage = ref.read(projectMediaStorageProvider);
      final file = await storage.resolve(widget.videoPath);
      final controller = VideoPlayerController.file(File(file.path));
      await controller.initialize();
      controller.addListener(_onVideoChanged);
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _initializing = false;
      });
      if (widget.autoplay) {
        await _playFromStart();
      }
    } on Object {
      if (mounted) {
        setState(() {
          _initializing = false;
          _hasError = true;
        });
      }
    }
  }

  void _onVideoChanged() {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (controller.value.position >= controller.value.duration &&
        !controller.value.isPlaying &&
        !_showThumbnail &&
        mounted) {
      setState(() => _showThumbnail = true);
    }
  }

  Future<void> _togglePlayback() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    if (controller.value.isPlaying) {
      await _pauseToCover();
    } else {
      await _playFromStart();
    }
  }

  Future<void> _playFromStart() async {
    final controller = _controller;
    if (controller == null) {
      return;
    }
    await controller.seekTo(Duration.zero);
    await controller.play();
    if (mounted) {
      setState(() => _showThumbnail = false);
    }
  }

  Future<void> _pauseToCover() async {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      await controller.pause();
      await controller.seekTo(Duration.zero);
    }
    if (mounted) {
      setState(() => _showThumbnail = true);
    }
  }

  void _disposeController() {
    final controller = _controller;
    controller?.removeListener(_onVideoChanged);
    controller?.dispose();
    _controller = null;
  }
}
