// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MediaAssetsTable extends MediaAssets
    with TableInfo<$MediaAssetsTable, MediaAssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MediaAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MediaOwnerType, String>
  ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<MediaOwnerType>($MediaAssetsTable.$converterownerType);
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MediaType, String> mediaType =
      GeneratedColumn<String>(
        'media_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MediaType>($MediaAssetsTable.$convertermediaType);
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailRelativePathMeta =
      const VerificationMeta('thumbnailRelativePath');
  @override
  late final GeneratedColumn<String> thumbnailRelativePath =
      GeneratedColumn<String>(
        'thumbnail_relative_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    ownerType,
    ownerId,
    mediaType,
    relativePath,
    thumbnailRelativePath,
    mimeType,
    width,
    height,
    durationMs,
    fileSize,
    sha256,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'media_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<MediaAssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('thumbnail_relative_path')) {
      context.handle(
        _thumbnailRelativePathMeta,
        thumbnailRelativePath.isAcceptableOrUnknown(
          data['thumbnail_relative_path']!,
          _thumbnailRelativePathMeta,
        ),
      );
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_fileSizeMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaAssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MediaAssetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      ownerType: $MediaAssetsTable.$converterownerType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}owner_type'],
        )!,
      ),
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      mediaType: $MediaAssetsTable.$convertermediaType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}media_type'],
        )!,
      ),
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      thumbnailRelativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_relative_path'],
      ),
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      ),
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $MediaAssetsTable createAlias(String alias) {
    return $MediaAssetsTable(attachedDatabase, alias);
  }

  static TypeConverter<MediaOwnerType, String> $converterownerType =
      const MediaOwnerTypeConverter();
  static TypeConverter<MediaType, String> $convertermediaType =
      const MediaTypeConverter();
}

class MediaAssetRow extends DataClass implements Insertable<MediaAssetRow> {
  final String id;
  final String collectionId;
  final MediaOwnerType ownerType;
  final String ownerId;
  final MediaType mediaType;
  final String relativePath;
  final String? thumbnailRelativePath;
  final String mimeType;
  final int? width;
  final int? height;
  final int? durationMs;
  final int fileSize;
  final String? sha256;
  final DateTime createdAtUtc;
  const MediaAssetRow({
    required this.id,
    required this.collectionId,
    required this.ownerType,
    required this.ownerId,
    required this.mediaType,
    required this.relativePath,
    this.thumbnailRelativePath,
    required this.mimeType,
    this.width,
    this.height,
    this.durationMs,
    required this.fileSize,
    this.sha256,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    {
      map['owner_type'] = Variable<String>(
        $MediaAssetsTable.$converterownerType.toSql(ownerType),
      );
    }
    map['owner_id'] = Variable<String>(ownerId);
    {
      map['media_type'] = Variable<String>(
        $MediaAssetsTable.$convertermediaType.toSql(mediaType),
      );
    }
    map['relative_path'] = Variable<String>(relativePath);
    if (!nullToAbsent || thumbnailRelativePath != null) {
      map['thumbnail_relative_path'] = Variable<String>(thumbnailRelativePath);
    }
    map['mime_type'] = Variable<String>(mimeType);
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    if (!nullToAbsent || durationMs != null) {
      map['duration_ms'] = Variable<int>(durationMs);
    }
    map['file_size'] = Variable<int>(fileSize);
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  MediaAssetsCompanion toCompanion(bool nullToAbsent) {
    return MediaAssetsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      mediaType: Value(mediaType),
      relativePath: Value(relativePath),
      thumbnailRelativePath: thumbnailRelativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailRelativePath),
      mimeType: Value(mimeType),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      durationMs: durationMs == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMs),
      fileSize: Value(fileSize),
      sha256: sha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory MediaAssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MediaAssetRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      ownerType: serializer.fromJson<MediaOwnerType>(json['ownerType']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      mediaType: serializer.fromJson<MediaType>(json['mediaType']),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      thumbnailRelativePath: serializer.fromJson<String?>(
        json['thumbnailRelativePath'],
      ),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      durationMs: serializer.fromJson<int?>(json['durationMs']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'ownerType': serializer.toJson<MediaOwnerType>(ownerType),
      'ownerId': serializer.toJson<String>(ownerId),
      'mediaType': serializer.toJson<MediaType>(mediaType),
      'relativePath': serializer.toJson<String>(relativePath),
      'thumbnailRelativePath': serializer.toJson<String?>(
        thumbnailRelativePath,
      ),
      'mimeType': serializer.toJson<String>(mimeType),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'durationMs': serializer.toJson<int?>(durationMs),
      'fileSize': serializer.toJson<int>(fileSize),
      'sha256': serializer.toJson<String?>(sha256),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  MediaAssetRow copyWith({
    String? id,
    String? collectionId,
    MediaOwnerType? ownerType,
    String? ownerId,
    MediaType? mediaType,
    String? relativePath,
    Value<String?> thumbnailRelativePath = const Value.absent(),
    String? mimeType,
    Value<int?> width = const Value.absent(),
    Value<int?> height = const Value.absent(),
    Value<int?> durationMs = const Value.absent(),
    int? fileSize,
    Value<String?> sha256 = const Value.absent(),
    DateTime? createdAtUtc,
  }) => MediaAssetRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    mediaType: mediaType ?? this.mediaType,
    relativePath: relativePath ?? this.relativePath,
    thumbnailRelativePath: thumbnailRelativePath.present
        ? thumbnailRelativePath.value
        : this.thumbnailRelativePath,
    mimeType: mimeType ?? this.mimeType,
    width: width.present ? width.value : this.width,
    height: height.present ? height.value : this.height,
    durationMs: durationMs.present ? durationMs.value : this.durationMs,
    fileSize: fileSize ?? this.fileSize,
    sha256: sha256.present ? sha256.value : this.sha256,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  MediaAssetRow copyWithCompanion(MediaAssetsCompanion data) {
    return MediaAssetRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      thumbnailRelativePath: data.thumbnailRelativePath.present
          ? data.thumbnailRelativePath.value
          : this.thumbnailRelativePath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MediaAssetRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('mediaType: $mediaType, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailRelativePath: $thumbnailRelativePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('durationMs: $durationMs, ')
          ..write('fileSize: $fileSize, ')
          ..write('sha256: $sha256, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    ownerType,
    ownerId,
    mediaType,
    relativePath,
    thumbnailRelativePath,
    mimeType,
    width,
    height,
    durationMs,
    fileSize,
    sha256,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MediaAssetRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          other.mediaType == this.mediaType &&
          other.relativePath == this.relativePath &&
          other.thumbnailRelativePath == this.thumbnailRelativePath &&
          other.mimeType == this.mimeType &&
          other.width == this.width &&
          other.height == this.height &&
          other.durationMs == this.durationMs &&
          other.fileSize == this.fileSize &&
          other.sha256 == this.sha256 &&
          other.createdAtUtc == this.createdAtUtc);
}

class MediaAssetsCompanion extends UpdateCompanion<MediaAssetRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<MediaOwnerType> ownerType;
  final Value<String> ownerId;
  final Value<MediaType> mediaType;
  final Value<String> relativePath;
  final Value<String?> thumbnailRelativePath;
  final Value<String> mimeType;
  final Value<int?> width;
  final Value<int?> height;
  final Value<int?> durationMs;
  final Value<int> fileSize;
  final Value<String?> sha256;
  final Value<DateTime> createdAtUtc;
  final Value<int> rowid;
  const MediaAssetsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.thumbnailRelativePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MediaAssetsCompanion.insert({
    required String id,
    required String collectionId,
    required MediaOwnerType ownerType,
    required String ownerId,
    required MediaType mediaType,
    required String relativePath,
    this.thumbnailRelativePath = const Value.absent(),
    required String mimeType,
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.durationMs = const Value.absent(),
    required int fileSize,
    this.sha256 = const Value.absent(),
    required DateTime createdAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       mediaType = Value(mediaType),
       relativePath = Value(relativePath),
       mimeType = Value(mimeType),
       fileSize = Value(fileSize),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<MediaAssetRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? ownerType,
    Expression<String>? ownerId,
    Expression<String>? mediaType,
    Expression<String>? relativePath,
    Expression<String>? thumbnailRelativePath,
    Expression<String>? mimeType,
    Expression<int>? width,
    Expression<int>? height,
    Expression<int>? durationMs,
    Expression<int>? fileSize,
    Expression<String>? sha256,
    Expression<DateTime>? createdAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (mediaType != null) 'media_type': mediaType,
      if (relativePath != null) 'relative_path': relativePath,
      if (thumbnailRelativePath != null)
        'thumbnail_relative_path': thumbnailRelativePath,
      if (mimeType != null) 'mime_type': mimeType,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (durationMs != null) 'duration_ms': durationMs,
      if (fileSize != null) 'file_size': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MediaAssetsCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<MediaOwnerType>? ownerType,
    Value<String>? ownerId,
    Value<MediaType>? mediaType,
    Value<String>? relativePath,
    Value<String?>? thumbnailRelativePath,
    Value<String>? mimeType,
    Value<int?>? width,
    Value<int?>? height,
    Value<int?>? durationMs,
    Value<int>? fileSize,
    Value<String?>? sha256,
    Value<DateTime>? createdAtUtc,
    Value<int>? rowid,
  }) {
    return MediaAssetsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      mediaType: mediaType ?? this.mediaType,
      relativePath: relativePath ?? this.relativePath,
      thumbnailRelativePath:
          thumbnailRelativePath ?? this.thumbnailRelativePath,
      mimeType: mimeType ?? this.mimeType,
      width: width ?? this.width,
      height: height ?? this.height,
      durationMs: durationMs ?? this.durationMs,
      fileSize: fileSize ?? this.fileSize,
      sha256: sha256 ?? this.sha256,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(
        $MediaAssetsTable.$converterownerType.toSql(ownerType.value),
      );
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(
        $MediaAssetsTable.$convertermediaType.toSql(mediaType.value),
      );
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (thumbnailRelativePath.present) {
      map['thumbnail_relative_path'] = Variable<String>(
        thumbnailRelativePath.value,
      );
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MediaAssetsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('mediaType: $mediaType, ')
          ..write('relativePath: $relativePath, ')
          ..write('thumbnailRelativePath: $thumbnailRelativePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('durationMs: $durationMs, ')
          ..write('fileSize: $fileSize, ')
          ..write('sha256: $sha256, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContentVersionsTable extends ContentVersions
    with TableInfo<$ContentVersionsTable, ContentVersionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentVersionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionNumberMeta = const VerificationMeta(
    'versionNumber',
  );
  @override
  late final GeneratedColumn<int> versionNumber = GeneratedColumn<int>(
    'version_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatVersionMeta = const VerificationMeta(
    'formatVersion',
  );
  @override
  late final GeneratedColumn<int> formatVersion = GeneratedColumn<int>(
    'format_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finalizedAtUtcMeta = const VerificationMeta(
    'finalizedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> finalizedAtUtc =
      GeneratedColumn<DateTime>(
        'finalized_at_utc',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isCurrentMeta = const VerificationMeta(
    'isCurrent',
  );
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
    'is_current',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    versionNumber,
    formatVersion,
    createdAtUtc,
    finalizedAtUtc,
    isCurrent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_versions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentVersionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('version_number')) {
      context.handle(
        _versionNumberMeta,
        versionNumber.isAcceptableOrUnknown(
          data['version_number']!,
          _versionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_versionNumberMeta);
    }
    if (data.containsKey('format_version')) {
      context.handle(
        _formatVersionMeta,
        formatVersion.isAcceptableOrUnknown(
          data['format_version']!,
          _formatVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_formatVersionMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('finalized_at_utc')) {
      context.handle(
        _finalizedAtUtcMeta,
        finalizedAtUtc.isAcceptableOrUnknown(
          data['finalized_at_utc']!,
          _finalizedAtUtcMeta,
        ),
      );
    }
    if (data.containsKey('is_current')) {
      context.handle(
        _isCurrentMeta,
        isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta),
      );
    } else if (isInserting) {
      context.missing(_isCurrentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {collectionId, versionNumber},
  ];
  @override
  ContentVersionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentVersionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      versionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version_number'],
      )!,
      formatVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}format_version'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      finalizedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finalized_at_utc'],
      ),
      isCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current'],
      )!,
    );
  }

  @override
  $ContentVersionsTable createAlias(String alias) {
    return $ContentVersionsTable(attachedDatabase, alias);
  }
}

class ContentVersionRow extends DataClass
    implements Insertable<ContentVersionRow> {
  final String id;
  final String collectionId;
  final int versionNumber;
  final int formatVersion;
  final DateTime createdAtUtc;
  final DateTime? finalizedAtUtc;
  final bool isCurrent;
  const ContentVersionRow({
    required this.id,
    required this.collectionId,
    required this.versionNumber,
    required this.formatVersion,
    required this.createdAtUtc,
    this.finalizedAtUtc,
    required this.isCurrent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['version_number'] = Variable<int>(versionNumber);
    map['format_version'] = Variable<int>(formatVersion);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    if (!nullToAbsent || finalizedAtUtc != null) {
      map['finalized_at_utc'] = Variable<DateTime>(finalizedAtUtc);
    }
    map['is_current'] = Variable<bool>(isCurrent);
    return map;
  }

  ContentVersionsCompanion toCompanion(bool nullToAbsent) {
    return ContentVersionsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      versionNumber: Value(versionNumber),
      formatVersion: Value(formatVersion),
      createdAtUtc: Value(createdAtUtc),
      finalizedAtUtc: finalizedAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(finalizedAtUtc),
      isCurrent: Value(isCurrent),
    );
  }

  factory ContentVersionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentVersionRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      versionNumber: serializer.fromJson<int>(json['versionNumber']),
      formatVersion: serializer.fromJson<int>(json['formatVersion']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      finalizedAtUtc: serializer.fromJson<DateTime?>(json['finalizedAtUtc']),
      isCurrent: serializer.fromJson<bool>(json['isCurrent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'versionNumber': serializer.toJson<int>(versionNumber),
      'formatVersion': serializer.toJson<int>(formatVersion),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'finalizedAtUtc': serializer.toJson<DateTime?>(finalizedAtUtc),
      'isCurrent': serializer.toJson<bool>(isCurrent),
    };
  }

  ContentVersionRow copyWith({
    String? id,
    String? collectionId,
    int? versionNumber,
    int? formatVersion,
    DateTime? createdAtUtc,
    Value<DateTime?> finalizedAtUtc = const Value.absent(),
    bool? isCurrent,
  }) => ContentVersionRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    versionNumber: versionNumber ?? this.versionNumber,
    formatVersion: formatVersion ?? this.formatVersion,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    finalizedAtUtc: finalizedAtUtc.present
        ? finalizedAtUtc.value
        : this.finalizedAtUtc,
    isCurrent: isCurrent ?? this.isCurrent,
  );
  ContentVersionRow copyWithCompanion(ContentVersionsCompanion data) {
    return ContentVersionRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      versionNumber: data.versionNumber.present
          ? data.versionNumber.value
          : this.versionNumber,
      formatVersion: data.formatVersion.present
          ? data.formatVersion.value
          : this.formatVersion,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      finalizedAtUtc: data.finalizedAtUtc.present
          ? data.finalizedAtUtc.value
          : this.finalizedAtUtc,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentVersionRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('finalizedAtUtc: $finalizedAtUtc, ')
          ..write('isCurrent: $isCurrent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    versionNumber,
    formatVersion,
    createdAtUtc,
    finalizedAtUtc,
    isCurrent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentVersionRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.versionNumber == this.versionNumber &&
          other.formatVersion == this.formatVersion &&
          other.createdAtUtc == this.createdAtUtc &&
          other.finalizedAtUtc == this.finalizedAtUtc &&
          other.isCurrent == this.isCurrent);
}

class ContentVersionsCompanion extends UpdateCompanion<ContentVersionRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<int> versionNumber;
  final Value<int> formatVersion;
  final Value<DateTime> createdAtUtc;
  final Value<DateTime?> finalizedAtUtc;
  final Value<bool> isCurrent;
  final Value<int> rowid;
  const ContentVersionsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.versionNumber = const Value.absent(),
    this.formatVersion = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.finalizedAtUtc = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContentVersionsCompanion.insert({
    required String id,
    required String collectionId,
    required int versionNumber,
    required int formatVersion,
    required DateTime createdAtUtc,
    this.finalizedAtUtc = const Value.absent(),
    required bool isCurrent,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       versionNumber = Value(versionNumber),
       formatVersion = Value(formatVersion),
       createdAtUtc = Value(createdAtUtc),
       isCurrent = Value(isCurrent);
  static Insertable<ContentVersionRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<int>? versionNumber,
    Expression<int>? formatVersion,
    Expression<DateTime>? createdAtUtc,
    Expression<DateTime>? finalizedAtUtc,
    Expression<bool>? isCurrent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (versionNumber != null) 'version_number': versionNumber,
      if (formatVersion != null) 'format_version': formatVersion,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (finalizedAtUtc != null) 'finalized_at_utc': finalizedAtUtc,
      if (isCurrent != null) 'is_current': isCurrent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContentVersionsCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<int>? versionNumber,
    Value<int>? formatVersion,
    Value<DateTime>? createdAtUtc,
    Value<DateTime?>? finalizedAtUtc,
    Value<bool>? isCurrent,
    Value<int>? rowid,
  }) {
    return ContentVersionsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      versionNumber: versionNumber ?? this.versionNumber,
      formatVersion: formatVersion ?? this.formatVersion,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      finalizedAtUtc: finalizedAtUtc ?? this.finalizedAtUtc,
      isCurrent: isCurrent ?? this.isCurrent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (versionNumber.present) {
      map['version_number'] = Variable<int>(versionNumber.value);
    }
    if (formatVersion.present) {
      map['format_version'] = Variable<int>(formatVersion.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (finalizedAtUtc.present) {
      map['finalized_at_utc'] = Variable<DateTime>(finalizedAtUtc.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentVersionsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('versionNumber: $versionNumber, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('finalizedAtUtc: $finalizedAtUtc, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackTypesTable extends PackTypes
    with TableInfo<$PackTypesTable, PackTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentVersionIdMeta = const VerificationMeta(
    'contentVersionId',
  );
  @override
  late final GeneratedColumn<String> contentVersionId = GeneratedColumn<String>(
    'content_version_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES content_versions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frontAssetIdMeta = const VerificationMeta(
    'frontAssetId',
  );
  @override
  late final GeneratedColumn<String> frontAssetId = GeneratedColumn<String>(
    'front_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_assets (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _backAssetIdMeta = const VerificationMeta(
    'backAssetId',
  );
  @override
  late final GeneratedColumn<String> backAssetId = GeneratedColumn<String>(
    'back_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_assets (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _cardCountMeta = const VerificationMeta(
    'cardCount',
  );
  @override
  late final GeneratedColumn<int> cardCount = GeneratedColumn<int>(
    'card_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rechargeSecondsMeta = const VerificationMeta(
    'rechargeSeconds',
  );
  @override
  late final GeneratedColumn<int> rechargeSeconds = GeneratedColumn<int>(
    'recharge_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxAccumulatedMeta = const VerificationMeta(
    'maxAccumulated',
  );
  @override
  late final GeneratedColumn<int> maxAccumulated = GeneratedColumn<int>(
    'max_accumulated',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isMainMeta = const VerificationMeta('isMain');
  @override
  late final GeneratedColumn<bool> isMain = GeneratedColumn<bool>(
    'is_main',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_main" IN (0, 1))',
    ),
  );
  static const VerificationMeta _coinsPerFullRechargeMeta =
      const VerificationMeta('coinsPerFullRecharge');
  @override
  late final GeneratedColumn<int> coinsPerFullRecharge = GeneratedColumn<int>(
    'coins_per_full_recharge',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortIndexMeta = const VerificationMeta(
    'sortIndex',
  );
  @override
  late final GeneratedColumn<int> sortIndex = GeneratedColumn<int>(
    'sort_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    contentVersionId,
    name,
    description,
    frontAssetId,
    backAssetId,
    cardCount,
    rechargeSeconds,
    maxAccumulated,
    isMain,
    coinsPerFullRecharge,
    sortIndex,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('content_version_id')) {
      context.handle(
        _contentVersionIdMeta,
        contentVersionId.isAcceptableOrUnknown(
          data['content_version_id']!,
          _contentVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('front_asset_id')) {
      context.handle(
        _frontAssetIdMeta,
        frontAssetId.isAcceptableOrUnknown(
          data['front_asset_id']!,
          _frontAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('back_asset_id')) {
      context.handle(
        _backAssetIdMeta,
        backAssetId.isAcceptableOrUnknown(
          data['back_asset_id']!,
          _backAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('card_count')) {
      context.handle(
        _cardCountMeta,
        cardCount.isAcceptableOrUnknown(data['card_count']!, _cardCountMeta),
      );
    } else if (isInserting) {
      context.missing(_cardCountMeta);
    }
    if (data.containsKey('recharge_seconds')) {
      context.handle(
        _rechargeSecondsMeta,
        rechargeSeconds.isAcceptableOrUnknown(
          data['recharge_seconds']!,
          _rechargeSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rechargeSecondsMeta);
    }
    if (data.containsKey('max_accumulated')) {
      context.handle(
        _maxAccumulatedMeta,
        maxAccumulated.isAcceptableOrUnknown(
          data['max_accumulated']!,
          _maxAccumulatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxAccumulatedMeta);
    }
    if (data.containsKey('is_main')) {
      context.handle(
        _isMainMeta,
        isMain.isAcceptableOrUnknown(data['is_main']!, _isMainMeta),
      );
    } else if (isInserting) {
      context.missing(_isMainMeta);
    }
    if (data.containsKey('coins_per_full_recharge')) {
      context.handle(
        _coinsPerFullRechargeMeta,
        coinsPerFullRecharge.isAcceptableOrUnknown(
          data['coins_per_full_recharge']!,
          _coinsPerFullRechargeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coinsPerFullRechargeMeta);
    }
    if (data.containsKey('sort_index')) {
      context.handle(
        _sortIndexMeta,
        sortIndex.isAcceptableOrUnknown(data['sort_index']!, _sortIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_sortIndexMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {contentVersionId, name},
    {contentVersionId, sortIndex},
  ];
  @override
  PackTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackTypeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      contentVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_version_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      frontAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}front_asset_id'],
      ),
      backAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}back_asset_id'],
      ),
      cardCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}card_count'],
      )!,
      rechargeSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recharge_seconds'],
      )!,
      maxAccumulated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_accumulated'],
      )!,
      isMain: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_main'],
      )!,
      coinsPerFullRecharge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins_per_full_recharge'],
      )!,
      sortIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_index'],
      )!,
    );
  }

  @override
  $PackTypesTable createAlias(String alias) {
    return $PackTypesTable(attachedDatabase, alias);
  }
}

class PackTypeRow extends DataClass implements Insertable<PackTypeRow> {
  final String id;
  final String collectionId;
  final String contentVersionId;
  final String name;
  final String? description;
  final String? frontAssetId;
  final String? backAssetId;
  final int cardCount;
  final int rechargeSeconds;
  final int maxAccumulated;
  final bool isMain;
  final int coinsPerFullRecharge;
  final int sortIndex;
  const PackTypeRow({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required this.name,
    this.description,
    this.frontAssetId,
    this.backAssetId,
    required this.cardCount,
    required this.rechargeSeconds,
    required this.maxAccumulated,
    required this.isMain,
    required this.coinsPerFullRecharge,
    required this.sortIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['content_version_id'] = Variable<String>(contentVersionId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || frontAssetId != null) {
      map['front_asset_id'] = Variable<String>(frontAssetId);
    }
    if (!nullToAbsent || backAssetId != null) {
      map['back_asset_id'] = Variable<String>(backAssetId);
    }
    map['card_count'] = Variable<int>(cardCount);
    map['recharge_seconds'] = Variable<int>(rechargeSeconds);
    map['max_accumulated'] = Variable<int>(maxAccumulated);
    map['is_main'] = Variable<bool>(isMain);
    map['coins_per_full_recharge'] = Variable<int>(coinsPerFullRecharge);
    map['sort_index'] = Variable<int>(sortIndex);
    return map;
  }

  PackTypesCompanion toCompanion(bool nullToAbsent) {
    return PackTypesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      contentVersionId: Value(contentVersionId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      frontAssetId: frontAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(frontAssetId),
      backAssetId: backAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(backAssetId),
      cardCount: Value(cardCount),
      rechargeSeconds: Value(rechargeSeconds),
      maxAccumulated: Value(maxAccumulated),
      isMain: Value(isMain),
      coinsPerFullRecharge: Value(coinsPerFullRecharge),
      sortIndex: Value(sortIndex),
    );
  }

  factory PackTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackTypeRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      contentVersionId: serializer.fromJson<String>(json['contentVersionId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      frontAssetId: serializer.fromJson<String?>(json['frontAssetId']),
      backAssetId: serializer.fromJson<String?>(json['backAssetId']),
      cardCount: serializer.fromJson<int>(json['cardCount']),
      rechargeSeconds: serializer.fromJson<int>(json['rechargeSeconds']),
      maxAccumulated: serializer.fromJson<int>(json['maxAccumulated']),
      isMain: serializer.fromJson<bool>(json['isMain']),
      coinsPerFullRecharge: serializer.fromJson<int>(
        json['coinsPerFullRecharge'],
      ),
      sortIndex: serializer.fromJson<int>(json['sortIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'contentVersionId': serializer.toJson<String>(contentVersionId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'frontAssetId': serializer.toJson<String?>(frontAssetId),
      'backAssetId': serializer.toJson<String?>(backAssetId),
      'cardCount': serializer.toJson<int>(cardCount),
      'rechargeSeconds': serializer.toJson<int>(rechargeSeconds),
      'maxAccumulated': serializer.toJson<int>(maxAccumulated),
      'isMain': serializer.toJson<bool>(isMain),
      'coinsPerFullRecharge': serializer.toJson<int>(coinsPerFullRecharge),
      'sortIndex': serializer.toJson<int>(sortIndex),
    };
  }

  PackTypeRow copyWith({
    String? id,
    String? collectionId,
    String? contentVersionId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> frontAssetId = const Value.absent(),
    Value<String?> backAssetId = const Value.absent(),
    int? cardCount,
    int? rechargeSeconds,
    int? maxAccumulated,
    bool? isMain,
    int? coinsPerFullRecharge,
    int? sortIndex,
  }) => PackTypeRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    contentVersionId: contentVersionId ?? this.contentVersionId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    frontAssetId: frontAssetId.present ? frontAssetId.value : this.frontAssetId,
    backAssetId: backAssetId.present ? backAssetId.value : this.backAssetId,
    cardCount: cardCount ?? this.cardCount,
    rechargeSeconds: rechargeSeconds ?? this.rechargeSeconds,
    maxAccumulated: maxAccumulated ?? this.maxAccumulated,
    isMain: isMain ?? this.isMain,
    coinsPerFullRecharge: coinsPerFullRecharge ?? this.coinsPerFullRecharge,
    sortIndex: sortIndex ?? this.sortIndex,
  );
  PackTypeRow copyWithCompanion(PackTypesCompanion data) {
    return PackTypeRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      contentVersionId: data.contentVersionId.present
          ? data.contentVersionId.value
          : this.contentVersionId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      frontAssetId: data.frontAssetId.present
          ? data.frontAssetId.value
          : this.frontAssetId,
      backAssetId: data.backAssetId.present
          ? data.backAssetId.value
          : this.backAssetId,
      cardCount: data.cardCount.present ? data.cardCount.value : this.cardCount,
      rechargeSeconds: data.rechargeSeconds.present
          ? data.rechargeSeconds.value
          : this.rechargeSeconds,
      maxAccumulated: data.maxAccumulated.present
          ? data.maxAccumulated.value
          : this.maxAccumulated,
      isMain: data.isMain.present ? data.isMain.value : this.isMain,
      coinsPerFullRecharge: data.coinsPerFullRecharge.present
          ? data.coinsPerFullRecharge.value
          : this.coinsPerFullRecharge,
      sortIndex: data.sortIndex.present ? data.sortIndex.value : this.sortIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackTypeRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('frontAssetId: $frontAssetId, ')
          ..write('backAssetId: $backAssetId, ')
          ..write('cardCount: $cardCount, ')
          ..write('rechargeSeconds: $rechargeSeconds, ')
          ..write('maxAccumulated: $maxAccumulated, ')
          ..write('isMain: $isMain, ')
          ..write('coinsPerFullRecharge: $coinsPerFullRecharge, ')
          ..write('sortIndex: $sortIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    contentVersionId,
    name,
    description,
    frontAssetId,
    backAssetId,
    cardCount,
    rechargeSeconds,
    maxAccumulated,
    isMain,
    coinsPerFullRecharge,
    sortIndex,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackTypeRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.contentVersionId == this.contentVersionId &&
          other.name == this.name &&
          other.description == this.description &&
          other.frontAssetId == this.frontAssetId &&
          other.backAssetId == this.backAssetId &&
          other.cardCount == this.cardCount &&
          other.rechargeSeconds == this.rechargeSeconds &&
          other.maxAccumulated == this.maxAccumulated &&
          other.isMain == this.isMain &&
          other.coinsPerFullRecharge == this.coinsPerFullRecharge &&
          other.sortIndex == this.sortIndex);
}

class PackTypesCompanion extends UpdateCompanion<PackTypeRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> contentVersionId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> frontAssetId;
  final Value<String?> backAssetId;
  final Value<int> cardCount;
  final Value<int> rechargeSeconds;
  final Value<int> maxAccumulated;
  final Value<bool> isMain;
  final Value<int> coinsPerFullRecharge;
  final Value<int> sortIndex;
  final Value<int> rowid;
  const PackTypesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.contentVersionId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.frontAssetId = const Value.absent(),
    this.backAssetId = const Value.absent(),
    this.cardCount = const Value.absent(),
    this.rechargeSeconds = const Value.absent(),
    this.maxAccumulated = const Value.absent(),
    this.isMain = const Value.absent(),
    this.coinsPerFullRecharge = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackTypesCompanion.insert({
    required String id,
    required String collectionId,
    required String contentVersionId,
    required String name,
    this.description = const Value.absent(),
    this.frontAssetId = const Value.absent(),
    this.backAssetId = const Value.absent(),
    required int cardCount,
    required int rechargeSeconds,
    required int maxAccumulated,
    required bool isMain,
    required int coinsPerFullRecharge,
    required int sortIndex,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       contentVersionId = Value(contentVersionId),
       name = Value(name),
       cardCount = Value(cardCount),
       rechargeSeconds = Value(rechargeSeconds),
       maxAccumulated = Value(maxAccumulated),
       isMain = Value(isMain),
       coinsPerFullRecharge = Value(coinsPerFullRecharge),
       sortIndex = Value(sortIndex);
  static Insertable<PackTypeRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? contentVersionId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? frontAssetId,
    Expression<String>? backAssetId,
    Expression<int>? cardCount,
    Expression<int>? rechargeSeconds,
    Expression<int>? maxAccumulated,
    Expression<bool>? isMain,
    Expression<int>? coinsPerFullRecharge,
    Expression<int>? sortIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (contentVersionId != null) 'content_version_id': contentVersionId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (frontAssetId != null) 'front_asset_id': frontAssetId,
      if (backAssetId != null) 'back_asset_id': backAssetId,
      if (cardCount != null) 'card_count': cardCount,
      if (rechargeSeconds != null) 'recharge_seconds': rechargeSeconds,
      if (maxAccumulated != null) 'max_accumulated': maxAccumulated,
      if (isMain != null) 'is_main': isMain,
      if (coinsPerFullRecharge != null)
        'coins_per_full_recharge': coinsPerFullRecharge,
      if (sortIndex != null) 'sort_index': sortIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackTypesCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? contentVersionId,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? frontAssetId,
    Value<String?>? backAssetId,
    Value<int>? cardCount,
    Value<int>? rechargeSeconds,
    Value<int>? maxAccumulated,
    Value<bool>? isMain,
    Value<int>? coinsPerFullRecharge,
    Value<int>? sortIndex,
    Value<int>? rowid,
  }) {
    return PackTypesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      contentVersionId: contentVersionId ?? this.contentVersionId,
      name: name ?? this.name,
      description: description ?? this.description,
      frontAssetId: frontAssetId ?? this.frontAssetId,
      backAssetId: backAssetId ?? this.backAssetId,
      cardCount: cardCount ?? this.cardCount,
      rechargeSeconds: rechargeSeconds ?? this.rechargeSeconds,
      maxAccumulated: maxAccumulated ?? this.maxAccumulated,
      isMain: isMain ?? this.isMain,
      coinsPerFullRecharge: coinsPerFullRecharge ?? this.coinsPerFullRecharge,
      sortIndex: sortIndex ?? this.sortIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (contentVersionId.present) {
      map['content_version_id'] = Variable<String>(contentVersionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (frontAssetId.present) {
      map['front_asset_id'] = Variable<String>(frontAssetId.value);
    }
    if (backAssetId.present) {
      map['back_asset_id'] = Variable<String>(backAssetId.value);
    }
    if (cardCount.present) {
      map['card_count'] = Variable<int>(cardCount.value);
    }
    if (rechargeSeconds.present) {
      map['recharge_seconds'] = Variable<int>(rechargeSeconds.value);
    }
    if (maxAccumulated.present) {
      map['max_accumulated'] = Variable<int>(maxAccumulated.value);
    }
    if (isMain.present) {
      map['is_main'] = Variable<bool>(isMain.value);
    }
    if (coinsPerFullRecharge.present) {
      map['coins_per_full_recharge'] = Variable<int>(
        coinsPerFullRecharge.value,
      );
    }
    if (sortIndex.present) {
      map['sort_index'] = Variable<int>(sortIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackTypesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('frontAssetId: $frontAssetId, ')
          ..write('backAssetId: $backAssetId, ')
          ..write('cardCount: $cardCount, ')
          ..write('rechargeSeconds: $rechargeSeconds, ')
          ..write('maxAccumulated: $maxAccumulated, ')
          ..write('isMain: $isMain, ')
          ..write('coinsPerFullRecharge: $coinsPerFullRecharge, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionProjectsTable extends CollectionProjects
    with TableInfo<$CollectionProjectsTable, CollectionProjectRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverAssetIdMeta = const VerificationMeta(
    'coverAssetId',
  );
  @override
  late final GeneratedColumn<String> coverAssetId = GeneratedColumn<String>(
    'cover_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_assets (id) ON DELETE SET NULL',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CollectionProjectStatus, String>
  status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CollectionProjectStatus>(
        $CollectionProjectsTable.$converterstatus,
      );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtUtcMeta = const VerificationMeta(
    'updatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtUtc = GeneratedColumn<DateTime>(
    'updated_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentContentVersionMeta =
      const VerificationMeta('currentContentVersion');
  @override
  late final GeneratedColumn<int> currentContentVersion = GeneratedColumn<int>(
    'current_content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentContentVersionIdMeta =
      const VerificationMeta('currentContentVersionId');
  @override
  late final GeneratedColumn<String> currentContentVersionId =
      GeneratedColumn<String>(
        'current_content_version_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES content_versions (id) ON DELETE RESTRICT',
        ),
      );
  static const VerificationMeta _mainPackTypeIdMeta = const VerificationMeta(
    'mainPackTypeId',
  );
  @override
  late final GeneratedColumn<String> mainPackTypeId = GeneratedColumn<String>(
    'main_pack_type_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_types (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _startingPackCountMeta = const VerificationMeta(
    'startingPackCount',
  );
  @override
  late final GeneratedColumn<int> startingPackCount = GeneratedColumn<int>(
    'starting_pack_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    name,
    author,
    description,
    coverAssetId,
    status,
    createdAtUtc,
    updatedAtUtc,
    currentContentVersion,
    currentContentVersionId,
    mainPackTypeId,
    startingPackCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionProjectRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('cover_asset_id')) {
      context.handle(
        _coverAssetIdMeta,
        coverAssetId.isAcceptableOrUnknown(
          data['cover_asset_id']!,
          _coverAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
        _updatedAtUtcMeta,
        updatedAtUtc.isAcceptableOrUnknown(
          data['updated_at_utc']!,
          _updatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    if (data.containsKey('current_content_version')) {
      context.handle(
        _currentContentVersionMeta,
        currentContentVersion.isAcceptableOrUnknown(
          data['current_content_version']!,
          _currentContentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentContentVersionMeta);
    }
    if (data.containsKey('current_content_version_id')) {
      context.handle(
        _currentContentVersionIdMeta,
        currentContentVersionId.isAcceptableOrUnknown(
          data['current_content_version_id']!,
          _currentContentVersionIdMeta,
        ),
      );
    }
    if (data.containsKey('main_pack_type_id')) {
      context.handle(
        _mainPackTypeIdMeta,
        mainPackTypeId.isAcceptableOrUnknown(
          data['main_pack_type_id']!,
          _mainPackTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('starting_pack_count')) {
      context.handle(
        _startingPackCountMeta,
        startingPackCount.isAcceptableOrUnknown(
          data['starting_pack_count']!,
          _startingPackCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startingPackCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionProjectRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionProjectRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      coverAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_asset_id'],
      ),
      status: $CollectionProjectsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      updatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_utc'],
      )!,
      currentContentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_content_version'],
      )!,
      currentContentVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_content_version_id'],
      ),
      mainPackTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_pack_type_id'],
      ),
      startingPackCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}starting_pack_count'],
      )!,
    );
  }

  @override
  $CollectionProjectsTable createAlias(String alias) {
    return $CollectionProjectsTable(attachedDatabase, alias);
  }

  static TypeConverter<CollectionProjectStatus, String> $converterstatus =
      const CollectionProjectStatusConverter();
}

class CollectionProjectRow extends DataClass
    implements Insertable<CollectionProjectRow> {
  final String id;
  final String collectionId;
  final String name;
  final String? author;
  final String? description;
  final String? coverAssetId;
  final CollectionProjectStatus status;
  final DateTime createdAtUtc;
  final DateTime updatedAtUtc;
  final int currentContentVersion;
  final String? currentContentVersionId;
  final String? mainPackTypeId;
  final int startingPackCount;
  const CollectionProjectRow({
    required this.id,
    required this.collectionId,
    required this.name,
    this.author,
    this.description,
    this.coverAssetId,
    required this.status,
    required this.createdAtUtc,
    required this.updatedAtUtc,
    required this.currentContentVersion,
    this.currentContentVersionId,
    this.mainPackTypeId,
    required this.startingPackCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || coverAssetId != null) {
      map['cover_asset_id'] = Variable<String>(coverAssetId);
    }
    {
      map['status'] = Variable<String>(
        $CollectionProjectsTable.$converterstatus.toSql(status),
      );
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc);
    map['current_content_version'] = Variable<int>(currentContentVersion);
    if (!nullToAbsent || currentContentVersionId != null) {
      map['current_content_version_id'] = Variable<String>(
        currentContentVersionId,
      );
    }
    if (!nullToAbsent || mainPackTypeId != null) {
      map['main_pack_type_id'] = Variable<String>(mainPackTypeId);
    }
    map['starting_pack_count'] = Variable<int>(startingPackCount);
    return map;
  }

  CollectionProjectsCompanion toCompanion(bool nullToAbsent) {
    return CollectionProjectsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      name: Value(name),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      coverAssetId: coverAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(coverAssetId),
      status: Value(status),
      createdAtUtc: Value(createdAtUtc),
      updatedAtUtc: Value(updatedAtUtc),
      currentContentVersion: Value(currentContentVersion),
      currentContentVersionId: currentContentVersionId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentContentVersionId),
      mainPackTypeId: mainPackTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(mainPackTypeId),
      startingPackCount: Value(startingPackCount),
    );
  }

  factory CollectionProjectRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionProjectRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      coverAssetId: serializer.fromJson<String?>(json['coverAssetId']),
      status: serializer.fromJson<CollectionProjectStatus>(json['status']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      updatedAtUtc: serializer.fromJson<DateTime>(json['updatedAtUtc']),
      currentContentVersion: serializer.fromJson<int>(
        json['currentContentVersion'],
      ),
      currentContentVersionId: serializer.fromJson<String?>(
        json['currentContentVersionId'],
      ),
      mainPackTypeId: serializer.fromJson<String?>(json['mainPackTypeId']),
      startingPackCount: serializer.fromJson<int>(json['startingPackCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'coverAssetId': serializer.toJson<String?>(coverAssetId),
      'status': serializer.toJson<CollectionProjectStatus>(status),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'updatedAtUtc': serializer.toJson<DateTime>(updatedAtUtc),
      'currentContentVersion': serializer.toJson<int>(currentContentVersion),
      'currentContentVersionId': serializer.toJson<String?>(
        currentContentVersionId,
      ),
      'mainPackTypeId': serializer.toJson<String?>(mainPackTypeId),
      'startingPackCount': serializer.toJson<int>(startingPackCount),
    };
  }

  CollectionProjectRow copyWith({
    String? id,
    String? collectionId,
    String? name,
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> coverAssetId = const Value.absent(),
    CollectionProjectStatus? status,
    DateTime? createdAtUtc,
    DateTime? updatedAtUtc,
    int? currentContentVersion,
    Value<String?> currentContentVersionId = const Value.absent(),
    Value<String?> mainPackTypeId = const Value.absent(),
    int? startingPackCount,
  }) => CollectionProjectRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    name: name ?? this.name,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    coverAssetId: coverAssetId.present ? coverAssetId.value : this.coverAssetId,
    status: status ?? this.status,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
    currentContentVersion: currentContentVersion ?? this.currentContentVersion,
    currentContentVersionId: currentContentVersionId.present
        ? currentContentVersionId.value
        : this.currentContentVersionId,
    mainPackTypeId: mainPackTypeId.present
        ? mainPackTypeId.value
        : this.mainPackTypeId,
    startingPackCount: startingPackCount ?? this.startingPackCount,
  );
  CollectionProjectRow copyWithCompanion(CollectionProjectsCompanion data) {
    return CollectionProjectRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      name: data.name.present ? data.name.value : this.name,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      coverAssetId: data.coverAssetId.present
          ? data.coverAssetId.value
          : this.coverAssetId,
      status: data.status.present ? data.status.value : this.status,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
      currentContentVersion: data.currentContentVersion.present
          ? data.currentContentVersion.value
          : this.currentContentVersion,
      currentContentVersionId: data.currentContentVersionId.present
          ? data.currentContentVersionId.value
          : this.currentContentVersionId,
      mainPackTypeId: data.mainPackTypeId.present
          ? data.mainPackTypeId.value
          : this.mainPackTypeId,
      startingPackCount: data.startingPackCount.present
          ? data.startingPackCount.value
          : this.startingPackCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionProjectRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverAssetId: $coverAssetId, ')
          ..write('status: $status, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('currentContentVersion: $currentContentVersion, ')
          ..write('currentContentVersionId: $currentContentVersionId, ')
          ..write('mainPackTypeId: $mainPackTypeId, ')
          ..write('startingPackCount: $startingPackCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    name,
    author,
    description,
    coverAssetId,
    status,
    createdAtUtc,
    updatedAtUtc,
    currentContentVersion,
    currentContentVersionId,
    mainPackTypeId,
    startingPackCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionProjectRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.name == this.name &&
          other.author == this.author &&
          other.description == this.description &&
          other.coverAssetId == this.coverAssetId &&
          other.status == this.status &&
          other.createdAtUtc == this.createdAtUtc &&
          other.updatedAtUtc == this.updatedAtUtc &&
          other.currentContentVersion == this.currentContentVersion &&
          other.currentContentVersionId == this.currentContentVersionId &&
          other.mainPackTypeId == this.mainPackTypeId &&
          other.startingPackCount == this.startingPackCount);
}

class CollectionProjectsCompanion
    extends UpdateCompanion<CollectionProjectRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> name;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String?> coverAssetId;
  final Value<CollectionProjectStatus> status;
  final Value<DateTime> createdAtUtc;
  final Value<DateTime> updatedAtUtc;
  final Value<int> currentContentVersion;
  final Value<String?> currentContentVersionId;
  final Value<String?> mainPackTypeId;
  final Value<int> startingPackCount;
  final Value<int> rowid;
  const CollectionProjectsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.coverAssetId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
    this.currentContentVersion = const Value.absent(),
    this.currentContentVersionId = const Value.absent(),
    this.mainPackTypeId = const Value.absent(),
    this.startingPackCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionProjectsCompanion.insert({
    required String id,
    required String collectionId,
    required String name,
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.coverAssetId = const Value.absent(),
    required CollectionProjectStatus status,
    required DateTime createdAtUtc,
    required DateTime updatedAtUtc,
    required int currentContentVersion,
    this.currentContentVersionId = const Value.absent(),
    this.mainPackTypeId = const Value.absent(),
    required int startingPackCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       name = Value(name),
       status = Value(status),
       createdAtUtc = Value(createdAtUtc),
       updatedAtUtc = Value(updatedAtUtc),
       currentContentVersion = Value(currentContentVersion),
       startingPackCount = Value(startingPackCount);
  static Insertable<CollectionProjectRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? name,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? coverAssetId,
    Expression<String>? status,
    Expression<DateTime>? createdAtUtc,
    Expression<DateTime>? updatedAtUtc,
    Expression<int>? currentContentVersion,
    Expression<String>? currentContentVersionId,
    Expression<String>? mainPackTypeId,
    Expression<int>? startingPackCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (coverAssetId != null) 'cover_asset_id': coverAssetId,
      if (status != null) 'status': status,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
      if (currentContentVersion != null)
        'current_content_version': currentContentVersion,
      if (currentContentVersionId != null)
        'current_content_version_id': currentContentVersionId,
      if (mainPackTypeId != null) 'main_pack_type_id': mainPackTypeId,
      if (startingPackCount != null) 'starting_pack_count': startingPackCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionProjectsCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? name,
    Value<String?>? author,
    Value<String?>? description,
    Value<String?>? coverAssetId,
    Value<CollectionProjectStatus>? status,
    Value<DateTime>? createdAtUtc,
    Value<DateTime>? updatedAtUtc,
    Value<int>? currentContentVersion,
    Value<String?>? currentContentVersionId,
    Value<String?>? mainPackTypeId,
    Value<int>? startingPackCount,
    Value<int>? rowid,
  }) {
    return CollectionProjectsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      name: name ?? this.name,
      author: author ?? this.author,
      description: description ?? this.description,
      coverAssetId: coverAssetId ?? this.coverAssetId,
      status: status ?? this.status,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      currentContentVersion:
          currentContentVersion ?? this.currentContentVersion,
      currentContentVersionId:
          currentContentVersionId ?? this.currentContentVersionId,
      mainPackTypeId: mainPackTypeId ?? this.mainPackTypeId,
      startingPackCount: startingPackCount ?? this.startingPackCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverAssetId.present) {
      map['cover_asset_id'] = Variable<String>(coverAssetId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $CollectionProjectsTable.$converterstatus.toSql(status.value),
      );
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc.value);
    }
    if (currentContentVersion.present) {
      map['current_content_version'] = Variable<int>(
        currentContentVersion.value,
      );
    }
    if (currentContentVersionId.present) {
      map['current_content_version_id'] = Variable<String>(
        currentContentVersionId.value,
      );
    }
    if (mainPackTypeId.present) {
      map['main_pack_type_id'] = Variable<String>(mainPackTypeId.value);
    }
    if (startingPackCount.present) {
      map['starting_pack_count'] = Variable<int>(startingPackCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionProjectsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverAssetId: $coverAssetId, ')
          ..write('status: $status, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('currentContentVersion: $currentContentVersion, ')
          ..write('currentContentVersionId: $currentContentVersionId, ')
          ..write('mainPackTypeId: $mainPackTypeId, ')
          ..write('startingPackCount: $startingPackCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InstalledCollectionsTable extends InstalledCollections
    with TableInfo<$InstalledCollectionsTable, InstalledCollectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InstalledCollectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentVersionIdMeta = const VerificationMeta(
    'contentVersionId',
  );
  @override
  late final GeneratedColumn<String> contentVersionId = GeneratedColumn<String>(
    'content_version_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES content_versions (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverRelativePathMeta = const VerificationMeta(
    'coverRelativePath',
  );
  @override
  late final GeneratedColumn<String> coverRelativePath =
      GeneratedColumn<String>(
        'cover_relative_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _mainPackTypeIdMeta = const VerificationMeta(
    'mainPackTypeId',
  );
  @override
  late final GeneratedColumn<String> mainPackTypeId = GeneratedColumn<String>(
    'main_pack_type_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_types (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _installedAtUtcMeta = const VerificationMeta(
    'installedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> installedAtUtc =
      GeneratedColumn<DateTime>(
        'installed_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  late final GeneratedColumnWithTypeConverter<InstalledCollectionSource, String>
  source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InstalledCollectionSource>(
        $InstalledCollectionsTable.$convertersource,
      );
  static const VerificationMeta _coinsMeta = const VerificationMeta('coins');
  @override
  late final GeneratedColumn<int> coins = GeneratedColumn<int>(
    'coins',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCardCountMeta = const VerificationMeta(
    'totalCardCount',
  );
  @override
  late final GeneratedColumn<int> totalCardCount = GeneratedColumn<int>(
    'total_card_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distinctOwnedCountMeta =
      const VerificationMeta('distinctOwnedCount');
  @override
  late final GeneratedColumn<int> distinctOwnedCount = GeneratedColumn<int>(
    'distinct_owned_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    contentVersionId,
    name,
    author,
    description,
    coverRelativePath,
    mainPackTypeId,
    installedAtUtc,
    source,
    coins,
    totalCardCount,
    distinctOwnedCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'installed_collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<InstalledCollectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('content_version_id')) {
      context.handle(
        _contentVersionIdMeta,
        contentVersionId.isAcceptableOrUnknown(
          data['content_version_id']!,
          _contentVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('cover_relative_path')) {
      context.handle(
        _coverRelativePathMeta,
        coverRelativePath.isAcceptableOrUnknown(
          data['cover_relative_path']!,
          _coverRelativePathMeta,
        ),
      );
    }
    if (data.containsKey('main_pack_type_id')) {
      context.handle(
        _mainPackTypeIdMeta,
        mainPackTypeId.isAcceptableOrUnknown(
          data['main_pack_type_id']!,
          _mainPackTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('installed_at_utc')) {
      context.handle(
        _installedAtUtcMeta,
        installedAtUtc.isAcceptableOrUnknown(
          data['installed_at_utc']!,
          _installedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedAtUtcMeta);
    }
    if (data.containsKey('coins')) {
      context.handle(
        _coinsMeta,
        coins.isAcceptableOrUnknown(data['coins']!, _coinsMeta),
      );
    } else if (isInserting) {
      context.missing(_coinsMeta);
    }
    if (data.containsKey('total_card_count')) {
      context.handle(
        _totalCardCountMeta,
        totalCardCount.isAcceptableOrUnknown(
          data['total_card_count']!,
          _totalCardCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalCardCountMeta);
    }
    if (data.containsKey('distinct_owned_count')) {
      context.handle(
        _distinctOwnedCountMeta,
        distinctOwnedCount.isAcceptableOrUnknown(
          data['distinct_owned_count']!,
          _distinctOwnedCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_distinctOwnedCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {collectionId, contentVersionId},
  ];
  @override
  InstalledCollectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InstalledCollectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      contentVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_version_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      coverRelativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_relative_path'],
      ),
      mainPackTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_pack_type_id'],
      ),
      installedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}installed_at_utc'],
      )!,
      source: $InstalledCollectionsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      coins: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}coins'],
      )!,
      totalCardCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_card_count'],
      )!,
      distinctOwnedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}distinct_owned_count'],
      )!,
    );
  }

  @override
  $InstalledCollectionsTable createAlias(String alias) {
    return $InstalledCollectionsTable(attachedDatabase, alias);
  }

  static TypeConverter<InstalledCollectionSource, String> $convertersource =
      const InstalledCollectionSourceConverter();
}

class InstalledCollectionRow extends DataClass
    implements Insertable<InstalledCollectionRow> {
  final String id;
  final String collectionId;
  final String contentVersionId;
  final String name;
  final String? author;
  final String? description;
  final String? coverRelativePath;
  final String? mainPackTypeId;
  final DateTime installedAtUtc;
  final InstalledCollectionSource source;
  final int coins;
  final int totalCardCount;
  final int distinctOwnedCount;
  const InstalledCollectionRow({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required this.name,
    this.author,
    this.description,
    this.coverRelativePath,
    this.mainPackTypeId,
    required this.installedAtUtc,
    required this.source,
    required this.coins,
    required this.totalCardCount,
    required this.distinctOwnedCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['content_version_id'] = Variable<String>(contentVersionId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || coverRelativePath != null) {
      map['cover_relative_path'] = Variable<String>(coverRelativePath);
    }
    if (!nullToAbsent || mainPackTypeId != null) {
      map['main_pack_type_id'] = Variable<String>(mainPackTypeId);
    }
    map['installed_at_utc'] = Variable<DateTime>(installedAtUtc);
    {
      map['source'] = Variable<String>(
        $InstalledCollectionsTable.$convertersource.toSql(source),
      );
    }
    map['coins'] = Variable<int>(coins);
    map['total_card_count'] = Variable<int>(totalCardCount);
    map['distinct_owned_count'] = Variable<int>(distinctOwnedCount);
    return map;
  }

  InstalledCollectionsCompanion toCompanion(bool nullToAbsent) {
    return InstalledCollectionsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      contentVersionId: Value(contentVersionId),
      name: Value(name),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      coverRelativePath: coverRelativePath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverRelativePath),
      mainPackTypeId: mainPackTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(mainPackTypeId),
      installedAtUtc: Value(installedAtUtc),
      source: Value(source),
      coins: Value(coins),
      totalCardCount: Value(totalCardCount),
      distinctOwnedCount: Value(distinctOwnedCount),
    );
  }

  factory InstalledCollectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InstalledCollectionRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      contentVersionId: serializer.fromJson<String>(json['contentVersionId']),
      name: serializer.fromJson<String>(json['name']),
      author: serializer.fromJson<String?>(json['author']),
      description: serializer.fromJson<String?>(json['description']),
      coverRelativePath: serializer.fromJson<String?>(
        json['coverRelativePath'],
      ),
      mainPackTypeId: serializer.fromJson<String?>(json['mainPackTypeId']),
      installedAtUtc: serializer.fromJson<DateTime>(json['installedAtUtc']),
      source: serializer.fromJson<InstalledCollectionSource>(json['source']),
      coins: serializer.fromJson<int>(json['coins']),
      totalCardCount: serializer.fromJson<int>(json['totalCardCount']),
      distinctOwnedCount: serializer.fromJson<int>(json['distinctOwnedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'contentVersionId': serializer.toJson<String>(contentVersionId),
      'name': serializer.toJson<String>(name),
      'author': serializer.toJson<String?>(author),
      'description': serializer.toJson<String?>(description),
      'coverRelativePath': serializer.toJson<String?>(coverRelativePath),
      'mainPackTypeId': serializer.toJson<String?>(mainPackTypeId),
      'installedAtUtc': serializer.toJson<DateTime>(installedAtUtc),
      'source': serializer.toJson<InstalledCollectionSource>(source),
      'coins': serializer.toJson<int>(coins),
      'totalCardCount': serializer.toJson<int>(totalCardCount),
      'distinctOwnedCount': serializer.toJson<int>(distinctOwnedCount),
    };
  }

  InstalledCollectionRow copyWith({
    String? id,
    String? collectionId,
    String? contentVersionId,
    String? name,
    Value<String?> author = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> coverRelativePath = const Value.absent(),
    Value<String?> mainPackTypeId = const Value.absent(),
    DateTime? installedAtUtc,
    InstalledCollectionSource? source,
    int? coins,
    int? totalCardCount,
    int? distinctOwnedCount,
  }) => InstalledCollectionRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    contentVersionId: contentVersionId ?? this.contentVersionId,
    name: name ?? this.name,
    author: author.present ? author.value : this.author,
    description: description.present ? description.value : this.description,
    coverRelativePath: coverRelativePath.present
        ? coverRelativePath.value
        : this.coverRelativePath,
    mainPackTypeId: mainPackTypeId.present
        ? mainPackTypeId.value
        : this.mainPackTypeId,
    installedAtUtc: installedAtUtc ?? this.installedAtUtc,
    source: source ?? this.source,
    coins: coins ?? this.coins,
    totalCardCount: totalCardCount ?? this.totalCardCount,
    distinctOwnedCount: distinctOwnedCount ?? this.distinctOwnedCount,
  );
  InstalledCollectionRow copyWithCompanion(InstalledCollectionsCompanion data) {
    return InstalledCollectionRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      contentVersionId: data.contentVersionId.present
          ? data.contentVersionId.value
          : this.contentVersionId,
      name: data.name.present ? data.name.value : this.name,
      author: data.author.present ? data.author.value : this.author,
      description: data.description.present
          ? data.description.value
          : this.description,
      coverRelativePath: data.coverRelativePath.present
          ? data.coverRelativePath.value
          : this.coverRelativePath,
      mainPackTypeId: data.mainPackTypeId.present
          ? data.mainPackTypeId.value
          : this.mainPackTypeId,
      installedAtUtc: data.installedAtUtc.present
          ? data.installedAtUtc.value
          : this.installedAtUtc,
      source: data.source.present ? data.source.value : this.source,
      coins: data.coins.present ? data.coins.value : this.coins,
      totalCardCount: data.totalCardCount.present
          ? data.totalCardCount.value
          : this.totalCardCount,
      distinctOwnedCount: data.distinctOwnedCount.present
          ? data.distinctOwnedCount.value
          : this.distinctOwnedCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InstalledCollectionRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverRelativePath: $coverRelativePath, ')
          ..write('mainPackTypeId: $mainPackTypeId, ')
          ..write('installedAtUtc: $installedAtUtc, ')
          ..write('source: $source, ')
          ..write('coins: $coins, ')
          ..write('totalCardCount: $totalCardCount, ')
          ..write('distinctOwnedCount: $distinctOwnedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    contentVersionId,
    name,
    author,
    description,
    coverRelativePath,
    mainPackTypeId,
    installedAtUtc,
    source,
    coins,
    totalCardCount,
    distinctOwnedCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InstalledCollectionRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.contentVersionId == this.contentVersionId &&
          other.name == this.name &&
          other.author == this.author &&
          other.description == this.description &&
          other.coverRelativePath == this.coverRelativePath &&
          other.mainPackTypeId == this.mainPackTypeId &&
          other.installedAtUtc == this.installedAtUtc &&
          other.source == this.source &&
          other.coins == this.coins &&
          other.totalCardCount == this.totalCardCount &&
          other.distinctOwnedCount == this.distinctOwnedCount);
}

class InstalledCollectionsCompanion
    extends UpdateCompanion<InstalledCollectionRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> contentVersionId;
  final Value<String> name;
  final Value<String?> author;
  final Value<String?> description;
  final Value<String?> coverRelativePath;
  final Value<String?> mainPackTypeId;
  final Value<DateTime> installedAtUtc;
  final Value<InstalledCollectionSource> source;
  final Value<int> coins;
  final Value<int> totalCardCount;
  final Value<int> distinctOwnedCount;
  final Value<int> rowid;
  const InstalledCollectionsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.contentVersionId = const Value.absent(),
    this.name = const Value.absent(),
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.coverRelativePath = const Value.absent(),
    this.mainPackTypeId = const Value.absent(),
    this.installedAtUtc = const Value.absent(),
    this.source = const Value.absent(),
    this.coins = const Value.absent(),
    this.totalCardCount = const Value.absent(),
    this.distinctOwnedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InstalledCollectionsCompanion.insert({
    required String id,
    required String collectionId,
    required String contentVersionId,
    required String name,
    this.author = const Value.absent(),
    this.description = const Value.absent(),
    this.coverRelativePath = const Value.absent(),
    this.mainPackTypeId = const Value.absent(),
    required DateTime installedAtUtc,
    required InstalledCollectionSource source,
    required int coins,
    required int totalCardCount,
    required int distinctOwnedCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       contentVersionId = Value(contentVersionId),
       name = Value(name),
       installedAtUtc = Value(installedAtUtc),
       source = Value(source),
       coins = Value(coins),
       totalCardCount = Value(totalCardCount),
       distinctOwnedCount = Value(distinctOwnedCount);
  static Insertable<InstalledCollectionRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? contentVersionId,
    Expression<String>? name,
    Expression<String>? author,
    Expression<String>? description,
    Expression<String>? coverRelativePath,
    Expression<String>? mainPackTypeId,
    Expression<DateTime>? installedAtUtc,
    Expression<String>? source,
    Expression<int>? coins,
    Expression<int>? totalCardCount,
    Expression<int>? distinctOwnedCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (contentVersionId != null) 'content_version_id': contentVersionId,
      if (name != null) 'name': name,
      if (author != null) 'author': author,
      if (description != null) 'description': description,
      if (coverRelativePath != null) 'cover_relative_path': coverRelativePath,
      if (mainPackTypeId != null) 'main_pack_type_id': mainPackTypeId,
      if (installedAtUtc != null) 'installed_at_utc': installedAtUtc,
      if (source != null) 'source': source,
      if (coins != null) 'coins': coins,
      if (totalCardCount != null) 'total_card_count': totalCardCount,
      if (distinctOwnedCount != null)
        'distinct_owned_count': distinctOwnedCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InstalledCollectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? contentVersionId,
    Value<String>? name,
    Value<String?>? author,
    Value<String?>? description,
    Value<String?>? coverRelativePath,
    Value<String?>? mainPackTypeId,
    Value<DateTime>? installedAtUtc,
    Value<InstalledCollectionSource>? source,
    Value<int>? coins,
    Value<int>? totalCardCount,
    Value<int>? distinctOwnedCount,
    Value<int>? rowid,
  }) {
    return InstalledCollectionsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      contentVersionId: contentVersionId ?? this.contentVersionId,
      name: name ?? this.name,
      author: author ?? this.author,
      description: description ?? this.description,
      coverRelativePath: coverRelativePath ?? this.coverRelativePath,
      mainPackTypeId: mainPackTypeId ?? this.mainPackTypeId,
      installedAtUtc: installedAtUtc ?? this.installedAtUtc,
      source: source ?? this.source,
      coins: coins ?? this.coins,
      totalCardCount: totalCardCount ?? this.totalCardCount,
      distinctOwnedCount: distinctOwnedCount ?? this.distinctOwnedCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (contentVersionId.present) {
      map['content_version_id'] = Variable<String>(contentVersionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (coverRelativePath.present) {
      map['cover_relative_path'] = Variable<String>(coverRelativePath.value);
    }
    if (mainPackTypeId.present) {
      map['main_pack_type_id'] = Variable<String>(mainPackTypeId.value);
    }
    if (installedAtUtc.present) {
      map['installed_at_utc'] = Variable<DateTime>(installedAtUtc.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $InstalledCollectionsTable.$convertersource.toSql(source.value),
      );
    }
    if (coins.present) {
      map['coins'] = Variable<int>(coins.value);
    }
    if (totalCardCount.present) {
      map['total_card_count'] = Variable<int>(totalCardCount.value);
    }
    if (distinctOwnedCount.present) {
      map['distinct_owned_count'] = Variable<int>(distinctOwnedCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InstalledCollectionsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('name: $name, ')
          ..write('author: $author, ')
          ..write('description: $description, ')
          ..write('coverRelativePath: $coverRelativePath, ')
          ..write('mainPackTypeId: $mainPackTypeId, ')
          ..write('installedAtUtc: $installedAtUtc, ')
          ..write('source: $source, ')
          ..write('coins: $coins, ')
          ..write('totalCardCount: $totalCardCount, ')
          ..write('distinctOwnedCount: $distinctOwnedCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RaritiesTable extends Rarities
    with TableInfo<$RaritiesTable, RarityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RaritiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentVersionIdMeta = const VerificationMeta(
    'contentVersionId',
  );
  @override
  late final GeneratedColumn<String> contentVersionId = GeneratedColumn<String>(
    'content_version_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES content_versions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
    'icon_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frameIdMeta = const VerificationMeta(
    'frameId',
  );
  @override
  late final GeneratedColumn<String> frameId = GeneratedColumn<String>(
    'frame_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectIdMeta = const VerificationMeta(
    'effectId',
  );
  @override
  late final GeneratedColumn<String> effectId = GeneratedColumn<String>(
    'effect_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sellValueMeta = const VerificationMeta(
    'sellValue',
  );
  @override
  late final GeneratedColumn<int> sellValue = GeneratedColumn<int>(
    'sell_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    contentVersionId,
    name,
    orderIndex,
    colorValue,
    iconId,
    frameId,
    effectId,
    sellValue,
    isEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rarities';
  @override
  VerificationContext validateIntegrity(
    Insertable<RarityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('content_version_id')) {
      context.handle(
        _contentVersionIdMeta,
        contentVersionId.isAcceptableOrUnknown(
          data['content_version_id']!,
          _contentVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('icon_id')) {
      context.handle(
        _iconIdMeta,
        iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta),
      );
    } else if (isInserting) {
      context.missing(_iconIdMeta);
    }
    if (data.containsKey('frame_id')) {
      context.handle(
        _frameIdMeta,
        frameId.isAcceptableOrUnknown(data['frame_id']!, _frameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_frameIdMeta);
    }
    if (data.containsKey('effect_id')) {
      context.handle(
        _effectIdMeta,
        effectId.isAcceptableOrUnknown(data['effect_id']!, _effectIdMeta),
      );
    }
    if (data.containsKey('sell_value')) {
      context.handle(
        _sellValueMeta,
        sellValue.isAcceptableOrUnknown(data['sell_value']!, _sellValueMeta),
      );
    } else if (isInserting) {
      context.missing(_sellValueMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_isEnabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {contentVersionId, orderIndex},
    {contentVersionId, name},
  ];
  @override
  RarityRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RarityRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      contentVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_version_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      iconId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_id'],
      )!,
      frameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frame_id'],
      )!,
      effectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effect_id'],
      ),
      sellValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sell_value'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $RaritiesTable createAlias(String alias) {
    return $RaritiesTable(attachedDatabase, alias);
  }
}

class RarityRow extends DataClass implements Insertable<RarityRow> {
  final String id;
  final String collectionId;
  final String contentVersionId;
  final String name;
  final int orderIndex;
  final int colorValue;
  final String iconId;
  final String frameId;
  final String? effectId;
  final int sellValue;
  final bool isEnabled;
  const RarityRow({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required this.name,
    required this.orderIndex,
    required this.colorValue,
    required this.iconId,
    required this.frameId,
    this.effectId,
    required this.sellValue,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['content_version_id'] = Variable<String>(contentVersionId);
    map['name'] = Variable<String>(name);
    map['order_index'] = Variable<int>(orderIndex);
    map['color_value'] = Variable<int>(colorValue);
    map['icon_id'] = Variable<String>(iconId);
    map['frame_id'] = Variable<String>(frameId);
    if (!nullToAbsent || effectId != null) {
      map['effect_id'] = Variable<String>(effectId);
    }
    map['sell_value'] = Variable<int>(sellValue);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  RaritiesCompanion toCompanion(bool nullToAbsent) {
    return RaritiesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      contentVersionId: Value(contentVersionId),
      name: Value(name),
      orderIndex: Value(orderIndex),
      colorValue: Value(colorValue),
      iconId: Value(iconId),
      frameId: Value(frameId),
      effectId: effectId == null && nullToAbsent
          ? const Value.absent()
          : Value(effectId),
      sellValue: Value(sellValue),
      isEnabled: Value(isEnabled),
    );
  }

  factory RarityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RarityRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      contentVersionId: serializer.fromJson<String>(json['contentVersionId']),
      name: serializer.fromJson<String>(json['name']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      iconId: serializer.fromJson<String>(json['iconId']),
      frameId: serializer.fromJson<String>(json['frameId']),
      effectId: serializer.fromJson<String?>(json['effectId']),
      sellValue: serializer.fromJson<int>(json['sellValue']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'contentVersionId': serializer.toJson<String>(contentVersionId),
      'name': serializer.toJson<String>(name),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'colorValue': serializer.toJson<int>(colorValue),
      'iconId': serializer.toJson<String>(iconId),
      'frameId': serializer.toJson<String>(frameId),
      'effectId': serializer.toJson<String?>(effectId),
      'sellValue': serializer.toJson<int>(sellValue),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  RarityRow copyWith({
    String? id,
    String? collectionId,
    String? contentVersionId,
    String? name,
    int? orderIndex,
    int? colorValue,
    String? iconId,
    String? frameId,
    Value<String?> effectId = const Value.absent(),
    int? sellValue,
    bool? isEnabled,
  }) => RarityRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    contentVersionId: contentVersionId ?? this.contentVersionId,
    name: name ?? this.name,
    orderIndex: orderIndex ?? this.orderIndex,
    colorValue: colorValue ?? this.colorValue,
    iconId: iconId ?? this.iconId,
    frameId: frameId ?? this.frameId,
    effectId: effectId.present ? effectId.value : this.effectId,
    sellValue: sellValue ?? this.sellValue,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  RarityRow copyWithCompanion(RaritiesCompanion data) {
    return RarityRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      contentVersionId: data.contentVersionId.present
          ? data.contentVersionId.value
          : this.contentVersionId,
      name: data.name.present ? data.name.value : this.name,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      frameId: data.frameId.present ? data.frameId.value : this.frameId,
      effectId: data.effectId.present ? data.effectId.value : this.effectId,
      sellValue: data.sellValue.present ? data.sellValue.value : this.sellValue,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RarityRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('name: $name, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconId: $iconId, ')
          ..write('frameId: $frameId, ')
          ..write('effectId: $effectId, ')
          ..write('sellValue: $sellValue, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    contentVersionId,
    name,
    orderIndex,
    colorValue,
    iconId,
    frameId,
    effectId,
    sellValue,
    isEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RarityRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.contentVersionId == this.contentVersionId &&
          other.name == this.name &&
          other.orderIndex == this.orderIndex &&
          other.colorValue == this.colorValue &&
          other.iconId == this.iconId &&
          other.frameId == this.frameId &&
          other.effectId == this.effectId &&
          other.sellValue == this.sellValue &&
          other.isEnabled == this.isEnabled);
}

class RaritiesCompanion extends UpdateCompanion<RarityRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> contentVersionId;
  final Value<String> name;
  final Value<int> orderIndex;
  final Value<int> colorValue;
  final Value<String> iconId;
  final Value<String> frameId;
  final Value<String?> effectId;
  final Value<int> sellValue;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const RaritiesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.contentVersionId = const Value.absent(),
    this.name = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.iconId = const Value.absent(),
    this.frameId = const Value.absent(),
    this.effectId = const Value.absent(),
    this.sellValue = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RaritiesCompanion.insert({
    required String id,
    required String collectionId,
    required String contentVersionId,
    required String name,
    required int orderIndex,
    required int colorValue,
    required String iconId,
    required String frameId,
    this.effectId = const Value.absent(),
    required int sellValue,
    required bool isEnabled,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       contentVersionId = Value(contentVersionId),
       name = Value(name),
       orderIndex = Value(orderIndex),
       colorValue = Value(colorValue),
       iconId = Value(iconId),
       frameId = Value(frameId),
       sellValue = Value(sellValue),
       isEnabled = Value(isEnabled);
  static Insertable<RarityRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? contentVersionId,
    Expression<String>? name,
    Expression<int>? orderIndex,
    Expression<int>? colorValue,
    Expression<String>? iconId,
    Expression<String>? frameId,
    Expression<String>? effectId,
    Expression<int>? sellValue,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (contentVersionId != null) 'content_version_id': contentVersionId,
      if (name != null) 'name': name,
      if (orderIndex != null) 'order_index': orderIndex,
      if (colorValue != null) 'color_value': colorValue,
      if (iconId != null) 'icon_id': iconId,
      if (frameId != null) 'frame_id': frameId,
      if (effectId != null) 'effect_id': effectId,
      if (sellValue != null) 'sell_value': sellValue,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RaritiesCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? contentVersionId,
    Value<String>? name,
    Value<int>? orderIndex,
    Value<int>? colorValue,
    Value<String>? iconId,
    Value<String>? frameId,
    Value<String?>? effectId,
    Value<int>? sellValue,
    Value<bool>? isEnabled,
    Value<int>? rowid,
  }) {
    return RaritiesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      contentVersionId: contentVersionId ?? this.contentVersionId,
      name: name ?? this.name,
      orderIndex: orderIndex ?? this.orderIndex,
      colorValue: colorValue ?? this.colorValue,
      iconId: iconId ?? this.iconId,
      frameId: frameId ?? this.frameId,
      effectId: effectId ?? this.effectId,
      sellValue: sellValue ?? this.sellValue,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (contentVersionId.present) {
      map['content_version_id'] = Variable<String>(contentVersionId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (frameId.present) {
      map['frame_id'] = Variable<String>(frameId.value);
    }
    if (effectId.present) {
      map['effect_id'] = Variable<String>(effectId.value);
    }
    if (sellValue.present) {
      map['sell_value'] = Variable<int>(sellValue.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RaritiesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('name: $name, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('colorValue: $colorValue, ')
          ..write('iconId: $iconId, ')
          ..write('frameId: $frameId, ')
          ..write('effectId: $effectId, ')
          ..write('sellValue: $sellValue, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CardsTable extends Cards with TableInfo<$CardsTable, CardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentVersionIdMeta = const VerificationMeta(
    'contentVersionId',
  );
  @override
  late final GeneratedColumn<String> contentVersionId = GeneratedColumn<String>(
    'content_version_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES content_versions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _collectionNumberMeta = const VerificationMeta(
    'collectionNumber',
  );
  @override
  late final GeneratedColumn<int> collectionNumber = GeneratedColumn<int>(
    'collection_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _healthMeta = const VerificationMeta('health');
  @override
  late final GeneratedColumn<int> health = GeneratedColumn<int>(
    'health',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rarityIdMeta = const VerificationMeta(
    'rarityId',
  );
  @override
  late final GeneratedColumn<String> rarityId = GeneratedColumn<String>(
    'rarity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rarities (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _mediaAssetIdMeta = const VerificationMeta(
    'mediaAssetId',
  );
  @override
  late final GeneratedColumn<String> mediaAssetId = GeneratedColumn<String>(
    'media_asset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_assets (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<MediaType, String> mediaType =
      GeneratedColumn<String>(
        'media_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MediaType>($CardsTable.$convertermediaType);
  static const VerificationMeta _thumbnailAssetIdMeta = const VerificationMeta(
    'thumbnailAssetId',
  );
  @override
  late final GeneratedColumn<String> thumbnailAssetId = GeneratedColumn<String>(
    'thumbnail_asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES media_assets (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frameIdMeta = const VerificationMeta(
    'frameId',
  );
  @override
  late final GeneratedColumn<String> frameId = GeneratedColumn<String>(
    'frame_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _primaryColorMeta = const VerificationMeta(
    'primaryColor',
  );
  @override
  late final GeneratedColumn<int> primaryColor = GeneratedColumn<int>(
    'primary_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryColorMeta = const VerificationMeta(
    'secondaryColor',
  );
  @override
  late final GeneratedColumn<int> secondaryColor = GeneratedColumn<int>(
    'secondary_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortIndexMeta = const VerificationMeta(
    'sortIndex',
  );
  @override
  late final GeneratedColumn<int> sortIndex = GeneratedColumn<int>(
    'sort_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    collectionId,
    contentVersionId,
    collectionNumber,
    name,
    health,
    rarityId,
    mediaAssetId,
    mediaType,
    thumbnailAssetId,
    templateId,
    frameId,
    primaryColor,
    secondaryColor,
    description,
    sortIndex,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('content_version_id')) {
      context.handle(
        _contentVersionIdMeta,
        contentVersionId.isAcceptableOrUnknown(
          data['content_version_id']!,
          _contentVersionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionIdMeta);
    }
    if (data.containsKey('collection_number')) {
      context.handle(
        _collectionNumberMeta,
        collectionNumber.isAcceptableOrUnknown(
          data['collection_number']!,
          _collectionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionNumberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('health')) {
      context.handle(
        _healthMeta,
        health.isAcceptableOrUnknown(data['health']!, _healthMeta),
      );
    } else if (isInserting) {
      context.missing(_healthMeta);
    }
    if (data.containsKey('rarity_id')) {
      context.handle(
        _rarityIdMeta,
        rarityId.isAcceptableOrUnknown(data['rarity_id']!, _rarityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rarityIdMeta);
    }
    if (data.containsKey('media_asset_id')) {
      context.handle(
        _mediaAssetIdMeta,
        mediaAssetId.isAcceptableOrUnknown(
          data['media_asset_id']!,
          _mediaAssetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mediaAssetIdMeta);
    }
    if (data.containsKey('thumbnail_asset_id')) {
      context.handle(
        _thumbnailAssetIdMeta,
        thumbnailAssetId.isAcceptableOrUnknown(
          data['thumbnail_asset_id']!,
          _thumbnailAssetIdMeta,
        ),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('frame_id')) {
      context.handle(
        _frameIdMeta,
        frameId.isAcceptableOrUnknown(data['frame_id']!, _frameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_frameIdMeta);
    }
    if (data.containsKey('primary_color')) {
      context.handle(
        _primaryColorMeta,
        primaryColor.isAcceptableOrUnknown(
          data['primary_color']!,
          _primaryColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryColorMeta);
    }
    if (data.containsKey('secondary_color')) {
      context.handle(
        _secondaryColorMeta,
        secondaryColor.isAcceptableOrUnknown(
          data['secondary_color']!,
          _secondaryColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_secondaryColorMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('sort_index')) {
      context.handle(
        _sortIndexMeta,
        sortIndex.isAcceptableOrUnknown(data['sort_index']!, _sortIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_sortIndexMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {contentVersionId, collectionNumber},
  ];
  @override
  CardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      contentVersionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_version_id'],
      )!,
      collectionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}collection_number'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      health: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}health'],
      )!,
      rarityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rarity_id'],
      )!,
      mediaAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}media_asset_id'],
      )!,
      mediaType: $CardsTable.$convertermediaType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}media_type'],
        )!,
      ),
      thumbnailAssetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_asset_id'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      frameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frame_id'],
      )!,
      primaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}primary_color'],
      )!,
      secondaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}secondary_color'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      sortIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_index'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $CardsTable createAlias(String alias) {
    return $CardsTable(attachedDatabase, alias);
  }

  static TypeConverter<MediaType, String> $convertermediaType =
      const MediaTypeConverter();
}

class CardRow extends DataClass implements Insertable<CardRow> {
  final String id;
  final String collectionId;
  final String contentVersionId;
  final int collectionNumber;
  final String name;
  final int health;
  final String rarityId;
  final String mediaAssetId;
  final MediaType mediaType;
  final String? thumbnailAssetId;
  final String templateId;
  final String frameId;
  final int primaryColor;
  final int secondaryColor;
  final String? description;
  final int sortIndex;
  final DateTime createdAtUtc;
  const CardRow({
    required this.id,
    required this.collectionId,
    required this.contentVersionId,
    required this.collectionNumber,
    required this.name,
    required this.health,
    required this.rarityId,
    required this.mediaAssetId,
    required this.mediaType,
    this.thumbnailAssetId,
    required this.templateId,
    required this.frameId,
    required this.primaryColor,
    required this.secondaryColor,
    this.description,
    required this.sortIndex,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['content_version_id'] = Variable<String>(contentVersionId);
    map['collection_number'] = Variable<int>(collectionNumber);
    map['name'] = Variable<String>(name);
    map['health'] = Variable<int>(health);
    map['rarity_id'] = Variable<String>(rarityId);
    map['media_asset_id'] = Variable<String>(mediaAssetId);
    {
      map['media_type'] = Variable<String>(
        $CardsTable.$convertermediaType.toSql(mediaType),
      );
    }
    if (!nullToAbsent || thumbnailAssetId != null) {
      map['thumbnail_asset_id'] = Variable<String>(thumbnailAssetId);
    }
    map['template_id'] = Variable<String>(templateId);
    map['frame_id'] = Variable<String>(frameId);
    map['primary_color'] = Variable<int>(primaryColor);
    map['secondary_color'] = Variable<int>(secondaryColor);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['sort_index'] = Variable<int>(sortIndex);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  CardsCompanion toCompanion(bool nullToAbsent) {
    return CardsCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      contentVersionId: Value(contentVersionId),
      collectionNumber: Value(collectionNumber),
      name: Value(name),
      health: Value(health),
      rarityId: Value(rarityId),
      mediaAssetId: Value(mediaAssetId),
      mediaType: Value(mediaType),
      thumbnailAssetId: thumbnailAssetId == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailAssetId),
      templateId: Value(templateId),
      frameId: Value(frameId),
      primaryColor: Value(primaryColor),
      secondaryColor: Value(secondaryColor),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      sortIndex: Value(sortIndex),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory CardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardRow(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      contentVersionId: serializer.fromJson<String>(json['contentVersionId']),
      collectionNumber: serializer.fromJson<int>(json['collectionNumber']),
      name: serializer.fromJson<String>(json['name']),
      health: serializer.fromJson<int>(json['health']),
      rarityId: serializer.fromJson<String>(json['rarityId']),
      mediaAssetId: serializer.fromJson<String>(json['mediaAssetId']),
      mediaType: serializer.fromJson<MediaType>(json['mediaType']),
      thumbnailAssetId: serializer.fromJson<String?>(json['thumbnailAssetId']),
      templateId: serializer.fromJson<String>(json['templateId']),
      frameId: serializer.fromJson<String>(json['frameId']),
      primaryColor: serializer.fromJson<int>(json['primaryColor']),
      secondaryColor: serializer.fromJson<int>(json['secondaryColor']),
      description: serializer.fromJson<String?>(json['description']),
      sortIndex: serializer.fromJson<int>(json['sortIndex']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'contentVersionId': serializer.toJson<String>(contentVersionId),
      'collectionNumber': serializer.toJson<int>(collectionNumber),
      'name': serializer.toJson<String>(name),
      'health': serializer.toJson<int>(health),
      'rarityId': serializer.toJson<String>(rarityId),
      'mediaAssetId': serializer.toJson<String>(mediaAssetId),
      'mediaType': serializer.toJson<MediaType>(mediaType),
      'thumbnailAssetId': serializer.toJson<String?>(thumbnailAssetId),
      'templateId': serializer.toJson<String>(templateId),
      'frameId': serializer.toJson<String>(frameId),
      'primaryColor': serializer.toJson<int>(primaryColor),
      'secondaryColor': serializer.toJson<int>(secondaryColor),
      'description': serializer.toJson<String?>(description),
      'sortIndex': serializer.toJson<int>(sortIndex),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  CardRow copyWith({
    String? id,
    String? collectionId,
    String? contentVersionId,
    int? collectionNumber,
    String? name,
    int? health,
    String? rarityId,
    String? mediaAssetId,
    MediaType? mediaType,
    Value<String?> thumbnailAssetId = const Value.absent(),
    String? templateId,
    String? frameId,
    int? primaryColor,
    int? secondaryColor,
    Value<String?> description = const Value.absent(),
    int? sortIndex,
    DateTime? createdAtUtc,
  }) => CardRow(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    contentVersionId: contentVersionId ?? this.contentVersionId,
    collectionNumber: collectionNumber ?? this.collectionNumber,
    name: name ?? this.name,
    health: health ?? this.health,
    rarityId: rarityId ?? this.rarityId,
    mediaAssetId: mediaAssetId ?? this.mediaAssetId,
    mediaType: mediaType ?? this.mediaType,
    thumbnailAssetId: thumbnailAssetId.present
        ? thumbnailAssetId.value
        : this.thumbnailAssetId,
    templateId: templateId ?? this.templateId,
    frameId: frameId ?? this.frameId,
    primaryColor: primaryColor ?? this.primaryColor,
    secondaryColor: secondaryColor ?? this.secondaryColor,
    description: description.present ? description.value : this.description,
    sortIndex: sortIndex ?? this.sortIndex,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  CardRow copyWithCompanion(CardsCompanion data) {
    return CardRow(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      contentVersionId: data.contentVersionId.present
          ? data.contentVersionId.value
          : this.contentVersionId,
      collectionNumber: data.collectionNumber.present
          ? data.collectionNumber.value
          : this.collectionNumber,
      name: data.name.present ? data.name.value : this.name,
      health: data.health.present ? data.health.value : this.health,
      rarityId: data.rarityId.present ? data.rarityId.value : this.rarityId,
      mediaAssetId: data.mediaAssetId.present
          ? data.mediaAssetId.value
          : this.mediaAssetId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      thumbnailAssetId: data.thumbnailAssetId.present
          ? data.thumbnailAssetId.value
          : this.thumbnailAssetId,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      frameId: data.frameId.present ? data.frameId.value : this.frameId,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      secondaryColor: data.secondaryColor.present
          ? data.secondaryColor.value
          : this.secondaryColor,
      description: data.description.present
          ? data.description.value
          : this.description,
      sortIndex: data.sortIndex.present ? data.sortIndex.value : this.sortIndex,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardRow(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('collectionNumber: $collectionNumber, ')
          ..write('name: $name, ')
          ..write('health: $health, ')
          ..write('rarityId: $rarityId, ')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('mediaType: $mediaType, ')
          ..write('thumbnailAssetId: $thumbnailAssetId, ')
          ..write('templateId: $templateId, ')
          ..write('frameId: $frameId, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('description: $description, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    collectionId,
    contentVersionId,
    collectionNumber,
    name,
    health,
    rarityId,
    mediaAssetId,
    mediaType,
    thumbnailAssetId,
    templateId,
    frameId,
    primaryColor,
    secondaryColor,
    description,
    sortIndex,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardRow &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.contentVersionId == this.contentVersionId &&
          other.collectionNumber == this.collectionNumber &&
          other.name == this.name &&
          other.health == this.health &&
          other.rarityId == this.rarityId &&
          other.mediaAssetId == this.mediaAssetId &&
          other.mediaType == this.mediaType &&
          other.thumbnailAssetId == this.thumbnailAssetId &&
          other.templateId == this.templateId &&
          other.frameId == this.frameId &&
          other.primaryColor == this.primaryColor &&
          other.secondaryColor == this.secondaryColor &&
          other.description == this.description &&
          other.sortIndex == this.sortIndex &&
          other.createdAtUtc == this.createdAtUtc);
}

class CardsCompanion extends UpdateCompanion<CardRow> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> contentVersionId;
  final Value<int> collectionNumber;
  final Value<String> name;
  final Value<int> health;
  final Value<String> rarityId;
  final Value<String> mediaAssetId;
  final Value<MediaType> mediaType;
  final Value<String?> thumbnailAssetId;
  final Value<String> templateId;
  final Value<String> frameId;
  final Value<int> primaryColor;
  final Value<int> secondaryColor;
  final Value<String?> description;
  final Value<int> sortIndex;
  final Value<DateTime> createdAtUtc;
  final Value<int> rowid;
  const CardsCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.contentVersionId = const Value.absent(),
    this.collectionNumber = const Value.absent(),
    this.name = const Value.absent(),
    this.health = const Value.absent(),
    this.rarityId = const Value.absent(),
    this.mediaAssetId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.thumbnailAssetId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.frameId = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.secondaryColor = const Value.absent(),
    this.description = const Value.absent(),
    this.sortIndex = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardsCompanion.insert({
    required String id,
    required String collectionId,
    required String contentVersionId,
    required int collectionNumber,
    required String name,
    required int health,
    required String rarityId,
    required String mediaAssetId,
    required MediaType mediaType,
    this.thumbnailAssetId = const Value.absent(),
    required String templateId,
    required String frameId,
    required int primaryColor,
    required int secondaryColor,
    this.description = const Value.absent(),
    required int sortIndex,
    required DateTime createdAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       contentVersionId = Value(contentVersionId),
       collectionNumber = Value(collectionNumber),
       name = Value(name),
       health = Value(health),
       rarityId = Value(rarityId),
       mediaAssetId = Value(mediaAssetId),
       mediaType = Value(mediaType),
       templateId = Value(templateId),
       frameId = Value(frameId),
       primaryColor = Value(primaryColor),
       secondaryColor = Value(secondaryColor),
       sortIndex = Value(sortIndex),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<CardRow> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? contentVersionId,
    Expression<int>? collectionNumber,
    Expression<String>? name,
    Expression<int>? health,
    Expression<String>? rarityId,
    Expression<String>? mediaAssetId,
    Expression<String>? mediaType,
    Expression<String>? thumbnailAssetId,
    Expression<String>? templateId,
    Expression<String>? frameId,
    Expression<int>? primaryColor,
    Expression<int>? secondaryColor,
    Expression<String>? description,
    Expression<int>? sortIndex,
    Expression<DateTime>? createdAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (contentVersionId != null) 'content_version_id': contentVersionId,
      if (collectionNumber != null) 'collection_number': collectionNumber,
      if (name != null) 'name': name,
      if (health != null) 'health': health,
      if (rarityId != null) 'rarity_id': rarityId,
      if (mediaAssetId != null) 'media_asset_id': mediaAssetId,
      if (mediaType != null) 'media_type': mediaType,
      if (thumbnailAssetId != null) 'thumbnail_asset_id': thumbnailAssetId,
      if (templateId != null) 'template_id': templateId,
      if (frameId != null) 'frame_id': frameId,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (secondaryColor != null) 'secondary_color': secondaryColor,
      if (description != null) 'description': description,
      if (sortIndex != null) 'sort_index': sortIndex,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardsCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? contentVersionId,
    Value<int>? collectionNumber,
    Value<String>? name,
    Value<int>? health,
    Value<String>? rarityId,
    Value<String>? mediaAssetId,
    Value<MediaType>? mediaType,
    Value<String?>? thumbnailAssetId,
    Value<String>? templateId,
    Value<String>? frameId,
    Value<int>? primaryColor,
    Value<int>? secondaryColor,
    Value<String?>? description,
    Value<int>? sortIndex,
    Value<DateTime>? createdAtUtc,
    Value<int>? rowid,
  }) {
    return CardsCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      contentVersionId: contentVersionId ?? this.contentVersionId,
      collectionNumber: collectionNumber ?? this.collectionNumber,
      name: name ?? this.name,
      health: health ?? this.health,
      rarityId: rarityId ?? this.rarityId,
      mediaAssetId: mediaAssetId ?? this.mediaAssetId,
      mediaType: mediaType ?? this.mediaType,
      thumbnailAssetId: thumbnailAssetId ?? this.thumbnailAssetId,
      templateId: templateId ?? this.templateId,
      frameId: frameId ?? this.frameId,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      description: description ?? this.description,
      sortIndex: sortIndex ?? this.sortIndex,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (contentVersionId.present) {
      map['content_version_id'] = Variable<String>(contentVersionId.value);
    }
    if (collectionNumber.present) {
      map['collection_number'] = Variable<int>(collectionNumber.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (health.present) {
      map['health'] = Variable<int>(health.value);
    }
    if (rarityId.present) {
      map['rarity_id'] = Variable<String>(rarityId.value);
    }
    if (mediaAssetId.present) {
      map['media_asset_id'] = Variable<String>(mediaAssetId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<String>(
        $CardsTable.$convertermediaType.toSql(mediaType.value),
      );
    }
    if (thumbnailAssetId.present) {
      map['thumbnail_asset_id'] = Variable<String>(thumbnailAssetId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (frameId.present) {
      map['frame_id'] = Variable<String>(frameId.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<int>(primaryColor.value);
    }
    if (secondaryColor.present) {
      map['secondary_color'] = Variable<int>(secondaryColor.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (sortIndex.present) {
      map['sort_index'] = Variable<int>(sortIndex.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('contentVersionId: $contentVersionId, ')
          ..write('collectionNumber: $collectionNumber, ')
          ..write('name: $name, ')
          ..write('health: $health, ')
          ..write('rarityId: $rarityId, ')
          ..write('mediaAssetId: $mediaAssetId, ')
          ..write('mediaType: $mediaType, ')
          ..write('thumbnailAssetId: $thumbnailAssetId, ')
          ..write('templateId: $templateId, ')
          ..write('frameId: $frameId, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('description: $description, ')
          ..write('sortIndex: $sortIndex, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CardFieldValuesTable extends CardFieldValues
    with TableInfo<$CardFieldValuesTable, CardFieldValueRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardFieldValuesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fieldTypeIdMeta = const VerificationMeta(
    'fieldTypeId',
  );
  @override
  late final GeneratedColumn<String> fieldTypeId = GeneratedColumn<String>(
    'field_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    fieldTypeId,
    value,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'card_field_values';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardFieldValueRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('field_type_id')) {
      context.handle(
        _fieldTypeIdMeta,
        fieldTypeId.isAcceptableOrUnknown(
          data['field_type_id']!,
          _fieldTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fieldTypeIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cardId, fieldTypeId},
  ];
  @override
  CardFieldValueRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardFieldValueRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      fieldTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_type_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $CardFieldValuesTable createAlias(String alias) {
    return $CardFieldValuesTable(attachedDatabase, alias);
  }
}

class CardFieldValueRow extends DataClass
    implements Insertable<CardFieldValueRow> {
  final String id;
  final String cardId;
  final String fieldTypeId;
  final String value;
  final int displayOrder;
  const CardFieldValueRow({
    required this.id,
    required this.cardId,
    required this.fieldTypeId,
    required this.value,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['field_type_id'] = Variable<String>(fieldTypeId);
    map['value'] = Variable<String>(value);
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  CardFieldValuesCompanion toCompanion(bool nullToAbsent) {
    return CardFieldValuesCompanion(
      id: Value(id),
      cardId: Value(cardId),
      fieldTypeId: Value(fieldTypeId),
      value: Value(value),
      displayOrder: Value(displayOrder),
    );
  }

  factory CardFieldValueRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardFieldValueRow(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      fieldTypeId: serializer.fromJson<String>(json['fieldTypeId']),
      value: serializer.fromJson<String>(json['value']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'fieldTypeId': serializer.toJson<String>(fieldTypeId),
      'value': serializer.toJson<String>(value),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  CardFieldValueRow copyWith({
    String? id,
    String? cardId,
    String? fieldTypeId,
    String? value,
    int? displayOrder,
  }) => CardFieldValueRow(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    fieldTypeId: fieldTypeId ?? this.fieldTypeId,
    value: value ?? this.value,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  CardFieldValueRow copyWithCompanion(CardFieldValuesCompanion data) {
    return CardFieldValueRow(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      fieldTypeId: data.fieldTypeId.present
          ? data.fieldTypeId.value
          : this.fieldTypeId,
      value: data.value.present ? data.value.value : this.value,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardFieldValueRow(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('fieldTypeId: $fieldTypeId, ')
          ..write('value: $value, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cardId, fieldTypeId, value, displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardFieldValueRow &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.fieldTypeId == this.fieldTypeId &&
          other.value == this.value &&
          other.displayOrder == this.displayOrder);
}

class CardFieldValuesCompanion extends UpdateCompanion<CardFieldValueRow> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<String> fieldTypeId;
  final Value<String> value;
  final Value<int> displayOrder;
  final Value<int> rowid;
  const CardFieldValuesCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.fieldTypeId = const Value.absent(),
    this.value = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardFieldValuesCompanion.insert({
    required String id,
    required String cardId,
    required String fieldTypeId,
    required String value,
    required int displayOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       fieldTypeId = Value(fieldTypeId),
       value = Value(value),
       displayOrder = Value(displayOrder);
  static Insertable<CardFieldValueRow> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<String>? fieldTypeId,
    Expression<String>? value,
    Expression<int>? displayOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (fieldTypeId != null) 'field_type_id': fieldTypeId,
      if (value != null) 'value': value,
      if (displayOrder != null) 'display_order': displayOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardFieldValuesCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<String>? fieldTypeId,
    Value<String>? value,
    Value<int>? displayOrder,
    Value<int>? rowid,
  }) {
    return CardFieldValuesCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      fieldTypeId: fieldTypeId ?? this.fieldTypeId,
      value: value ?? this.value,
      displayOrder: displayOrder ?? this.displayOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (fieldTypeId.present) {
      map['field_type_id'] = Variable<String>(fieldTypeId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardFieldValuesCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('fieldTypeId: $fieldTypeId, ')
          ..write('value: $value, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackCardPoolTable extends PackCardPool
    with TableInfo<$PackCardPoolTable, PackCardPoolRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackCardPoolTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packTypeIdMeta = const VerificationMeta(
    'packTypeId',
  );
  @override
  late final GeneratedColumn<String> packTypeId = GeneratedColumn<String>(
    'pack_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [packTypeId, cardId, isEnabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_card_pool';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackCardPoolRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pack_type_id')) {
      context.handle(
        _packTypeIdMeta,
        packTypeId.isAcceptableOrUnknown(
          data['pack_type_id']!,
          _packTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packTypeIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_isEnabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packTypeId, cardId};
  @override
  PackCardPoolRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackCardPoolRow(
      packTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_type_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
    );
  }

  @override
  $PackCardPoolTable createAlias(String alias) {
    return $PackCardPoolTable(attachedDatabase, alias);
  }
}

class PackCardPoolRow extends DataClass implements Insertable<PackCardPoolRow> {
  final String packTypeId;
  final String cardId;
  final bool isEnabled;
  const PackCardPoolRow({
    required this.packTypeId,
    required this.cardId,
    required this.isEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pack_type_id'] = Variable<String>(packTypeId);
    map['card_id'] = Variable<String>(cardId);
    map['is_enabled'] = Variable<bool>(isEnabled);
    return map;
  }

  PackCardPoolCompanion toCompanion(bool nullToAbsent) {
    return PackCardPoolCompanion(
      packTypeId: Value(packTypeId),
      cardId: Value(cardId),
      isEnabled: Value(isEnabled),
    );
  }

  factory PackCardPoolRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackCardPoolRow(
      packTypeId: serializer.fromJson<String>(json['packTypeId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packTypeId': serializer.toJson<String>(packTypeId),
      'cardId': serializer.toJson<String>(cardId),
      'isEnabled': serializer.toJson<bool>(isEnabled),
    };
  }

  PackCardPoolRow copyWith({
    String? packTypeId,
    String? cardId,
    bool? isEnabled,
  }) => PackCardPoolRow(
    packTypeId: packTypeId ?? this.packTypeId,
    cardId: cardId ?? this.cardId,
    isEnabled: isEnabled ?? this.isEnabled,
  );
  PackCardPoolRow copyWithCompanion(PackCardPoolCompanion data) {
    return PackCardPoolRow(
      packTypeId: data.packTypeId.present
          ? data.packTypeId.value
          : this.packTypeId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackCardPoolRow(')
          ..write('packTypeId: $packTypeId, ')
          ..write('cardId: $cardId, ')
          ..write('isEnabled: $isEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(packTypeId, cardId, isEnabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackCardPoolRow &&
          other.packTypeId == this.packTypeId &&
          other.cardId == this.cardId &&
          other.isEnabled == this.isEnabled);
}

class PackCardPoolCompanion extends UpdateCompanion<PackCardPoolRow> {
  final Value<String> packTypeId;
  final Value<String> cardId;
  final Value<bool> isEnabled;
  final Value<int> rowid;
  const PackCardPoolCompanion({
    this.packTypeId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackCardPoolCompanion.insert({
    required String packTypeId,
    required String cardId,
    required bool isEnabled,
    this.rowid = const Value.absent(),
  }) : packTypeId = Value(packTypeId),
       cardId = Value(cardId),
       isEnabled = Value(isEnabled);
  static Insertable<PackCardPoolRow> custom({
    Expression<String>? packTypeId,
    Expression<String>? cardId,
    Expression<bool>? isEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packTypeId != null) 'pack_type_id': packTypeId,
      if (cardId != null) 'card_id': cardId,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackCardPoolCompanion copyWith({
    Value<String>? packTypeId,
    Value<String>? cardId,
    Value<bool>? isEnabled,
    Value<int>? rowid,
  }) {
    return PackCardPoolCompanion(
      packTypeId: packTypeId ?? this.packTypeId,
      cardId: cardId ?? this.cardId,
      isEnabled: isEnabled ?? this.isEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packTypeId.present) {
      map['pack_type_id'] = Variable<String>(packTypeId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackCardPoolCompanion(')
          ..write('packTypeId: $packTypeId, ')
          ..write('cardId: $cardId, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackSlotRulesTable extends PackSlotRules
    with TableInfo<$PackSlotRulesTable, PackSlotRuleRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackSlotRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packTypeIdMeta = const VerificationMeta(
    'packTypeId',
  );
  @override
  late final GeneratedColumn<String> packTypeId = GeneratedColumn<String>(
    'pack_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_types (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _slotIndexMeta = const VerificationMeta(
    'slotIndex',
  );
  @override
  late final GeneratedColumn<int> slotIndex = GeneratedColumn<int>(
    'slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PackSlotRuleType, String>
  ruleType = GeneratedColumn<String>(
    'rule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PackSlotRuleType>($PackSlotRulesTable.$converterruleType);
  static const VerificationMeta _fixedRarityIdMeta = const VerificationMeta(
    'fixedRarityId',
  );
  @override
  late final GeneratedColumn<String> fixedRarityId = GeneratedColumn<String>(
    'fixed_rarity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rarities (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _minimumRarityOrderMeta =
      const VerificationMeta('minimumRarityOrder');
  @override
  late final GeneratedColumn<int> minimumRarityOrder = GeneratedColumn<int>(
    'minimum_rarity_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _probabilityGroupIdMeta =
      const VerificationMeta('probabilityGroupId');
  @override
  late final GeneratedColumn<String> probabilityGroupId =
      GeneratedColumn<String>(
        'probability_group_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    packTypeId,
    slotIndex,
    ruleType,
    fixedRarityId,
    minimumRarityOrder,
    probabilityGroupId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_slot_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackSlotRuleRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pack_type_id')) {
      context.handle(
        _packTypeIdMeta,
        packTypeId.isAcceptableOrUnknown(
          data['pack_type_id']!,
          _packTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packTypeIdMeta);
    }
    if (data.containsKey('slot_index')) {
      context.handle(
        _slotIndexMeta,
        slotIndex.isAcceptableOrUnknown(data['slot_index']!, _slotIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIndexMeta);
    }
    if (data.containsKey('fixed_rarity_id')) {
      context.handle(
        _fixedRarityIdMeta,
        fixedRarityId.isAcceptableOrUnknown(
          data['fixed_rarity_id']!,
          _fixedRarityIdMeta,
        ),
      );
    }
    if (data.containsKey('minimum_rarity_order')) {
      context.handle(
        _minimumRarityOrderMeta,
        minimumRarityOrder.isAcceptableOrUnknown(
          data['minimum_rarity_order']!,
          _minimumRarityOrderMeta,
        ),
      );
    }
    if (data.containsKey('probability_group_id')) {
      context.handle(
        _probabilityGroupIdMeta,
        probabilityGroupId.isAcceptableOrUnknown(
          data['probability_group_id']!,
          _probabilityGroupIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {packTypeId, slotIndex},
  ];
  @override
  PackSlotRuleRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackSlotRuleRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      packTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_type_id'],
      )!,
      slotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_index'],
      )!,
      ruleType: $PackSlotRulesTable.$converterruleType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}rule_type'],
        )!,
      ),
      fixedRarityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fixed_rarity_id'],
      ),
      minimumRarityOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minimum_rarity_order'],
      ),
      probabilityGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}probability_group_id'],
      ),
    );
  }

  @override
  $PackSlotRulesTable createAlias(String alias) {
    return $PackSlotRulesTable(attachedDatabase, alias);
  }

  static TypeConverter<PackSlotRuleType, String> $converterruleType =
      const PackSlotRuleTypeConverter();
}

class PackSlotRuleRow extends DataClass implements Insertable<PackSlotRuleRow> {
  final String id;
  final String packTypeId;
  final int slotIndex;
  final PackSlotRuleType ruleType;
  final String? fixedRarityId;
  final int? minimumRarityOrder;
  final String? probabilityGroupId;
  const PackSlotRuleRow({
    required this.id,
    required this.packTypeId,
    required this.slotIndex,
    required this.ruleType,
    this.fixedRarityId,
    this.minimumRarityOrder,
    this.probabilityGroupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pack_type_id'] = Variable<String>(packTypeId);
    map['slot_index'] = Variable<int>(slotIndex);
    {
      map['rule_type'] = Variable<String>(
        $PackSlotRulesTable.$converterruleType.toSql(ruleType),
      );
    }
    if (!nullToAbsent || fixedRarityId != null) {
      map['fixed_rarity_id'] = Variable<String>(fixedRarityId);
    }
    if (!nullToAbsent || minimumRarityOrder != null) {
      map['minimum_rarity_order'] = Variable<int>(minimumRarityOrder);
    }
    if (!nullToAbsent || probabilityGroupId != null) {
      map['probability_group_id'] = Variable<String>(probabilityGroupId);
    }
    return map;
  }

  PackSlotRulesCompanion toCompanion(bool nullToAbsent) {
    return PackSlotRulesCompanion(
      id: Value(id),
      packTypeId: Value(packTypeId),
      slotIndex: Value(slotIndex),
      ruleType: Value(ruleType),
      fixedRarityId: fixedRarityId == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedRarityId),
      minimumRarityOrder: minimumRarityOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumRarityOrder),
      probabilityGroupId: probabilityGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(probabilityGroupId),
    );
  }

  factory PackSlotRuleRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackSlotRuleRow(
      id: serializer.fromJson<String>(json['id']),
      packTypeId: serializer.fromJson<String>(json['packTypeId']),
      slotIndex: serializer.fromJson<int>(json['slotIndex']),
      ruleType: serializer.fromJson<PackSlotRuleType>(json['ruleType']),
      fixedRarityId: serializer.fromJson<String?>(json['fixedRarityId']),
      minimumRarityOrder: serializer.fromJson<int?>(json['minimumRarityOrder']),
      probabilityGroupId: serializer.fromJson<String?>(
        json['probabilityGroupId'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'packTypeId': serializer.toJson<String>(packTypeId),
      'slotIndex': serializer.toJson<int>(slotIndex),
      'ruleType': serializer.toJson<PackSlotRuleType>(ruleType),
      'fixedRarityId': serializer.toJson<String?>(fixedRarityId),
      'minimumRarityOrder': serializer.toJson<int?>(minimumRarityOrder),
      'probabilityGroupId': serializer.toJson<String?>(probabilityGroupId),
    };
  }

  PackSlotRuleRow copyWith({
    String? id,
    String? packTypeId,
    int? slotIndex,
    PackSlotRuleType? ruleType,
    Value<String?> fixedRarityId = const Value.absent(),
    Value<int?> minimumRarityOrder = const Value.absent(),
    Value<String?> probabilityGroupId = const Value.absent(),
  }) => PackSlotRuleRow(
    id: id ?? this.id,
    packTypeId: packTypeId ?? this.packTypeId,
    slotIndex: slotIndex ?? this.slotIndex,
    ruleType: ruleType ?? this.ruleType,
    fixedRarityId: fixedRarityId.present
        ? fixedRarityId.value
        : this.fixedRarityId,
    minimumRarityOrder: minimumRarityOrder.present
        ? minimumRarityOrder.value
        : this.minimumRarityOrder,
    probabilityGroupId: probabilityGroupId.present
        ? probabilityGroupId.value
        : this.probabilityGroupId,
  );
  PackSlotRuleRow copyWithCompanion(PackSlotRulesCompanion data) {
    return PackSlotRuleRow(
      id: data.id.present ? data.id.value : this.id,
      packTypeId: data.packTypeId.present
          ? data.packTypeId.value
          : this.packTypeId,
      slotIndex: data.slotIndex.present ? data.slotIndex.value : this.slotIndex,
      ruleType: data.ruleType.present ? data.ruleType.value : this.ruleType,
      fixedRarityId: data.fixedRarityId.present
          ? data.fixedRarityId.value
          : this.fixedRarityId,
      minimumRarityOrder: data.minimumRarityOrder.present
          ? data.minimumRarityOrder.value
          : this.minimumRarityOrder,
      probabilityGroupId: data.probabilityGroupId.present
          ? data.probabilityGroupId.value
          : this.probabilityGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackSlotRuleRow(')
          ..write('id: $id, ')
          ..write('packTypeId: $packTypeId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('ruleType: $ruleType, ')
          ..write('fixedRarityId: $fixedRarityId, ')
          ..write('minimumRarityOrder: $minimumRarityOrder, ')
          ..write('probabilityGroupId: $probabilityGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    packTypeId,
    slotIndex,
    ruleType,
    fixedRarityId,
    minimumRarityOrder,
    probabilityGroupId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackSlotRuleRow &&
          other.id == this.id &&
          other.packTypeId == this.packTypeId &&
          other.slotIndex == this.slotIndex &&
          other.ruleType == this.ruleType &&
          other.fixedRarityId == this.fixedRarityId &&
          other.minimumRarityOrder == this.minimumRarityOrder &&
          other.probabilityGroupId == this.probabilityGroupId);
}

class PackSlotRulesCompanion extends UpdateCompanion<PackSlotRuleRow> {
  final Value<String> id;
  final Value<String> packTypeId;
  final Value<int> slotIndex;
  final Value<PackSlotRuleType> ruleType;
  final Value<String?> fixedRarityId;
  final Value<int?> minimumRarityOrder;
  final Value<String?> probabilityGroupId;
  final Value<int> rowid;
  const PackSlotRulesCompanion({
    this.id = const Value.absent(),
    this.packTypeId = const Value.absent(),
    this.slotIndex = const Value.absent(),
    this.ruleType = const Value.absent(),
    this.fixedRarityId = const Value.absent(),
    this.minimumRarityOrder = const Value.absent(),
    this.probabilityGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackSlotRulesCompanion.insert({
    required String id,
    required String packTypeId,
    required int slotIndex,
    required PackSlotRuleType ruleType,
    this.fixedRarityId = const Value.absent(),
    this.minimumRarityOrder = const Value.absent(),
    this.probabilityGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       packTypeId = Value(packTypeId),
       slotIndex = Value(slotIndex),
       ruleType = Value(ruleType);
  static Insertable<PackSlotRuleRow> custom({
    Expression<String>? id,
    Expression<String>? packTypeId,
    Expression<int>? slotIndex,
    Expression<String>? ruleType,
    Expression<String>? fixedRarityId,
    Expression<int>? minimumRarityOrder,
    Expression<String>? probabilityGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (packTypeId != null) 'pack_type_id': packTypeId,
      if (slotIndex != null) 'slot_index': slotIndex,
      if (ruleType != null) 'rule_type': ruleType,
      if (fixedRarityId != null) 'fixed_rarity_id': fixedRarityId,
      if (minimumRarityOrder != null)
        'minimum_rarity_order': minimumRarityOrder,
      if (probabilityGroupId != null)
        'probability_group_id': probabilityGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackSlotRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? packTypeId,
    Value<int>? slotIndex,
    Value<PackSlotRuleType>? ruleType,
    Value<String?>? fixedRarityId,
    Value<int?>? minimumRarityOrder,
    Value<String?>? probabilityGroupId,
    Value<int>? rowid,
  }) {
    return PackSlotRulesCompanion(
      id: id ?? this.id,
      packTypeId: packTypeId ?? this.packTypeId,
      slotIndex: slotIndex ?? this.slotIndex,
      ruleType: ruleType ?? this.ruleType,
      fixedRarityId: fixedRarityId ?? this.fixedRarityId,
      minimumRarityOrder: minimumRarityOrder ?? this.minimumRarityOrder,
      probabilityGroupId: probabilityGroupId ?? this.probabilityGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (packTypeId.present) {
      map['pack_type_id'] = Variable<String>(packTypeId.value);
    }
    if (slotIndex.present) {
      map['slot_index'] = Variable<int>(slotIndex.value);
    }
    if (ruleType.present) {
      map['rule_type'] = Variable<String>(
        $PackSlotRulesTable.$converterruleType.toSql(ruleType.value),
      );
    }
    if (fixedRarityId.present) {
      map['fixed_rarity_id'] = Variable<String>(fixedRarityId.value);
    }
    if (minimumRarityOrder.present) {
      map['minimum_rarity_order'] = Variable<int>(minimumRarityOrder.value);
    }
    if (probabilityGroupId.present) {
      map['probability_group_id'] = Variable<String>(probabilityGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackSlotRulesCompanion(')
          ..write('id: $id, ')
          ..write('packTypeId: $packTypeId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('ruleType: $ruleType, ')
          ..write('fixedRarityId: $fixedRarityId, ')
          ..write('minimumRarityOrder: $minimumRarityOrder, ')
          ..write('probabilityGroupId: $probabilityGroupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackRarityProbabilitiesTable extends PackRarityProbabilities
    with TableInfo<$PackRarityProbabilitiesTable, PackRarityProbabilityRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackRarityProbabilitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _probabilityGroupIdMeta =
      const VerificationMeta('probabilityGroupId');
  @override
  late final GeneratedColumn<String> probabilityGroupId =
      GeneratedColumn<String>(
        'probability_group_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _rarityIdMeta = const VerificationMeta(
    'rarityId',
  );
  @override
  late final GeneratedColumn<String> rarityId = GeneratedColumn<String>(
    'rarity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rarities (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [probabilityGroupId, rarityId, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_rarity_probabilities';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackRarityProbabilityRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('probability_group_id')) {
      context.handle(
        _probabilityGroupIdMeta,
        probabilityGroupId.isAcceptableOrUnknown(
          data['probability_group_id']!,
          _probabilityGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probabilityGroupIdMeta);
    }
    if (data.containsKey('rarity_id')) {
      context.handle(
        _rarityIdMeta,
        rarityId.isAcceptableOrUnknown(data['rarity_id']!, _rarityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rarityIdMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {probabilityGroupId, rarityId};
  @override
  PackRarityProbabilityRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackRarityProbabilityRow(
      probabilityGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}probability_group_id'],
      )!,
      rarityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rarity_id'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
    );
  }

  @override
  $PackRarityProbabilitiesTable createAlias(String alias) {
    return $PackRarityProbabilitiesTable(attachedDatabase, alias);
  }
}

class PackRarityProbabilityRow extends DataClass
    implements Insertable<PackRarityProbabilityRow> {
  final String probabilityGroupId;
  final String rarityId;
  final int weight;
  const PackRarityProbabilityRow({
    required this.probabilityGroupId,
    required this.rarityId,
    required this.weight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['probability_group_id'] = Variable<String>(probabilityGroupId);
    map['rarity_id'] = Variable<String>(rarityId);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  PackRarityProbabilitiesCompanion toCompanion(bool nullToAbsent) {
    return PackRarityProbabilitiesCompanion(
      probabilityGroupId: Value(probabilityGroupId),
      rarityId: Value(rarityId),
      weight: Value(weight),
    );
  }

  factory PackRarityProbabilityRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackRarityProbabilityRow(
      probabilityGroupId: serializer.fromJson<String>(
        json['probabilityGroupId'],
      ),
      rarityId: serializer.fromJson<String>(json['rarityId']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'probabilityGroupId': serializer.toJson<String>(probabilityGroupId),
      'rarityId': serializer.toJson<String>(rarityId),
      'weight': serializer.toJson<int>(weight),
    };
  }

  PackRarityProbabilityRow copyWith({
    String? probabilityGroupId,
    String? rarityId,
    int? weight,
  }) => PackRarityProbabilityRow(
    probabilityGroupId: probabilityGroupId ?? this.probabilityGroupId,
    rarityId: rarityId ?? this.rarityId,
    weight: weight ?? this.weight,
  );
  PackRarityProbabilityRow copyWithCompanion(
    PackRarityProbabilitiesCompanion data,
  ) {
    return PackRarityProbabilityRow(
      probabilityGroupId: data.probabilityGroupId.present
          ? data.probabilityGroupId.value
          : this.probabilityGroupId,
      rarityId: data.rarityId.present ? data.rarityId.value : this.rarityId,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackRarityProbabilityRow(')
          ..write('probabilityGroupId: $probabilityGroupId, ')
          ..write('rarityId: $rarityId, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(probabilityGroupId, rarityId, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackRarityProbabilityRow &&
          other.probabilityGroupId == this.probabilityGroupId &&
          other.rarityId == this.rarityId &&
          other.weight == this.weight);
}

class PackRarityProbabilitiesCompanion
    extends UpdateCompanion<PackRarityProbabilityRow> {
  final Value<String> probabilityGroupId;
  final Value<String> rarityId;
  final Value<int> weight;
  final Value<int> rowid;
  const PackRarityProbabilitiesCompanion({
    this.probabilityGroupId = const Value.absent(),
    this.rarityId = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackRarityProbabilitiesCompanion.insert({
    required String probabilityGroupId,
    required String rarityId,
    required int weight,
    this.rowid = const Value.absent(),
  }) : probabilityGroupId = Value(probabilityGroupId),
       rarityId = Value(rarityId),
       weight = Value(weight);
  static Insertable<PackRarityProbabilityRow> custom({
    Expression<String>? probabilityGroupId,
    Expression<String>? rarityId,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (probabilityGroupId != null)
        'probability_group_id': probabilityGroupId,
      if (rarityId != null) 'rarity_id': rarityId,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackRarityProbabilitiesCompanion copyWith({
    Value<String>? probabilityGroupId,
    Value<String>? rarityId,
    Value<int>? weight,
    Value<int>? rowid,
  }) {
    return PackRarityProbabilitiesCompanion(
      probabilityGroupId: probabilityGroupId ?? this.probabilityGroupId,
      rarityId: rarityId ?? this.rarityId,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (probabilityGroupId.present) {
      map['probability_group_id'] = Variable<String>(probabilityGroupId.value);
    }
    if (rarityId.present) {
      map['rarity_id'] = Variable<String>(rarityId.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackRarityProbabilitiesCompanion(')
          ..write('probabilityGroupId: $probabilityGroupId, ')
          ..write('rarityId: $rarityId, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackInventoryTable extends PackInventory
    with TableInfo<$PackInventoryTable, PackInventoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackInventoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _installedCollectionIdMeta =
      const VerificationMeta('installedCollectionId');
  @override
  late final GeneratedColumn<String> installedCollectionId =
      GeneratedColumn<String>(
        'installed_collection_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES installed_collections (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _packTypeIdMeta = const VerificationMeta(
    'packTypeId',
  );
  @override
  late final GeneratedColumn<String> packTypeId = GeneratedColumn<String>(
    'pack_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_types (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _availableCountMeta = const VerificationMeta(
    'availableCount',
  );
  @override
  late final GeneratedColumn<int> availableCount = GeneratedColumn<int>(
    'available_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxAccumulatedMeta = const VerificationMeta(
    'maxAccumulated',
  );
  @override
  late final GeneratedColumn<int> maxAccumulated = GeneratedColumn<int>(
    'max_accumulated',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextRechargeAtUtcMeta = const VerificationMeta(
    'nextRechargeAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> nextRechargeAtUtc =
      GeneratedColumn<DateTime>(
        'next_recharge_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastCalculatedAtUtcMeta =
      const VerificationMeta('lastCalculatedAtUtc');
  @override
  late final GeneratedColumn<DateTime> lastCalculatedAtUtc =
      GeneratedColumn<DateTime>(
        'last_calculated_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    installedCollectionId,
    packTypeId,
    availableCount,
    maxAccumulated,
    nextRechargeAtUtc,
    lastCalculatedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackInventoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('installed_collection_id')) {
      context.handle(
        _installedCollectionIdMeta,
        installedCollectionId.isAcceptableOrUnknown(
          data['installed_collection_id']!,
          _installedCollectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedCollectionIdMeta);
    }
    if (data.containsKey('pack_type_id')) {
      context.handle(
        _packTypeIdMeta,
        packTypeId.isAcceptableOrUnknown(
          data['pack_type_id']!,
          _packTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packTypeIdMeta);
    }
    if (data.containsKey('available_count')) {
      context.handle(
        _availableCountMeta,
        availableCount.isAcceptableOrUnknown(
          data['available_count']!,
          _availableCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableCountMeta);
    }
    if (data.containsKey('max_accumulated')) {
      context.handle(
        _maxAccumulatedMeta,
        maxAccumulated.isAcceptableOrUnknown(
          data['max_accumulated']!,
          _maxAccumulatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxAccumulatedMeta);
    }
    if (data.containsKey('next_recharge_at_utc')) {
      context.handle(
        _nextRechargeAtUtcMeta,
        nextRechargeAtUtc.isAcceptableOrUnknown(
          data['next_recharge_at_utc']!,
          _nextRechargeAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextRechargeAtUtcMeta);
    }
    if (data.containsKey('last_calculated_at_utc')) {
      context.handle(
        _lastCalculatedAtUtcMeta,
        lastCalculatedAtUtc.isAcceptableOrUnknown(
          data['last_calculated_at_utc']!,
          _lastCalculatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastCalculatedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {installedCollectionId, packTypeId};
  @override
  PackInventoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackInventoryRow(
      installedCollectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installed_collection_id'],
      )!,
      packTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_type_id'],
      )!,
      availableCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_count'],
      )!,
      maxAccumulated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_accumulated'],
      )!,
      nextRechargeAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_recharge_at_utc'],
      )!,
      lastCalculatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_calculated_at_utc'],
      )!,
    );
  }

  @override
  $PackInventoryTable createAlias(String alias) {
    return $PackInventoryTable(attachedDatabase, alias);
  }
}

class PackInventoryRow extends DataClass
    implements Insertable<PackInventoryRow> {
  final String installedCollectionId;
  final String packTypeId;
  final int availableCount;
  final int maxAccumulated;
  final DateTime nextRechargeAtUtc;
  final DateTime lastCalculatedAtUtc;
  const PackInventoryRow({
    required this.installedCollectionId,
    required this.packTypeId,
    required this.availableCount,
    required this.maxAccumulated,
    required this.nextRechargeAtUtc,
    required this.lastCalculatedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['installed_collection_id'] = Variable<String>(installedCollectionId);
    map['pack_type_id'] = Variable<String>(packTypeId);
    map['available_count'] = Variable<int>(availableCount);
    map['max_accumulated'] = Variable<int>(maxAccumulated);
    map['next_recharge_at_utc'] = Variable<DateTime>(nextRechargeAtUtc);
    map['last_calculated_at_utc'] = Variable<DateTime>(lastCalculatedAtUtc);
    return map;
  }

  PackInventoryCompanion toCompanion(bool nullToAbsent) {
    return PackInventoryCompanion(
      installedCollectionId: Value(installedCollectionId),
      packTypeId: Value(packTypeId),
      availableCount: Value(availableCount),
      maxAccumulated: Value(maxAccumulated),
      nextRechargeAtUtc: Value(nextRechargeAtUtc),
      lastCalculatedAtUtc: Value(lastCalculatedAtUtc),
    );
  }

  factory PackInventoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackInventoryRow(
      installedCollectionId: serializer.fromJson<String>(
        json['installedCollectionId'],
      ),
      packTypeId: serializer.fromJson<String>(json['packTypeId']),
      availableCount: serializer.fromJson<int>(json['availableCount']),
      maxAccumulated: serializer.fromJson<int>(json['maxAccumulated']),
      nextRechargeAtUtc: serializer.fromJson<DateTime>(
        json['nextRechargeAtUtc'],
      ),
      lastCalculatedAtUtc: serializer.fromJson<DateTime>(
        json['lastCalculatedAtUtc'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'installedCollectionId': serializer.toJson<String>(installedCollectionId),
      'packTypeId': serializer.toJson<String>(packTypeId),
      'availableCount': serializer.toJson<int>(availableCount),
      'maxAccumulated': serializer.toJson<int>(maxAccumulated),
      'nextRechargeAtUtc': serializer.toJson<DateTime>(nextRechargeAtUtc),
      'lastCalculatedAtUtc': serializer.toJson<DateTime>(lastCalculatedAtUtc),
    };
  }

  PackInventoryRow copyWith({
    String? installedCollectionId,
    String? packTypeId,
    int? availableCount,
    int? maxAccumulated,
    DateTime? nextRechargeAtUtc,
    DateTime? lastCalculatedAtUtc,
  }) => PackInventoryRow(
    installedCollectionId: installedCollectionId ?? this.installedCollectionId,
    packTypeId: packTypeId ?? this.packTypeId,
    availableCount: availableCount ?? this.availableCount,
    maxAccumulated: maxAccumulated ?? this.maxAccumulated,
    nextRechargeAtUtc: nextRechargeAtUtc ?? this.nextRechargeAtUtc,
    lastCalculatedAtUtc: lastCalculatedAtUtc ?? this.lastCalculatedAtUtc,
  );
  PackInventoryRow copyWithCompanion(PackInventoryCompanion data) {
    return PackInventoryRow(
      installedCollectionId: data.installedCollectionId.present
          ? data.installedCollectionId.value
          : this.installedCollectionId,
      packTypeId: data.packTypeId.present
          ? data.packTypeId.value
          : this.packTypeId,
      availableCount: data.availableCount.present
          ? data.availableCount.value
          : this.availableCount,
      maxAccumulated: data.maxAccumulated.present
          ? data.maxAccumulated.value
          : this.maxAccumulated,
      nextRechargeAtUtc: data.nextRechargeAtUtc.present
          ? data.nextRechargeAtUtc.value
          : this.nextRechargeAtUtc,
      lastCalculatedAtUtc: data.lastCalculatedAtUtc.present
          ? data.lastCalculatedAtUtc.value
          : this.lastCalculatedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackInventoryRow(')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('packTypeId: $packTypeId, ')
          ..write('availableCount: $availableCount, ')
          ..write('maxAccumulated: $maxAccumulated, ')
          ..write('nextRechargeAtUtc: $nextRechargeAtUtc, ')
          ..write('lastCalculatedAtUtc: $lastCalculatedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    installedCollectionId,
    packTypeId,
    availableCount,
    maxAccumulated,
    nextRechargeAtUtc,
    lastCalculatedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackInventoryRow &&
          other.installedCollectionId == this.installedCollectionId &&
          other.packTypeId == this.packTypeId &&
          other.availableCount == this.availableCount &&
          other.maxAccumulated == this.maxAccumulated &&
          other.nextRechargeAtUtc == this.nextRechargeAtUtc &&
          other.lastCalculatedAtUtc == this.lastCalculatedAtUtc);
}

class PackInventoryCompanion extends UpdateCompanion<PackInventoryRow> {
  final Value<String> installedCollectionId;
  final Value<String> packTypeId;
  final Value<int> availableCount;
  final Value<int> maxAccumulated;
  final Value<DateTime> nextRechargeAtUtc;
  final Value<DateTime> lastCalculatedAtUtc;
  final Value<int> rowid;
  const PackInventoryCompanion({
    this.installedCollectionId = const Value.absent(),
    this.packTypeId = const Value.absent(),
    this.availableCount = const Value.absent(),
    this.maxAccumulated = const Value.absent(),
    this.nextRechargeAtUtc = const Value.absent(),
    this.lastCalculatedAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackInventoryCompanion.insert({
    required String installedCollectionId,
    required String packTypeId,
    required int availableCount,
    required int maxAccumulated,
    required DateTime nextRechargeAtUtc,
    required DateTime lastCalculatedAtUtc,
    this.rowid = const Value.absent(),
  }) : installedCollectionId = Value(installedCollectionId),
       packTypeId = Value(packTypeId),
       availableCount = Value(availableCount),
       maxAccumulated = Value(maxAccumulated),
       nextRechargeAtUtc = Value(nextRechargeAtUtc),
       lastCalculatedAtUtc = Value(lastCalculatedAtUtc);
  static Insertable<PackInventoryRow> custom({
    Expression<String>? installedCollectionId,
    Expression<String>? packTypeId,
    Expression<int>? availableCount,
    Expression<int>? maxAccumulated,
    Expression<DateTime>? nextRechargeAtUtc,
    Expression<DateTime>? lastCalculatedAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (installedCollectionId != null)
        'installed_collection_id': installedCollectionId,
      if (packTypeId != null) 'pack_type_id': packTypeId,
      if (availableCount != null) 'available_count': availableCount,
      if (maxAccumulated != null) 'max_accumulated': maxAccumulated,
      if (nextRechargeAtUtc != null) 'next_recharge_at_utc': nextRechargeAtUtc,
      if (lastCalculatedAtUtc != null)
        'last_calculated_at_utc': lastCalculatedAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackInventoryCompanion copyWith({
    Value<String>? installedCollectionId,
    Value<String>? packTypeId,
    Value<int>? availableCount,
    Value<int>? maxAccumulated,
    Value<DateTime>? nextRechargeAtUtc,
    Value<DateTime>? lastCalculatedAtUtc,
    Value<int>? rowid,
  }) {
    return PackInventoryCompanion(
      installedCollectionId:
          installedCollectionId ?? this.installedCollectionId,
      packTypeId: packTypeId ?? this.packTypeId,
      availableCount: availableCount ?? this.availableCount,
      maxAccumulated: maxAccumulated ?? this.maxAccumulated,
      nextRechargeAtUtc: nextRechargeAtUtc ?? this.nextRechargeAtUtc,
      lastCalculatedAtUtc: lastCalculatedAtUtc ?? this.lastCalculatedAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (installedCollectionId.present) {
      map['installed_collection_id'] = Variable<String>(
        installedCollectionId.value,
      );
    }
    if (packTypeId.present) {
      map['pack_type_id'] = Variable<String>(packTypeId.value);
    }
    if (availableCount.present) {
      map['available_count'] = Variable<int>(availableCount.value);
    }
    if (maxAccumulated.present) {
      map['max_accumulated'] = Variable<int>(maxAccumulated.value);
    }
    if (nextRechargeAtUtc.present) {
      map['next_recharge_at_utc'] = Variable<DateTime>(nextRechargeAtUtc.value);
    }
    if (lastCalculatedAtUtc.present) {
      map['last_calculated_at_utc'] = Variable<DateTime>(
        lastCalculatedAtUtc.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackInventoryCompanion(')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('packTypeId: $packTypeId, ')
          ..write('availableCount: $availableCount, ')
          ..write('maxAccumulated: $maxAccumulated, ')
          ..write('nextRechargeAtUtc: $nextRechargeAtUtc, ')
          ..write('lastCalculatedAtUtc: $lastCalculatedAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OwnedCardsTable extends OwnedCards
    with TableInfo<$OwnedCardsTable, OwnedCardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OwnedCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _installedCollectionIdMeta =
      const VerificationMeta('installedCollectionId');
  @override
  late final GeneratedColumn<String> installedCollectionId =
      GeneratedColumn<String>(
        'installed_collection_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES installed_collections (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstObtainedAtUtcMeta =
      const VerificationMeta('firstObtainedAtUtc');
  @override
  late final GeneratedColumn<DateTime> firstObtainedAtUtc =
      GeneratedColumn<DateTime>(
        'first_obtained_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastObtainedAtUtcMeta = const VerificationMeta(
    'lastObtainedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> lastObtainedAtUtc =
      GeneratedColumn<DateTime>(
        'last_obtained_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    installedCollectionId,
    cardId,
    quantity,
    firstObtainedAtUtc,
    lastObtainedAtUtc,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'owned_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<OwnedCardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('installed_collection_id')) {
      context.handle(
        _installedCollectionIdMeta,
        installedCollectionId.isAcceptableOrUnknown(
          data['installed_collection_id']!,
          _installedCollectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedCollectionIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('first_obtained_at_utc')) {
      context.handle(
        _firstObtainedAtUtcMeta,
        firstObtainedAtUtc.isAcceptableOrUnknown(
          data['first_obtained_at_utc']!,
          _firstObtainedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstObtainedAtUtcMeta);
    }
    if (data.containsKey('last_obtained_at_utc')) {
      context.handle(
        _lastObtainedAtUtcMeta,
        lastObtainedAtUtc.isAcceptableOrUnknown(
          data['last_obtained_at_utc']!,
          _lastObtainedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastObtainedAtUtcMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {installedCollectionId, cardId};
  @override
  OwnedCardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OwnedCardRow(
      installedCollectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installed_collection_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      firstObtainedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_obtained_at_utc'],
      )!,
      lastObtainedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_obtained_at_utc'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $OwnedCardsTable createAlias(String alias) {
    return $OwnedCardsTable(attachedDatabase, alias);
  }
}

class OwnedCardRow extends DataClass implements Insertable<OwnedCardRow> {
  final String installedCollectionId;
  final String cardId;
  final int quantity;
  final DateTime firstObtainedAtUtc;
  final DateTime lastObtainedAtUtc;
  final bool isFavorite;
  const OwnedCardRow({
    required this.installedCollectionId,
    required this.cardId,
    required this.quantity,
    required this.firstObtainedAtUtc,
    required this.lastObtainedAtUtc,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['installed_collection_id'] = Variable<String>(installedCollectionId);
    map['card_id'] = Variable<String>(cardId);
    map['quantity'] = Variable<int>(quantity);
    map['first_obtained_at_utc'] = Variable<DateTime>(firstObtainedAtUtc);
    map['last_obtained_at_utc'] = Variable<DateTime>(lastObtainedAtUtc);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  OwnedCardsCompanion toCompanion(bool nullToAbsent) {
    return OwnedCardsCompanion(
      installedCollectionId: Value(installedCollectionId),
      cardId: Value(cardId),
      quantity: Value(quantity),
      firstObtainedAtUtc: Value(firstObtainedAtUtc),
      lastObtainedAtUtc: Value(lastObtainedAtUtc),
      isFavorite: Value(isFavorite),
    );
  }

  factory OwnedCardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OwnedCardRow(
      installedCollectionId: serializer.fromJson<String>(
        json['installedCollectionId'],
      ),
      cardId: serializer.fromJson<String>(json['cardId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      firstObtainedAtUtc: serializer.fromJson<DateTime>(
        json['firstObtainedAtUtc'],
      ),
      lastObtainedAtUtc: serializer.fromJson<DateTime>(
        json['lastObtainedAtUtc'],
      ),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'installedCollectionId': serializer.toJson<String>(installedCollectionId),
      'cardId': serializer.toJson<String>(cardId),
      'quantity': serializer.toJson<int>(quantity),
      'firstObtainedAtUtc': serializer.toJson<DateTime>(firstObtainedAtUtc),
      'lastObtainedAtUtc': serializer.toJson<DateTime>(lastObtainedAtUtc),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  OwnedCardRow copyWith({
    String? installedCollectionId,
    String? cardId,
    int? quantity,
    DateTime? firstObtainedAtUtc,
    DateTime? lastObtainedAtUtc,
    bool? isFavorite,
  }) => OwnedCardRow(
    installedCollectionId: installedCollectionId ?? this.installedCollectionId,
    cardId: cardId ?? this.cardId,
    quantity: quantity ?? this.quantity,
    firstObtainedAtUtc: firstObtainedAtUtc ?? this.firstObtainedAtUtc,
    lastObtainedAtUtc: lastObtainedAtUtc ?? this.lastObtainedAtUtc,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  OwnedCardRow copyWithCompanion(OwnedCardsCompanion data) {
    return OwnedCardRow(
      installedCollectionId: data.installedCollectionId.present
          ? data.installedCollectionId.value
          : this.installedCollectionId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      firstObtainedAtUtc: data.firstObtainedAtUtc.present
          ? data.firstObtainedAtUtc.value
          : this.firstObtainedAtUtc,
      lastObtainedAtUtc: data.lastObtainedAtUtc.present
          ? data.lastObtainedAtUtc.value
          : this.lastObtainedAtUtc,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OwnedCardRow(')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('firstObtainedAtUtc: $firstObtainedAtUtc, ')
          ..write('lastObtainedAtUtc: $lastObtainedAtUtc, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    installedCollectionId,
    cardId,
    quantity,
    firstObtainedAtUtc,
    lastObtainedAtUtc,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OwnedCardRow &&
          other.installedCollectionId == this.installedCollectionId &&
          other.cardId == this.cardId &&
          other.quantity == this.quantity &&
          other.firstObtainedAtUtc == this.firstObtainedAtUtc &&
          other.lastObtainedAtUtc == this.lastObtainedAtUtc &&
          other.isFavorite == this.isFavorite);
}

class OwnedCardsCompanion extends UpdateCompanion<OwnedCardRow> {
  final Value<String> installedCollectionId;
  final Value<String> cardId;
  final Value<int> quantity;
  final Value<DateTime> firstObtainedAtUtc;
  final Value<DateTime> lastObtainedAtUtc;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const OwnedCardsCompanion({
    this.installedCollectionId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.firstObtainedAtUtc = const Value.absent(),
    this.lastObtainedAtUtc = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OwnedCardsCompanion.insert({
    required String installedCollectionId,
    required String cardId,
    required int quantity,
    required DateTime firstObtainedAtUtc,
    required DateTime lastObtainedAtUtc,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  }) : installedCollectionId = Value(installedCollectionId),
       cardId = Value(cardId),
       quantity = Value(quantity),
       firstObtainedAtUtc = Value(firstObtainedAtUtc),
       lastObtainedAtUtc = Value(lastObtainedAtUtc),
       isFavorite = Value(isFavorite);
  static Insertable<OwnedCardRow> custom({
    Expression<String>? installedCollectionId,
    Expression<String>? cardId,
    Expression<int>? quantity,
    Expression<DateTime>? firstObtainedAtUtc,
    Expression<DateTime>? lastObtainedAtUtc,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (installedCollectionId != null)
        'installed_collection_id': installedCollectionId,
      if (cardId != null) 'card_id': cardId,
      if (quantity != null) 'quantity': quantity,
      if (firstObtainedAtUtc != null)
        'first_obtained_at_utc': firstObtainedAtUtc,
      if (lastObtainedAtUtc != null) 'last_obtained_at_utc': lastObtainedAtUtc,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OwnedCardsCompanion copyWith({
    Value<String>? installedCollectionId,
    Value<String>? cardId,
    Value<int>? quantity,
    Value<DateTime>? firstObtainedAtUtc,
    Value<DateTime>? lastObtainedAtUtc,
    Value<bool>? isFavorite,
    Value<int>? rowid,
  }) {
    return OwnedCardsCompanion(
      installedCollectionId:
          installedCollectionId ?? this.installedCollectionId,
      cardId: cardId ?? this.cardId,
      quantity: quantity ?? this.quantity,
      firstObtainedAtUtc: firstObtainedAtUtc ?? this.firstObtainedAtUtc,
      lastObtainedAtUtc: lastObtainedAtUtc ?? this.lastObtainedAtUtc,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (installedCollectionId.present) {
      map['installed_collection_id'] = Variable<String>(
        installedCollectionId.value,
      );
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (firstObtainedAtUtc.present) {
      map['first_obtained_at_utc'] = Variable<DateTime>(
        firstObtainedAtUtc.value,
      );
    }
    if (lastObtainedAtUtc.present) {
      map['last_obtained_at_utc'] = Variable<DateTime>(lastObtainedAtUtc.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OwnedCardsCompanion(')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('firstObtainedAtUtc: $firstObtainedAtUtc, ')
          ..write('lastObtainedAtUtc: $lastObtainedAtUtc, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackOpeningsTable extends PackOpenings
    with TableInfo<$PackOpeningsTable, PackOpeningRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackOpeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installedCollectionIdMeta =
      const VerificationMeta('installedCollectionId');
  @override
  late final GeneratedColumn<String> installedCollectionId =
      GeneratedColumn<String>(
        'installed_collection_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES installed_collections (id) ON DELETE CASCADE',
        ),
      );
  static const VerificationMeta _packTypeIdMeta = const VerificationMeta(
    'packTypeId',
  );
  @override
  late final GeneratedColumn<String> packTypeId = GeneratedColumn<String>(
    'pack_type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_types (id) ON DELETE RESTRICT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PackOpeningStatus, String>
  status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<PackOpeningStatus>($PackOpeningsTable.$converterstatus);
  static const VerificationMeta _generatedAtUtcMeta = const VerificationMeta(
    'generatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAtUtc =
      GeneratedColumn<DateTime>(
        'generated_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _completedAtUtcMeta = const VerificationMeta(
    'completedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> completedAtUtc =
      GeneratedColumn<DateTime>(
        'completed_at_utc',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    installedCollectionId,
    packTypeId,
    status,
    generatedAtUtc,
    completedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_openings';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackOpeningRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('installed_collection_id')) {
      context.handle(
        _installedCollectionIdMeta,
        installedCollectionId.isAcceptableOrUnknown(
          data['installed_collection_id']!,
          _installedCollectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedCollectionIdMeta);
    }
    if (data.containsKey('pack_type_id')) {
      context.handle(
        _packTypeIdMeta,
        packTypeId.isAcceptableOrUnknown(
          data['pack_type_id']!,
          _packTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packTypeIdMeta);
    }
    if (data.containsKey('generated_at_utc')) {
      context.handle(
        _generatedAtUtcMeta,
        generatedAtUtc.isAcceptableOrUnknown(
          data['generated_at_utc']!,
          _generatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtUtcMeta);
    }
    if (data.containsKey('completed_at_utc')) {
      context.handle(
        _completedAtUtcMeta,
        completedAtUtc.isAcceptableOrUnknown(
          data['completed_at_utc']!,
          _completedAtUtcMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PackOpeningRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackOpeningRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      installedCollectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installed_collection_id'],
      )!,
      packTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_type_id'],
      )!,
      status: $PackOpeningsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      generatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at_utc'],
      )!,
      completedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at_utc'],
      ),
    );
  }

  @override
  $PackOpeningsTable createAlias(String alias) {
    return $PackOpeningsTable(attachedDatabase, alias);
  }

  static TypeConverter<PackOpeningStatus, String> $converterstatus =
      const PackOpeningStatusConverter();
}

class PackOpeningRow extends DataClass implements Insertable<PackOpeningRow> {
  final String id;
  final String installedCollectionId;
  final String packTypeId;
  final PackOpeningStatus status;
  final DateTime generatedAtUtc;
  final DateTime? completedAtUtc;
  const PackOpeningRow({
    required this.id,
    required this.installedCollectionId,
    required this.packTypeId,
    required this.status,
    required this.generatedAtUtc,
    this.completedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['installed_collection_id'] = Variable<String>(installedCollectionId);
    map['pack_type_id'] = Variable<String>(packTypeId);
    {
      map['status'] = Variable<String>(
        $PackOpeningsTable.$converterstatus.toSql(status),
      );
    }
    map['generated_at_utc'] = Variable<DateTime>(generatedAtUtc);
    if (!nullToAbsent || completedAtUtc != null) {
      map['completed_at_utc'] = Variable<DateTime>(completedAtUtc);
    }
    return map;
  }

  PackOpeningsCompanion toCompanion(bool nullToAbsent) {
    return PackOpeningsCompanion(
      id: Value(id),
      installedCollectionId: Value(installedCollectionId),
      packTypeId: Value(packTypeId),
      status: Value(status),
      generatedAtUtc: Value(generatedAtUtc),
      completedAtUtc: completedAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAtUtc),
    );
  }

  factory PackOpeningRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackOpeningRow(
      id: serializer.fromJson<String>(json['id']),
      installedCollectionId: serializer.fromJson<String>(
        json['installedCollectionId'],
      ),
      packTypeId: serializer.fromJson<String>(json['packTypeId']),
      status: serializer.fromJson<PackOpeningStatus>(json['status']),
      generatedAtUtc: serializer.fromJson<DateTime>(json['generatedAtUtc']),
      completedAtUtc: serializer.fromJson<DateTime?>(json['completedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'installedCollectionId': serializer.toJson<String>(installedCollectionId),
      'packTypeId': serializer.toJson<String>(packTypeId),
      'status': serializer.toJson<PackOpeningStatus>(status),
      'generatedAtUtc': serializer.toJson<DateTime>(generatedAtUtc),
      'completedAtUtc': serializer.toJson<DateTime?>(completedAtUtc),
    };
  }

  PackOpeningRow copyWith({
    String? id,
    String? installedCollectionId,
    String? packTypeId,
    PackOpeningStatus? status,
    DateTime? generatedAtUtc,
    Value<DateTime?> completedAtUtc = const Value.absent(),
  }) => PackOpeningRow(
    id: id ?? this.id,
    installedCollectionId: installedCollectionId ?? this.installedCollectionId,
    packTypeId: packTypeId ?? this.packTypeId,
    status: status ?? this.status,
    generatedAtUtc: generatedAtUtc ?? this.generatedAtUtc,
    completedAtUtc: completedAtUtc.present
        ? completedAtUtc.value
        : this.completedAtUtc,
  );
  PackOpeningRow copyWithCompanion(PackOpeningsCompanion data) {
    return PackOpeningRow(
      id: data.id.present ? data.id.value : this.id,
      installedCollectionId: data.installedCollectionId.present
          ? data.installedCollectionId.value
          : this.installedCollectionId,
      packTypeId: data.packTypeId.present
          ? data.packTypeId.value
          : this.packTypeId,
      status: data.status.present ? data.status.value : this.status,
      generatedAtUtc: data.generatedAtUtc.present
          ? data.generatedAtUtc.value
          : this.generatedAtUtc,
      completedAtUtc: data.completedAtUtc.present
          ? data.completedAtUtc.value
          : this.completedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackOpeningRow(')
          ..write('id: $id, ')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('packTypeId: $packTypeId, ')
          ..write('status: $status, ')
          ..write('generatedAtUtc: $generatedAtUtc, ')
          ..write('completedAtUtc: $completedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    installedCollectionId,
    packTypeId,
    status,
    generatedAtUtc,
    completedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackOpeningRow &&
          other.id == this.id &&
          other.installedCollectionId == this.installedCollectionId &&
          other.packTypeId == this.packTypeId &&
          other.status == this.status &&
          other.generatedAtUtc == this.generatedAtUtc &&
          other.completedAtUtc == this.completedAtUtc);
}

class PackOpeningsCompanion extends UpdateCompanion<PackOpeningRow> {
  final Value<String> id;
  final Value<String> installedCollectionId;
  final Value<String> packTypeId;
  final Value<PackOpeningStatus> status;
  final Value<DateTime> generatedAtUtc;
  final Value<DateTime?> completedAtUtc;
  final Value<int> rowid;
  const PackOpeningsCompanion({
    this.id = const Value.absent(),
    this.installedCollectionId = const Value.absent(),
    this.packTypeId = const Value.absent(),
    this.status = const Value.absent(),
    this.generatedAtUtc = const Value.absent(),
    this.completedAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackOpeningsCompanion.insert({
    required String id,
    required String installedCollectionId,
    required String packTypeId,
    required PackOpeningStatus status,
    required DateTime generatedAtUtc,
    this.completedAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       installedCollectionId = Value(installedCollectionId),
       packTypeId = Value(packTypeId),
       status = Value(status),
       generatedAtUtc = Value(generatedAtUtc);
  static Insertable<PackOpeningRow> custom({
    Expression<String>? id,
    Expression<String>? installedCollectionId,
    Expression<String>? packTypeId,
    Expression<String>? status,
    Expression<DateTime>? generatedAtUtc,
    Expression<DateTime>? completedAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (installedCollectionId != null)
        'installed_collection_id': installedCollectionId,
      if (packTypeId != null) 'pack_type_id': packTypeId,
      if (status != null) 'status': status,
      if (generatedAtUtc != null) 'generated_at_utc': generatedAtUtc,
      if (completedAtUtc != null) 'completed_at_utc': completedAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackOpeningsCompanion copyWith({
    Value<String>? id,
    Value<String>? installedCollectionId,
    Value<String>? packTypeId,
    Value<PackOpeningStatus>? status,
    Value<DateTime>? generatedAtUtc,
    Value<DateTime?>? completedAtUtc,
    Value<int>? rowid,
  }) {
    return PackOpeningsCompanion(
      id: id ?? this.id,
      installedCollectionId:
          installedCollectionId ?? this.installedCollectionId,
      packTypeId: packTypeId ?? this.packTypeId,
      status: status ?? this.status,
      generatedAtUtc: generatedAtUtc ?? this.generatedAtUtc,
      completedAtUtc: completedAtUtc ?? this.completedAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (installedCollectionId.present) {
      map['installed_collection_id'] = Variable<String>(
        installedCollectionId.value,
      );
    }
    if (packTypeId.present) {
      map['pack_type_id'] = Variable<String>(packTypeId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $PackOpeningsTable.$converterstatus.toSql(status.value),
      );
    }
    if (generatedAtUtc.present) {
      map['generated_at_utc'] = Variable<DateTime>(generatedAtUtc.value);
    }
    if (completedAtUtc.present) {
      map['completed_at_utc'] = Variable<DateTime>(completedAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackOpeningsCompanion(')
          ..write('id: $id, ')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('packTypeId: $packTypeId, ')
          ..write('status: $status, ')
          ..write('generatedAtUtc: $generatedAtUtc, ')
          ..write('completedAtUtc: $completedAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PackOpeningCardsTable extends PackOpeningCards
    with TableInfo<$PackOpeningCardsTable, PackOpeningCardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackOpeningCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _openingIdMeta = const VerificationMeta(
    'openingId',
  );
  @override
  late final GeneratedColumn<String> openingId = GeneratedColumn<String>(
    'opening_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pack_openings (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _slotIndexMeta = const VerificationMeta(
    'slotIndex',
  );
  @override
  late final GeneratedColumn<int> slotIndex = GeneratedColumn<int>(
    'slot_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wasNewMeta = const VerificationMeta('wasNew');
  @override
  late final GeneratedColumn<bool> wasNew = GeneratedColumn<bool>(
    'was_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("was_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _quantityAfterMeta = const VerificationMeta(
    'quantityAfter',
  );
  @override
  late final GeneratedColumn<int> quantityAfter = GeneratedColumn<int>(
    'quantity_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revealedMeta = const VerificationMeta(
    'revealed',
  );
  @override
  late final GeneratedColumn<bool> revealed = GeneratedColumn<bool>(
    'revealed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("revealed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    openingId,
    cardId,
    slotIndex,
    wasNew,
    quantityAfter,
    revealed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pack_opening_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackOpeningCardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('opening_id')) {
      context.handle(
        _openingIdMeta,
        openingId.isAcceptableOrUnknown(data['opening_id']!, _openingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_openingIdMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('slot_index')) {
      context.handle(
        _slotIndexMeta,
        slotIndex.isAcceptableOrUnknown(data['slot_index']!, _slotIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_slotIndexMeta);
    }
    if (data.containsKey('was_new')) {
      context.handle(
        _wasNewMeta,
        wasNew.isAcceptableOrUnknown(data['was_new']!, _wasNewMeta),
      );
    } else if (isInserting) {
      context.missing(_wasNewMeta);
    }
    if (data.containsKey('quantity_after')) {
      context.handle(
        _quantityAfterMeta,
        quantityAfter.isAcceptableOrUnknown(
          data['quantity_after']!,
          _quantityAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityAfterMeta);
    }
    if (data.containsKey('revealed')) {
      context.handle(
        _revealedMeta,
        revealed.isAcceptableOrUnknown(data['revealed']!, _revealedMeta),
      );
    } else if (isInserting) {
      context.missing(_revealedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {openingId, slotIndex};
  @override
  PackOpeningCardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackOpeningCardRow(
      openingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      slotIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slot_index'],
      )!,
      wasNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_new'],
      )!,
      quantityAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_after'],
      )!,
      revealed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}revealed'],
      )!,
    );
  }

  @override
  $PackOpeningCardsTable createAlias(String alias) {
    return $PackOpeningCardsTable(attachedDatabase, alias);
  }
}

class PackOpeningCardRow extends DataClass
    implements Insertable<PackOpeningCardRow> {
  final String openingId;
  final String cardId;
  final int slotIndex;
  final bool wasNew;
  final int quantityAfter;
  final bool revealed;
  const PackOpeningCardRow({
    required this.openingId,
    required this.cardId,
    required this.slotIndex,
    required this.wasNew,
    required this.quantityAfter,
    required this.revealed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['opening_id'] = Variable<String>(openingId);
    map['card_id'] = Variable<String>(cardId);
    map['slot_index'] = Variable<int>(slotIndex);
    map['was_new'] = Variable<bool>(wasNew);
    map['quantity_after'] = Variable<int>(quantityAfter);
    map['revealed'] = Variable<bool>(revealed);
    return map;
  }

  PackOpeningCardsCompanion toCompanion(bool nullToAbsent) {
    return PackOpeningCardsCompanion(
      openingId: Value(openingId),
      cardId: Value(cardId),
      slotIndex: Value(slotIndex),
      wasNew: Value(wasNew),
      quantityAfter: Value(quantityAfter),
      revealed: Value(revealed),
    );
  }

  factory PackOpeningCardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackOpeningCardRow(
      openingId: serializer.fromJson<String>(json['openingId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      slotIndex: serializer.fromJson<int>(json['slotIndex']),
      wasNew: serializer.fromJson<bool>(json['wasNew']),
      quantityAfter: serializer.fromJson<int>(json['quantityAfter']),
      revealed: serializer.fromJson<bool>(json['revealed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'openingId': serializer.toJson<String>(openingId),
      'cardId': serializer.toJson<String>(cardId),
      'slotIndex': serializer.toJson<int>(slotIndex),
      'wasNew': serializer.toJson<bool>(wasNew),
      'quantityAfter': serializer.toJson<int>(quantityAfter),
      'revealed': serializer.toJson<bool>(revealed),
    };
  }

  PackOpeningCardRow copyWith({
    String? openingId,
    String? cardId,
    int? slotIndex,
    bool? wasNew,
    int? quantityAfter,
    bool? revealed,
  }) => PackOpeningCardRow(
    openingId: openingId ?? this.openingId,
    cardId: cardId ?? this.cardId,
    slotIndex: slotIndex ?? this.slotIndex,
    wasNew: wasNew ?? this.wasNew,
    quantityAfter: quantityAfter ?? this.quantityAfter,
    revealed: revealed ?? this.revealed,
  );
  PackOpeningCardRow copyWithCompanion(PackOpeningCardsCompanion data) {
    return PackOpeningCardRow(
      openingId: data.openingId.present ? data.openingId.value : this.openingId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      slotIndex: data.slotIndex.present ? data.slotIndex.value : this.slotIndex,
      wasNew: data.wasNew.present ? data.wasNew.value : this.wasNew,
      quantityAfter: data.quantityAfter.present
          ? data.quantityAfter.value
          : this.quantityAfter,
      revealed: data.revealed.present ? data.revealed.value : this.revealed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackOpeningCardRow(')
          ..write('openingId: $openingId, ')
          ..write('cardId: $cardId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('wasNew: $wasNew, ')
          ..write('quantityAfter: $quantityAfter, ')
          ..write('revealed: $revealed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    openingId,
    cardId,
    slotIndex,
    wasNew,
    quantityAfter,
    revealed,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackOpeningCardRow &&
          other.openingId == this.openingId &&
          other.cardId == this.cardId &&
          other.slotIndex == this.slotIndex &&
          other.wasNew == this.wasNew &&
          other.quantityAfter == this.quantityAfter &&
          other.revealed == this.revealed);
}

class PackOpeningCardsCompanion extends UpdateCompanion<PackOpeningCardRow> {
  final Value<String> openingId;
  final Value<String> cardId;
  final Value<int> slotIndex;
  final Value<bool> wasNew;
  final Value<int> quantityAfter;
  final Value<bool> revealed;
  final Value<int> rowid;
  const PackOpeningCardsCompanion({
    this.openingId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.slotIndex = const Value.absent(),
    this.wasNew = const Value.absent(),
    this.quantityAfter = const Value.absent(),
    this.revealed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PackOpeningCardsCompanion.insert({
    required String openingId,
    required String cardId,
    required int slotIndex,
    required bool wasNew,
    required int quantityAfter,
    required bool revealed,
    this.rowid = const Value.absent(),
  }) : openingId = Value(openingId),
       cardId = Value(cardId),
       slotIndex = Value(slotIndex),
       wasNew = Value(wasNew),
       quantityAfter = Value(quantityAfter),
       revealed = Value(revealed);
  static Insertable<PackOpeningCardRow> custom({
    Expression<String>? openingId,
    Expression<String>? cardId,
    Expression<int>? slotIndex,
    Expression<bool>? wasNew,
    Expression<int>? quantityAfter,
    Expression<bool>? revealed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (openingId != null) 'opening_id': openingId,
      if (cardId != null) 'card_id': cardId,
      if (slotIndex != null) 'slot_index': slotIndex,
      if (wasNew != null) 'was_new': wasNew,
      if (quantityAfter != null) 'quantity_after': quantityAfter,
      if (revealed != null) 'revealed': revealed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PackOpeningCardsCompanion copyWith({
    Value<String>? openingId,
    Value<String>? cardId,
    Value<int>? slotIndex,
    Value<bool>? wasNew,
    Value<int>? quantityAfter,
    Value<bool>? revealed,
    Value<int>? rowid,
  }) {
    return PackOpeningCardsCompanion(
      openingId: openingId ?? this.openingId,
      cardId: cardId ?? this.cardId,
      slotIndex: slotIndex ?? this.slotIndex,
      wasNew: wasNew ?? this.wasNew,
      quantityAfter: quantityAfter ?? this.quantityAfter,
      revealed: revealed ?? this.revealed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (openingId.present) {
      map['opening_id'] = Variable<String>(openingId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (slotIndex.present) {
      map['slot_index'] = Variable<int>(slotIndex.value);
    }
    if (wasNew.present) {
      map['was_new'] = Variable<bool>(wasNew.value);
    }
    if (quantityAfter.present) {
      map['quantity_after'] = Variable<int>(quantityAfter.value);
    }
    if (revealed.present) {
      map['revealed'] = Variable<bool>(revealed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackOpeningCardsCompanion(')
          ..write('openingId: $openingId, ')
          ..write('cardId: $cardId, ')
          ..write('slotIndex: $slotIndex, ')
          ..write('wasNew: $wasNew, ')
          ..write('quantityAfter: $quantityAfter, ')
          ..write('revealed: $revealed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoinTransactionsTable extends CoinTransactions
    with TableInfo<$CoinTransactionsTable, CoinTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoinTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installedCollectionIdMeta =
      const VerificationMeta('installedCollectionId');
  @override
  late final GeneratedColumn<String> installedCollectionId =
      GeneratedColumn<String>(
        'installed_collection_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES installed_collections (id) ON DELETE CASCADE',
        ),
      );
  @override
  late final GeneratedColumnWithTypeConverter<CoinTransactionType, String>
  transactionType =
      GeneratedColumn<String>(
        'transaction_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CoinTransactionType>(
        $CoinTransactionsTable.$convertertransactionType,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceAfterMeta = const VerificationMeta(
    'balanceAfter',
  );
  @override
  late final GeneratedColumn<int> balanceAfter = GeneratedColumn<int>(
    'balance_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relatedCardIdMeta = const VerificationMeta(
    'relatedCardId',
  );
  @override
  late final GeneratedColumn<String> relatedCardId = GeneratedColumn<String>(
    'related_card_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _relatedPackTypeIdMeta = const VerificationMeta(
    'relatedPackTypeId',
  );
  @override
  late final GeneratedColumn<String> relatedPackTypeId =
      GeneratedColumn<String>(
        'related_pack_type_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pack_types (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    installedCollectionId,
    transactionType,
    amount,
    balanceAfter,
    relatedCardId,
    relatedPackTypeId,
    createdAtUtc,
    metadataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coin_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoinTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('installed_collection_id')) {
      context.handle(
        _installedCollectionIdMeta,
        installedCollectionId.isAcceptableOrUnknown(
          data['installed_collection_id']!,
          _installedCollectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installedCollectionIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('balance_after')) {
      context.handle(
        _balanceAfterMeta,
        balanceAfter.isAcceptableOrUnknown(
          data['balance_after']!,
          _balanceAfterMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceAfterMeta);
    }
    if (data.containsKey('related_card_id')) {
      context.handle(
        _relatedCardIdMeta,
        relatedCardId.isAcceptableOrUnknown(
          data['related_card_id']!,
          _relatedCardIdMeta,
        ),
      );
    }
    if (data.containsKey('related_pack_type_id')) {
      context.handle(
        _relatedPackTypeIdMeta,
        relatedPackTypeId.isAcceptableOrUnknown(
          data['related_pack_type_id']!,
          _relatedPackTypeIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CoinTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoinTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      installedCollectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}installed_collection_id'],
      )!,
      transactionType: $CoinTransactionsTable.$convertertransactionType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}transaction_type'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      balanceAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_after'],
      )!,
      relatedCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_card_id'],
      ),
      relatedPackTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_pack_type_id'],
      ),
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      ),
    );
  }

  @override
  $CoinTransactionsTable createAlias(String alias) {
    return $CoinTransactionsTable(attachedDatabase, alias);
  }

  static TypeConverter<CoinTransactionType, String> $convertertransactionType =
      const CoinTransactionTypeConverter();
}

class CoinTransactionRow extends DataClass
    implements Insertable<CoinTransactionRow> {
  final String id;
  final String installedCollectionId;
  final CoinTransactionType transactionType;
  final int amount;
  final int balanceAfter;
  final String? relatedCardId;
  final String? relatedPackTypeId;
  final DateTime createdAtUtc;
  final String? metadataJson;
  const CoinTransactionRow({
    required this.id,
    required this.installedCollectionId,
    required this.transactionType,
    required this.amount,
    required this.balanceAfter,
    this.relatedCardId,
    this.relatedPackTypeId,
    required this.createdAtUtc,
    this.metadataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['installed_collection_id'] = Variable<String>(installedCollectionId);
    {
      map['transaction_type'] = Variable<String>(
        $CoinTransactionsTable.$convertertransactionType.toSql(transactionType),
      );
    }
    map['amount'] = Variable<int>(amount);
    map['balance_after'] = Variable<int>(balanceAfter);
    if (!nullToAbsent || relatedCardId != null) {
      map['related_card_id'] = Variable<String>(relatedCardId);
    }
    if (!nullToAbsent || relatedPackTypeId != null) {
      map['related_pack_type_id'] = Variable<String>(relatedPackTypeId);
    }
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    return map;
  }

  CoinTransactionsCompanion toCompanion(bool nullToAbsent) {
    return CoinTransactionsCompanion(
      id: Value(id),
      installedCollectionId: Value(installedCollectionId),
      transactionType: Value(transactionType),
      amount: Value(amount),
      balanceAfter: Value(balanceAfter),
      relatedCardId: relatedCardId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedCardId),
      relatedPackTypeId: relatedPackTypeId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedPackTypeId),
      createdAtUtc: Value(createdAtUtc),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
    );
  }

  factory CoinTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoinTransactionRow(
      id: serializer.fromJson<String>(json['id']),
      installedCollectionId: serializer.fromJson<String>(
        json['installedCollectionId'],
      ),
      transactionType: serializer.fromJson<CoinTransactionType>(
        json['transactionType'],
      ),
      amount: serializer.fromJson<int>(json['amount']),
      balanceAfter: serializer.fromJson<int>(json['balanceAfter']),
      relatedCardId: serializer.fromJson<String?>(json['relatedCardId']),
      relatedPackTypeId: serializer.fromJson<String?>(
        json['relatedPackTypeId'],
      ),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'installedCollectionId': serializer.toJson<String>(installedCollectionId),
      'transactionType': serializer.toJson<CoinTransactionType>(
        transactionType,
      ),
      'amount': serializer.toJson<int>(amount),
      'balanceAfter': serializer.toJson<int>(balanceAfter),
      'relatedCardId': serializer.toJson<String?>(relatedCardId),
      'relatedPackTypeId': serializer.toJson<String?>(relatedPackTypeId),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'metadataJson': serializer.toJson<String?>(metadataJson),
    };
  }

  CoinTransactionRow copyWith({
    String? id,
    String? installedCollectionId,
    CoinTransactionType? transactionType,
    int? amount,
    int? balanceAfter,
    Value<String?> relatedCardId = const Value.absent(),
    Value<String?> relatedPackTypeId = const Value.absent(),
    DateTime? createdAtUtc,
    Value<String?> metadataJson = const Value.absent(),
  }) => CoinTransactionRow(
    id: id ?? this.id,
    installedCollectionId: installedCollectionId ?? this.installedCollectionId,
    transactionType: transactionType ?? this.transactionType,
    amount: amount ?? this.amount,
    balanceAfter: balanceAfter ?? this.balanceAfter,
    relatedCardId: relatedCardId.present
        ? relatedCardId.value
        : this.relatedCardId,
    relatedPackTypeId: relatedPackTypeId.present
        ? relatedPackTypeId.value
        : this.relatedPackTypeId,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    metadataJson: metadataJson.present ? metadataJson.value : this.metadataJson,
  );
  CoinTransactionRow copyWithCompanion(CoinTransactionsCompanion data) {
    return CoinTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      installedCollectionId: data.installedCollectionId.present
          ? data.installedCollectionId.value
          : this.installedCollectionId,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      amount: data.amount.present ? data.amount.value : this.amount,
      balanceAfter: data.balanceAfter.present
          ? data.balanceAfter.value
          : this.balanceAfter,
      relatedCardId: data.relatedCardId.present
          ? data.relatedCardId.value
          : this.relatedCardId,
      relatedPackTypeId: data.relatedPackTypeId.present
          ? data.relatedPackTypeId.value
          : this.relatedPackTypeId,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoinTransactionRow(')
          ..write('id: $id, ')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('transactionType: $transactionType, ')
          ..write('amount: $amount, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('relatedCardId: $relatedCardId, ')
          ..write('relatedPackTypeId: $relatedPackTypeId, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('metadataJson: $metadataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    installedCollectionId,
    transactionType,
    amount,
    balanceAfter,
    relatedCardId,
    relatedPackTypeId,
    createdAtUtc,
    metadataJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoinTransactionRow &&
          other.id == this.id &&
          other.installedCollectionId == this.installedCollectionId &&
          other.transactionType == this.transactionType &&
          other.amount == this.amount &&
          other.balanceAfter == this.balanceAfter &&
          other.relatedCardId == this.relatedCardId &&
          other.relatedPackTypeId == this.relatedPackTypeId &&
          other.createdAtUtc == this.createdAtUtc &&
          other.metadataJson == this.metadataJson);
}

class CoinTransactionsCompanion extends UpdateCompanion<CoinTransactionRow> {
  final Value<String> id;
  final Value<String> installedCollectionId;
  final Value<CoinTransactionType> transactionType;
  final Value<int> amount;
  final Value<int> balanceAfter;
  final Value<String?> relatedCardId;
  final Value<String?> relatedPackTypeId;
  final Value<DateTime> createdAtUtc;
  final Value<String?> metadataJson;
  final Value<int> rowid;
  const CoinTransactionsCompanion({
    this.id = const Value.absent(),
    this.installedCollectionId = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.amount = const Value.absent(),
    this.balanceAfter = const Value.absent(),
    this.relatedCardId = const Value.absent(),
    this.relatedPackTypeId = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoinTransactionsCompanion.insert({
    required String id,
    required String installedCollectionId,
    required CoinTransactionType transactionType,
    required int amount,
    required int balanceAfter,
    this.relatedCardId = const Value.absent(),
    this.relatedPackTypeId = const Value.absent(),
    required DateTime createdAtUtc,
    this.metadataJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       installedCollectionId = Value(installedCollectionId),
       transactionType = Value(transactionType),
       amount = Value(amount),
       balanceAfter = Value(balanceAfter),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<CoinTransactionRow> custom({
    Expression<String>? id,
    Expression<String>? installedCollectionId,
    Expression<String>? transactionType,
    Expression<int>? amount,
    Expression<int>? balanceAfter,
    Expression<String>? relatedCardId,
    Expression<String>? relatedPackTypeId,
    Expression<DateTime>? createdAtUtc,
    Expression<String>? metadataJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (installedCollectionId != null)
        'installed_collection_id': installedCollectionId,
      if (transactionType != null) 'transaction_type': transactionType,
      if (amount != null) 'amount': amount,
      if (balanceAfter != null) 'balance_after': balanceAfter,
      if (relatedCardId != null) 'related_card_id': relatedCardId,
      if (relatedPackTypeId != null) 'related_pack_type_id': relatedPackTypeId,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoinTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? installedCollectionId,
    Value<CoinTransactionType>? transactionType,
    Value<int>? amount,
    Value<int>? balanceAfter,
    Value<String?>? relatedCardId,
    Value<String?>? relatedPackTypeId,
    Value<DateTime>? createdAtUtc,
    Value<String?>? metadataJson,
    Value<int>? rowid,
  }) {
    return CoinTransactionsCompanion(
      id: id ?? this.id,
      installedCollectionId:
          installedCollectionId ?? this.installedCollectionId,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      relatedCardId: relatedCardId ?? this.relatedCardId,
      relatedPackTypeId: relatedPackTypeId ?? this.relatedPackTypeId,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      metadataJson: metadataJson ?? this.metadataJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (installedCollectionId.present) {
      map['installed_collection_id'] = Variable<String>(
        installedCollectionId.value,
      );
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(
        $CoinTransactionsTable.$convertertransactionType.toSql(
          transactionType.value,
        ),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (balanceAfter.present) {
      map['balance_after'] = Variable<int>(balanceAfter.value);
    }
    if (relatedCardId.present) {
      map['related_card_id'] = Variable<String>(relatedCardId.value);
    }
    if (relatedPackTypeId.present) {
      map['related_pack_type_id'] = Variable<String>(relatedPackTypeId.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoinTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('installedCollectionId: $installedCollectionId, ')
          ..write('transactionType: $transactionType, ')
          ..write('amount: $amount, ')
          ..write('balanceAfter: $balanceAfter, ')
          ..write('relatedCardId: $relatedCardId, ')
          ..write('relatedPackTypeId: $relatedPackTypeId, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MediaAssetsTable mediaAssets = $MediaAssetsTable(this);
  late final $ContentVersionsTable contentVersions = $ContentVersionsTable(
    this,
  );
  late final $PackTypesTable packTypes = $PackTypesTable(this);
  late final $CollectionProjectsTable collectionProjects =
      $CollectionProjectsTable(this);
  late final $InstalledCollectionsTable installedCollections =
      $InstalledCollectionsTable(this);
  late final $RaritiesTable rarities = $RaritiesTable(this);
  late final $CardsTable cards = $CardsTable(this);
  late final $CardFieldValuesTable cardFieldValues = $CardFieldValuesTable(
    this,
  );
  late final $PackCardPoolTable packCardPool = $PackCardPoolTable(this);
  late final $PackSlotRulesTable packSlotRules = $PackSlotRulesTable(this);
  late final $PackRarityProbabilitiesTable packRarityProbabilities =
      $PackRarityProbabilitiesTable(this);
  late final $PackInventoryTable packInventory = $PackInventoryTable(this);
  late final $OwnedCardsTable ownedCards = $OwnedCardsTable(this);
  late final $PackOpeningsTable packOpenings = $PackOpeningsTable(this);
  late final $PackOpeningCardsTable packOpeningCards = $PackOpeningCardsTable(
    this,
  );
  late final $CoinTransactionsTable coinTransactions = $CoinTransactionsTable(
    this,
  );
  late final Index idxCollectionProjectsCollectionId = Index(
    'idx_collection_projects_collection_id',
    'CREATE UNIQUE INDEX idx_collection_projects_collection_id ON collection_projects (collection_id)',
  );
  late final Index idxContentVersionsCollectionId = Index(
    'idx_content_versions_collection_id',
    'CREATE INDEX idx_content_versions_collection_id ON content_versions (collection_id)',
  );
  late final Index idxContentVersionsCurrent = Index(
    'idx_content_versions_current',
    'CREATE UNIQUE INDEX idx_content_versions_current ON content_versions (collection_id) WHERE is_current = 1',
  );
  late final Index idxInstalledCollectionsCollectionId = Index(
    'idx_installed_collections_collection_id',
    'CREATE INDEX idx_installed_collections_collection_id ON installed_collections (collection_id)',
  );
  late final Index idxRaritiesCollectionVersion = Index(
    'idx_rarities_collection_version',
    'CREATE INDEX idx_rarities_collection_version ON rarities (collection_id, content_version_id)',
  );
  late final Index idxCardsCollectionVersion = Index(
    'idx_cards_collection_version',
    'CREATE INDEX idx_cards_collection_version ON cards (collection_id, content_version_id)',
  );
  late final Index idxCardsRarityId = Index(
    'idx_cards_rarity_id',
    'CREATE INDEX idx_cards_rarity_id ON cards (rarity_id)',
  );
  late final Index idxCardFieldValuesCardId = Index(
    'idx_card_field_values_card_id',
    'CREATE INDEX idx_card_field_values_card_id ON card_field_values (card_id)',
  );
  late final Index idxMediaAssetsCollectionOwner = Index(
    'idx_media_assets_collection_owner',
    'CREATE INDEX idx_media_assets_collection_owner ON media_assets (collection_id, owner_type, owner_id)',
  );
  late final Index idxPackTypesCollectionVersion = Index(
    'idx_pack_types_collection_version',
    'CREATE INDEX idx_pack_types_collection_version ON pack_types (collection_id, content_version_id)',
  );
  late final Index idxPackTypesMain = Index(
    'idx_pack_types_main',
    'CREATE UNIQUE INDEX idx_pack_types_main ON pack_types (content_version_id) WHERE is_main = 1',
  );
  late final Index idxPackCardPoolCardId = Index(
    'idx_pack_card_pool_card_id',
    'CREATE INDEX idx_pack_card_pool_card_id ON pack_card_pool (card_id)',
  );
  late final Index idxPackSlotRulesPackTypeId = Index(
    'idx_pack_slot_rules_pack_type_id',
    'CREATE INDEX idx_pack_slot_rules_pack_type_id ON pack_slot_rules (pack_type_id)',
  );
  late final Index idxPackRarityProbabilitiesRarityId = Index(
    'idx_pack_rarity_probabilities_rarity_id',
    'CREATE INDEX idx_pack_rarity_probabilities_rarity_id ON pack_rarity_probabilities (rarity_id)',
  );
  late final Index idxPackInventoryInstalledCollectionId = Index(
    'idx_pack_inventory_installed_collection_id',
    'CREATE INDEX idx_pack_inventory_installed_collection_id ON pack_inventory (installed_collection_id)',
  );
  late final Index idxOwnedCardsInstalledCollectionId = Index(
    'idx_owned_cards_installed_collection_id',
    'CREATE INDEX idx_owned_cards_installed_collection_id ON owned_cards (installed_collection_id)',
  );
  late final Index idxPackOpeningsInstalledCollectionId = Index(
    'idx_pack_openings_installed_collection_id',
    'CREATE INDEX idx_pack_openings_installed_collection_id ON pack_openings (installed_collection_id)',
  );
  late final Index idxPackOpeningCardsCardId = Index(
    'idx_pack_opening_cards_card_id',
    'CREATE INDEX idx_pack_opening_cards_card_id ON pack_opening_cards (card_id)',
  );
  late final Index idxCoinTransactionsInstalledCollectionId = Index(
    'idx_coin_transactions_installed_collection_id',
    'CREATE INDEX idx_coin_transactions_installed_collection_id ON coin_transactions (installed_collection_id)',
  );
  late final CollectionProjectsDao collectionProjectsDao =
      CollectionProjectsDao(this as AppDatabase);
  late final ContentVersionsDao contentVersionsDao = ContentVersionsDao(
    this as AppDatabase,
  );
  late final RaritiesDao raritiesDao = RaritiesDao(this as AppDatabase);
  late final CardsDao cardsDao = CardsDao(this as AppDatabase);
  late final PackTypesDao packTypesDao = PackTypesDao(this as AppDatabase);
  late final InstalledCollectionsDao installedCollectionsDao =
      InstalledCollectionsDao(this as AppDatabase);
  late final PlayerProgressDao playerProgressDao = PlayerProgressDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mediaAssets,
    contentVersions,
    packTypes,
    collectionProjects,
    installedCollections,
    rarities,
    cards,
    cardFieldValues,
    packCardPool,
    packSlotRules,
    packRarityProbabilities,
    packInventory,
    ownedCards,
    packOpenings,
    packOpeningCards,
    coinTransactions,
    idxCollectionProjectsCollectionId,
    idxContentVersionsCollectionId,
    idxContentVersionsCurrent,
    idxInstalledCollectionsCollectionId,
    idxRaritiesCollectionVersion,
    idxCardsCollectionVersion,
    idxCardsRarityId,
    idxCardFieldValuesCardId,
    idxMediaAssetsCollectionOwner,
    idxPackTypesCollectionVersion,
    idxPackTypesMain,
    idxPackCardPoolCardId,
    idxPackSlotRulesPackTypeId,
    idxPackRarityProbabilitiesRarityId,
    idxPackInventoryInstalledCollectionId,
    idxOwnedCardsInstalledCollectionId,
    idxPackOpeningsInstalledCollectionId,
    idxPackOpeningCardsCardId,
    idxCoinTransactionsInstalledCollectionId,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'content_versions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_types', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_types', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_types', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('collection_projects', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pack_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('collection_projects', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pack_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('installed_collections', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'content_versions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('rarities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'content_versions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'media_assets',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cards', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('card_field_values', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pack_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_card_pool', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_card_pool', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pack_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_slot_rules', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installed_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_inventory', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installed_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('owned_cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installed_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_openings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pack_openings',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pack_opening_cards', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'installed_collections',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coin_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'cards',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coin_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pack_types',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coin_transactions', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$MediaAssetsTableCreateCompanionBuilder =
    MediaAssetsCompanion Function({
      required String id,
      required String collectionId,
      required MediaOwnerType ownerType,
      required String ownerId,
      required MediaType mediaType,
      required String relativePath,
      Value<String?> thumbnailRelativePath,
      required String mimeType,
      Value<int?> width,
      Value<int?> height,
      Value<int?> durationMs,
      required int fileSize,
      Value<String?> sha256,
      required DateTime createdAtUtc,
      Value<int> rowid,
    });
typedef $$MediaAssetsTableUpdateCompanionBuilder =
    MediaAssetsCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<MediaOwnerType> ownerType,
      Value<String> ownerId,
      Value<MediaType> mediaType,
      Value<String> relativePath,
      Value<String?> thumbnailRelativePath,
      Value<String> mimeType,
      Value<int?> width,
      Value<int?> height,
      Value<int?> durationMs,
      Value<int> fileSize,
      Value<String?> sha256,
      Value<DateTime> createdAtUtc,
      Value<int> rowid,
    });

final class $$MediaAssetsTableReferences
    extends BaseReferences<_$AppDatabase, $MediaAssetsTable, MediaAssetRow> {
  $$MediaAssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PackTypesTable, List<PackTypeRow>>
  _frontPackTypesTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packTypes,
    aliasName: 'media_assets__id__pack_types__front_asset_id',
  );

  $$PackTypesTableProcessedTableManager get frontPackTypes {
    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.frontAssetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_frontPackTypesTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackTypesTable, List<PackTypeRow>>
  _backPackTypesTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packTypes,
    aliasName: 'media_assets__id__pack_types__back_asset_id',
  );

  $$PackTypesTableProcessedTableManager get backPackTypes {
    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.backAssetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_backPackTypesTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CollectionProjectsTable,
    List<CollectionProjectRow>
  >
  _collectionProjectsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionProjects,
        aliasName: 'media_assets__id__collection_projects__cover_asset_id',
      );

  $$CollectionProjectsTableProcessedTableManager get collectionProjectsRefs {
    final manager = $$CollectionProjectsTableTableManager(
      $_db,
      $_db.collectionProjects,
    ).filter((f) => f.coverAssetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionProjectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardsTable, List<CardRow>> _primaryCardsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cards,
    aliasName: 'media_assets__id__cards__media_asset_id',
  );

  $$CardsTableProcessedTableManager get primaryCards {
    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.mediaAssetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_primaryCardsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardsTable, List<CardRow>> _thumbnailCardsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cards,
    aliasName: 'media_assets__id__cards__thumbnail_asset_id',
  );

  $$CardsTableProcessedTableManager get thumbnailCards {
    final manager = $$CardsTableTableManager($_db, $_db.cards).filter(
      (f) => f.thumbnailAssetId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_thumbnailCardsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MediaAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MediaOwnerType, MediaOwnerType, String>
  get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MediaType, MediaType, String> get mediaType =>
      $composableBuilder(
        column: $table.mediaType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailRelativePath => $composableBuilder(
    column: $table.thumbnailRelativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> frontPackTypes(
    Expression<bool> Function($$PackTypesTableFilterComposer f) f,
  ) {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.frontAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> backPackTypes(
    Expression<bool> Function($$PackTypesTableFilterComposer f) f,
  ) {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.backAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> collectionProjectsRefs(
    Expression<bool> Function($$CollectionProjectsTableFilterComposer f) f,
  ) {
    final $$CollectionProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionProjects,
      getReferencedColumn: (t) => t.coverAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionProjectsTableFilterComposer(
            $db: $db,
            $table: $db.collectionProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> primaryCards(
    Expression<bool> Function($$CardsTableFilterComposer f) f,
  ) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.mediaAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> thumbnailCards(
    Expression<bool> Function($$CardsTableFilterComposer f) f,
  ) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.thumbnailAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailRelativePath => $composableBuilder(
    column: $table.thumbnailRelativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MediaAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MediaAssetsTable> {
  $$MediaAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MediaOwnerType, String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MediaType, String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get thumbnailRelativePath => $composableBuilder(
    column: $table.thumbnailRelativePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  Expression<T> frontPackTypes<T extends Object>(
    Expression<T> Function($$PackTypesTableAnnotationComposer a) f,
  ) {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.frontAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> backPackTypes<T extends Object>(
    Expression<T> Function($$PackTypesTableAnnotationComposer a) f,
  ) {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.backAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> collectionProjectsRefs<T extends Object>(
    Expression<T> Function($$CollectionProjectsTableAnnotationComposer a) f,
  ) {
    final $$CollectionProjectsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionProjects,
          getReferencedColumn: (t) => t.coverAssetId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionProjectsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionProjects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> primaryCards<T extends Object>(
    Expression<T> Function($$CardsTableAnnotationComposer a) f,
  ) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.mediaAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> thumbnailCards<T extends Object>(
    Expression<T> Function($$CardsTableAnnotationComposer a) f,
  ) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.thumbnailAssetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MediaAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MediaAssetsTable,
          MediaAssetRow,
          $$MediaAssetsTableFilterComposer,
          $$MediaAssetsTableOrderingComposer,
          $$MediaAssetsTableAnnotationComposer,
          $$MediaAssetsTableCreateCompanionBuilder,
          $$MediaAssetsTableUpdateCompanionBuilder,
          (MediaAssetRow, $$MediaAssetsTableReferences),
          MediaAssetRow,
          PrefetchHooks Function({
            bool frontPackTypes,
            bool backPackTypes,
            bool collectionProjectsRefs,
            bool primaryCards,
            bool thumbnailCards,
          })
        > {
  $$MediaAssetsTableTableManager(_$AppDatabase db, $MediaAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MediaAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MediaAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MediaAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<MediaOwnerType> ownerType = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<MediaType> mediaType = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<String?> thumbnailRelativePath = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MediaAssetsCompanion(
                id: id,
                collectionId: collectionId,
                ownerType: ownerType,
                ownerId: ownerId,
                mediaType: mediaType,
                relativePath: relativePath,
                thumbnailRelativePath: thumbnailRelativePath,
                mimeType: mimeType,
                width: width,
                height: height,
                durationMs: durationMs,
                fileSize: fileSize,
                sha256: sha256,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required MediaOwnerType ownerType,
                required String ownerId,
                required MediaType mediaType,
                required String relativePath,
                Value<String?> thumbnailRelativePath = const Value.absent(),
                required String mimeType,
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int?> durationMs = const Value.absent(),
                required int fileSize,
                Value<String?> sha256 = const Value.absent(),
                required DateTime createdAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => MediaAssetsCompanion.insert(
                id: id,
                collectionId: collectionId,
                ownerType: ownerType,
                ownerId: ownerId,
                mediaType: mediaType,
                relativePath: relativePath,
                thumbnailRelativePath: thumbnailRelativePath,
                mimeType: mimeType,
                width: width,
                height: height,
                durationMs: durationMs,
                fileSize: fileSize,
                sha256: sha256,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MediaAssetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                frontPackTypes = false,
                backPackTypes = false,
                collectionProjectsRefs = false,
                primaryCards = false,
                thumbnailCards = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (frontPackTypes) db.packTypes,
                    if (backPackTypes) db.packTypes,
                    if (collectionProjectsRefs) db.collectionProjects,
                    if (primaryCards) db.cards,
                    if (thumbnailCards) db.cards,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (frontPackTypes)
                        await $_getPrefetchedData<
                          MediaAssetRow,
                          $MediaAssetsTable,
                          PackTypeRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaAssetsTableReferences
                              ._frontPackTypesTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).frontPackTypes,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.frontAssetId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (backPackTypes)
                        await $_getPrefetchedData<
                          MediaAssetRow,
                          $MediaAssetsTable,
                          PackTypeRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaAssetsTableReferences
                              ._backPackTypesTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).backPackTypes,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.backAssetId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (collectionProjectsRefs)
                        await $_getPrefetchedData<
                          MediaAssetRow,
                          $MediaAssetsTable,
                          CollectionProjectRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaAssetsTableReferences
                              ._collectionProjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionProjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coverAssetId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (primaryCards)
                        await $_getPrefetchedData<
                          MediaAssetRow,
                          $MediaAssetsTable,
                          CardRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaAssetsTableReferences
                              ._primaryCardsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).primaryCards,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mediaAssetId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (thumbnailCards)
                        await $_getPrefetchedData<
                          MediaAssetRow,
                          $MediaAssetsTable,
                          CardRow
                        >(
                          currentTable: table,
                          referencedTable: $$MediaAssetsTableReferences
                              ._thumbnailCardsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MediaAssetsTableReferences(
                                db,
                                table,
                                p0,
                              ).thumbnailCards,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.thumbnailAssetId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MediaAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MediaAssetsTable,
      MediaAssetRow,
      $$MediaAssetsTableFilterComposer,
      $$MediaAssetsTableOrderingComposer,
      $$MediaAssetsTableAnnotationComposer,
      $$MediaAssetsTableCreateCompanionBuilder,
      $$MediaAssetsTableUpdateCompanionBuilder,
      (MediaAssetRow, $$MediaAssetsTableReferences),
      MediaAssetRow,
      PrefetchHooks Function({
        bool frontPackTypes,
        bool backPackTypes,
        bool collectionProjectsRefs,
        bool primaryCards,
        bool thumbnailCards,
      })
    >;
typedef $$ContentVersionsTableCreateCompanionBuilder =
    ContentVersionsCompanion Function({
      required String id,
      required String collectionId,
      required int versionNumber,
      required int formatVersion,
      required DateTime createdAtUtc,
      Value<DateTime?> finalizedAtUtc,
      required bool isCurrent,
      Value<int> rowid,
    });
typedef $$ContentVersionsTableUpdateCompanionBuilder =
    ContentVersionsCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<int> versionNumber,
      Value<int> formatVersion,
      Value<DateTime> createdAtUtc,
      Value<DateTime?> finalizedAtUtc,
      Value<bool> isCurrent,
      Value<int> rowid,
    });

final class $$ContentVersionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ContentVersionsTable,
          ContentVersionRow
        > {
  $$ContentVersionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$PackTypesTable, List<PackTypeRow>>
  _packTypesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packTypes,
    aliasName: 'content_versions__id__pack_types__content_version_id',
  );

  $$PackTypesTableProcessedTableManager get packTypesRefs {
    final manager = $$PackTypesTableTableManager($_db, $_db.packTypes).filter(
      (f) => f.contentVersionId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_packTypesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CollectionProjectsTable,
    List<CollectionProjectRow>
  >
  _collectionProjectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.collectionProjects,
    aliasName:
        'content_versions__id__collection_projects__current_content_version_id',
  );

  $$CollectionProjectsTableProcessedTableManager get collectionProjectsRefs {
    final manager =
        $$CollectionProjectsTableTableManager(
          $_db,
          $_db.collectionProjects,
        ).filter(
          (f) => f.currentContentVersionId.id.sqlEquals(
            $_itemColumn<String>('id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _collectionProjectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstalledCollectionsTable,
    List<InstalledCollectionRow>
  >
  _installedCollectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installedCollections,
        aliasName:
            'content_versions__id__installed_collections__content_version_id',
      );

  $$InstalledCollectionsTableProcessedTableManager
  get installedCollectionsRefs {
    final manager =
        $$InstalledCollectionsTableTableManager(
          $_db,
          $_db.installedCollections,
        ).filter(
          (f) => f.contentVersionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _installedCollectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RaritiesTable, List<RarityRow>>
  _raritiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rarities,
    aliasName: 'content_versions__id__rarities__content_version_id',
  );

  $$RaritiesTableProcessedTableManager get raritiesRefs {
    final manager = $$RaritiesTableTableManager($_db, $_db.rarities).filter(
      (f) => f.contentVersionId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_raritiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CardsTable, List<CardRow>> _cardsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cards,
    aliasName: 'content_versions__id__cards__content_version_id',
  );

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager($_db, $_db.cards).filter(
      (f) => f.contentVersionId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContentVersionsTableFilterComposer
    extends Composer<_$AppDatabase, $ContentVersionsTable> {
  $$ContentVersionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versionNumber => $composableBuilder(
    column: $table.versionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finalizedAtUtc => $composableBuilder(
    column: $table.finalizedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> packTypesRefs(
    Expression<bool> Function($$PackTypesTableFilterComposer f) f,
  ) {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> collectionProjectsRefs(
    Expression<bool> Function($$CollectionProjectsTableFilterComposer f) f,
  ) {
    final $$CollectionProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionProjects,
      getReferencedColumn: (t) => t.currentContentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionProjectsTableFilterComposer(
            $db: $db,
            $table: $db.collectionProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installedCollectionsRefs(
    Expression<bool> Function($$InstalledCollectionsTableFilterComposer f) f,
  ) {
    final $$InstalledCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installedCollections,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstalledCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.installedCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> raritiesRefs(
    Expression<bool> Function($$RaritiesTableFilterComposer f) f,
  ) {
    final $$RaritiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableFilterComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cardsRefs(
    Expression<bool> Function($$CardsTableFilterComposer f) f,
  ) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentVersionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContentVersionsTable> {
  $$ContentVersionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versionNumber => $composableBuilder(
    column: $table.versionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finalizedAtUtc => $composableBuilder(
    column: $table.finalizedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContentVersionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContentVersionsTable> {
  $$ContentVersionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get versionNumber => $composableBuilder(
    column: $table.versionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get finalizedAtUtc => $composableBuilder(
    column: $table.finalizedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);

  Expression<T> packTypesRefs<T extends Object>(
    Expression<T> Function($$PackTypesTableAnnotationComposer a) f,
  ) {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> collectionProjectsRefs<T extends Object>(
    Expression<T> Function($$CollectionProjectsTableAnnotationComposer a) f,
  ) {
    final $$CollectionProjectsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionProjects,
          getReferencedColumn: (t) => t.currentContentVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionProjectsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionProjects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installedCollectionsRefs<T extends Object>(
    Expression<T> Function($$InstalledCollectionsTableAnnotationComposer a) f,
  ) {
    final $$InstalledCollectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.contentVersionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> raritiesRefs<T extends Object>(
    Expression<T> Function($$RaritiesTableAnnotationComposer a) f,
  ) {
    final $$RaritiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableAnnotationComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cardsRefs<T extends Object>(
    Expression<T> Function($$CardsTableAnnotationComposer a) f,
  ) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.contentVersionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentVersionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContentVersionsTable,
          ContentVersionRow,
          $$ContentVersionsTableFilterComposer,
          $$ContentVersionsTableOrderingComposer,
          $$ContentVersionsTableAnnotationComposer,
          $$ContentVersionsTableCreateCompanionBuilder,
          $$ContentVersionsTableUpdateCompanionBuilder,
          (ContentVersionRow, $$ContentVersionsTableReferences),
          ContentVersionRow,
          PrefetchHooks Function({
            bool packTypesRefs,
            bool collectionProjectsRefs,
            bool installedCollectionsRefs,
            bool raritiesRefs,
            bool cardsRefs,
          })
        > {
  $$ContentVersionsTableTableManager(
    _$AppDatabase db,
    $ContentVersionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentVersionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentVersionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentVersionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<int> versionNumber = const Value.absent(),
                Value<int> formatVersion = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<DateTime?> finalizedAtUtc = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContentVersionsCompanion(
                id: id,
                collectionId: collectionId,
                versionNumber: versionNumber,
                formatVersion: formatVersion,
                createdAtUtc: createdAtUtc,
                finalizedAtUtc: finalizedAtUtc,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required int versionNumber,
                required int formatVersion,
                required DateTime createdAtUtc,
                Value<DateTime?> finalizedAtUtc = const Value.absent(),
                required bool isCurrent,
                Value<int> rowid = const Value.absent(),
              }) => ContentVersionsCompanion.insert(
                id: id,
                collectionId: collectionId,
                versionNumber: versionNumber,
                formatVersion: formatVersion,
                createdAtUtc: createdAtUtc,
                finalizedAtUtc: finalizedAtUtc,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentVersionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                packTypesRefs = false,
                collectionProjectsRefs = false,
                installedCollectionsRefs = false,
                raritiesRefs = false,
                cardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (packTypesRefs) db.packTypes,
                    if (collectionProjectsRefs) db.collectionProjects,
                    if (installedCollectionsRefs) db.installedCollections,
                    if (raritiesRefs) db.rarities,
                    if (cardsRefs) db.cards,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (packTypesRefs)
                        await $_getPrefetchedData<
                          ContentVersionRow,
                          $ContentVersionsTable,
                          PackTypeRow
                        >(
                          currentTable: table,
                          referencedTable: $$ContentVersionsTableReferences
                              ._packTypesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).packTypesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (collectionProjectsRefs)
                        await $_getPrefetchedData<
                          ContentVersionRow,
                          $ContentVersionsTable,
                          CollectionProjectRow
                        >(
                          currentTable: table,
                          referencedTable: $$ContentVersionsTableReferences
                              ._collectionProjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionProjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.currentContentVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installedCollectionsRefs)
                        await $_getPrefetchedData<
                          ContentVersionRow,
                          $ContentVersionsTable,
                          InstalledCollectionRow
                        >(
                          currentTable: table,
                          referencedTable: $$ContentVersionsTableReferences
                              ._installedCollectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).installedCollectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (raritiesRefs)
                        await $_getPrefetchedData<
                          ContentVersionRow,
                          $ContentVersionsTable,
                          RarityRow
                        >(
                          currentTable: table,
                          referencedTable: $$ContentVersionsTableReferences
                              ._raritiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).raritiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cardsRefs)
                        await $_getPrefetchedData<
                          ContentVersionRow,
                          $ContentVersionsTable,
                          CardRow
                        >(
                          currentTable: table,
                          referencedTable: $$ContentVersionsTableReferences
                              ._cardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentVersionsTableReferences(
                                db,
                                table,
                                p0,
                              ).cardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentVersionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ContentVersionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContentVersionsTable,
      ContentVersionRow,
      $$ContentVersionsTableFilterComposer,
      $$ContentVersionsTableOrderingComposer,
      $$ContentVersionsTableAnnotationComposer,
      $$ContentVersionsTableCreateCompanionBuilder,
      $$ContentVersionsTableUpdateCompanionBuilder,
      (ContentVersionRow, $$ContentVersionsTableReferences),
      ContentVersionRow,
      PrefetchHooks Function({
        bool packTypesRefs,
        bool collectionProjectsRefs,
        bool installedCollectionsRefs,
        bool raritiesRefs,
        bool cardsRefs,
      })
    >;
typedef $$PackTypesTableCreateCompanionBuilder =
    PackTypesCompanion Function({
      required String id,
      required String collectionId,
      required String contentVersionId,
      required String name,
      Value<String?> description,
      Value<String?> frontAssetId,
      Value<String?> backAssetId,
      required int cardCount,
      required int rechargeSeconds,
      required int maxAccumulated,
      required bool isMain,
      required int coinsPerFullRecharge,
      required int sortIndex,
      Value<int> rowid,
    });
typedef $$PackTypesTableUpdateCompanionBuilder =
    PackTypesCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> contentVersionId,
      Value<String> name,
      Value<String?> description,
      Value<String?> frontAssetId,
      Value<String?> backAssetId,
      Value<int> cardCount,
      Value<int> rechargeSeconds,
      Value<int> maxAccumulated,
      Value<bool> isMain,
      Value<int> coinsPerFullRecharge,
      Value<int> sortIndex,
      Value<int> rowid,
    });

final class $$PackTypesTableReferences
    extends BaseReferences<_$AppDatabase, $PackTypesTable, PackTypeRow> {
  $$PackTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContentVersionsTable _contentVersionIdTable(_$AppDatabase db) => db
      .contentVersions
      .createAlias('pack_types__content_version_id__content_versions__id');

  $$ContentVersionsTableProcessedTableManager get contentVersionId {
    final $_column = $_itemColumn<String>('content_version_id')!;

    final manager = $$ContentVersionsTableTableManager(
      $_db,
      $_db.contentVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentVersionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaAssetsTable _frontAssetIdTable(_$AppDatabase db) => db
      .mediaAssets
      .createAlias('pack_types__front_asset_id__media_assets__id');

  $$MediaAssetsTableProcessedTableManager? get frontAssetId {
    final $_column = $_itemColumn<String>('front_asset_id');
    if ($_column == null) return null;
    final manager = $$MediaAssetsTableTableManager(
      $_db,
      $_db.mediaAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_frontAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaAssetsTable _backAssetIdTable(_$AppDatabase db) =>
      db.mediaAssets.createAlias('pack_types__back_asset_id__media_assets__id');

  $$MediaAssetsTableProcessedTableManager? get backAssetId {
    final $_column = $_itemColumn<String>('back_asset_id');
    if ($_column == null) return null;
    final manager = $$MediaAssetsTableTableManager(
      $_db,
      $_db.mediaAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_backAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CollectionProjectsTable,
    List<CollectionProjectRow>
  >
  _collectionProjectsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionProjects,
        aliasName: 'pack_types__id__collection_projects__main_pack_type_id',
      );

  $$CollectionProjectsTableProcessedTableManager get collectionProjectsRefs {
    final manager = $$CollectionProjectsTableTableManager(
      $_db,
      $_db.collectionProjects,
    ).filter((f) => f.mainPackTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionProjectsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InstalledCollectionsTable,
    List<InstalledCollectionRow>
  >
  _installedCollectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.installedCollections,
        aliasName: 'pack_types__id__installed_collections__main_pack_type_id',
      );

  $$InstalledCollectionsTableProcessedTableManager
  get installedCollectionsRefs {
    final manager = $$InstalledCollectionsTableTableManager(
      $_db,
      $_db.installedCollections,
    ).filter((f) => f.mainPackTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _installedCollectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackCardPoolTable, List<PackCardPoolRow>>
  _packCardPoolRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packCardPool,
    aliasName: 'pack_types__id__pack_card_pool__pack_type_id',
  );

  $$PackCardPoolTableProcessedTableManager get packCardPoolRefs {
    final manager = $$PackCardPoolTableTableManager(
      $_db,
      $_db.packCardPool,
    ).filter((f) => f.packTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_packCardPoolRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackSlotRulesTable, List<PackSlotRuleRow>>
  _packSlotRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packSlotRules,
    aliasName: 'pack_types__id__pack_slot_rules__pack_type_id',
  );

  $$PackSlotRulesTableProcessedTableManager get packSlotRulesRefs {
    final manager = $$PackSlotRulesTableTableManager(
      $_db,
      $_db.packSlotRules,
    ).filter((f) => f.packTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_packSlotRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackInventoryTable, List<PackInventoryRow>>
  _packInventoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packInventory,
    aliasName: 'pack_types__id__pack_inventory__pack_type_id',
  );

  $$PackInventoryTableProcessedTableManager get packInventoryRefs {
    final manager = $$PackInventoryTableTableManager(
      $_db,
      $_db.packInventory,
    ).filter((f) => f.packTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_packInventoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackOpeningsTable, List<PackOpeningRow>>
  _packOpeningsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packOpenings,
    aliasName: 'pack_types__id__pack_openings__pack_type_id',
  );

  $$PackOpeningsTableProcessedTableManager get packOpeningsRefs {
    final manager = $$PackOpeningsTableTableManager(
      $_db,
      $_db.packOpenings,
    ).filter((f) => f.packTypeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_packOpeningsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoinTransactionsTable, List<CoinTransactionRow>>
  _coinTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coinTransactions,
    aliasName: 'pack_types__id__coin_transactions__related_pack_type_id',
  );

  $$CoinTransactionsTableProcessedTableManager get coinTransactionsRefs {
    final manager =
        $$CoinTransactionsTableTableManager($_db, $_db.coinTransactions).filter(
          (f) => f.relatedPackTypeId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _coinTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PackTypesTableFilterComposer
    extends Composer<_$AppDatabase, $PackTypesTable> {
  $$PackTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cardCount => $composableBuilder(
    column: $table.cardCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rechargeSeconds => $composableBuilder(
    column: $table.rechargeSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAccumulated => $composableBuilder(
    column: $table.maxAccumulated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMain => $composableBuilder(
    column: $table.isMain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coinsPerFullRecharge => $composableBuilder(
    column: $table.coinsPerFullRecharge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentVersionsTableFilterComposer get contentVersionId {
    final $$ContentVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableFilterComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableFilterComposer get frontAssetId {
    final $$MediaAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.frontAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableFilterComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableFilterComposer get backAssetId {
    final $$MediaAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableFilterComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> collectionProjectsRefs(
    Expression<bool> Function($$CollectionProjectsTableFilterComposer f) f,
  ) {
    final $$CollectionProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionProjects,
      getReferencedColumn: (t) => t.mainPackTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionProjectsTableFilterComposer(
            $db: $db,
            $table: $db.collectionProjects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> installedCollectionsRefs(
    Expression<bool> Function($$InstalledCollectionsTableFilterComposer f) f,
  ) {
    final $$InstalledCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.installedCollections,
      getReferencedColumn: (t) => t.mainPackTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstalledCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.installedCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packCardPoolRefs(
    Expression<bool> Function($$PackCardPoolTableFilterComposer f) f,
  ) {
    final $$PackCardPoolTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packCardPool,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackCardPoolTableFilterComposer(
            $db: $db,
            $table: $db.packCardPool,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packSlotRulesRefs(
    Expression<bool> Function($$PackSlotRulesTableFilterComposer f) f,
  ) {
    final $$PackSlotRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packSlotRules,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackSlotRulesTableFilterComposer(
            $db: $db,
            $table: $db.packSlotRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packInventoryRefs(
    Expression<bool> Function($$PackInventoryTableFilterComposer f) f,
  ) {
    final $$PackInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packInventory,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackInventoryTableFilterComposer(
            $db: $db,
            $table: $db.packInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packOpeningsRefs(
    Expression<bool> Function($$PackOpeningsTableFilterComposer f) f,
  ) {
    final $$PackOpeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableFilterComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coinTransactionsRefs(
    Expression<bool> Function($$CoinTransactionsTableFilterComposer f) f,
  ) {
    final $$CoinTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coinTransactions,
      getReferencedColumn: (t) => t.relatedPackTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoinTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.coinTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PackTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $PackTypesTable> {
  $$PackTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cardCount => $composableBuilder(
    column: $table.cardCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rechargeSeconds => $composableBuilder(
    column: $table.rechargeSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAccumulated => $composableBuilder(
    column: $table.maxAccumulated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMain => $composableBuilder(
    column: $table.isMain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coinsPerFullRecharge => $composableBuilder(
    column: $table.coinsPerFullRecharge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentVersionsTableOrderingComposer get contentVersionId {
    final $$ContentVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableOrderingComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableOrderingComposer get frontAssetId {
    final $$MediaAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.frontAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableOrderingComposer get backAssetId {
    final $$MediaAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackTypesTable> {
  $$PackTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cardCount =>
      $composableBuilder(column: $table.cardCount, builder: (column) => column);

  GeneratedColumn<int> get rechargeSeconds => $composableBuilder(
    column: $table.rechargeSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxAccumulated => $composableBuilder(
    column: $table.maxAccumulated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMain =>
      $composableBuilder(column: $table.isMain, builder: (column) => column);

  GeneratedColumn<int> get coinsPerFullRecharge => $composableBuilder(
    column: $table.coinsPerFullRecharge,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortIndex =>
      $composableBuilder(column: $table.sortIndex, builder: (column) => column);

  $$ContentVersionsTableAnnotationComposer get contentVersionId {
    final $$ContentVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableAnnotationComposer get frontAssetId {
    final $$MediaAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.frontAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableAnnotationComposer get backAssetId {
    final $$MediaAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> collectionProjectsRefs<T extends Object>(
    Expression<T> Function($$CollectionProjectsTableAnnotationComposer a) f,
  ) {
    final $$CollectionProjectsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionProjects,
          getReferencedColumn: (t) => t.mainPackTypeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionProjectsTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionProjects,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> installedCollectionsRefs<T extends Object>(
    Expression<T> Function($$InstalledCollectionsTableAnnotationComposer a) f,
  ) {
    final $$InstalledCollectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.mainPackTypeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> packCardPoolRefs<T extends Object>(
    Expression<T> Function($$PackCardPoolTableAnnotationComposer a) f,
  ) {
    final $$PackCardPoolTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packCardPool,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackCardPoolTableAnnotationComposer(
            $db: $db,
            $table: $db.packCardPool,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packSlotRulesRefs<T extends Object>(
    Expression<T> Function($$PackSlotRulesTableAnnotationComposer a) f,
  ) {
    final $$PackSlotRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packSlotRules,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackSlotRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.packSlotRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packInventoryRefs<T extends Object>(
    Expression<T> Function($$PackInventoryTableAnnotationComposer a) f,
  ) {
    final $$PackInventoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packInventory,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackInventoryTableAnnotationComposer(
            $db: $db,
            $table: $db.packInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packOpeningsRefs<T extends Object>(
    Expression<T> Function($$PackOpeningsTableAnnotationComposer a) f,
  ) {
    final $$PackOpeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.packTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coinTransactionsRefs<T extends Object>(
    Expression<T> Function($$CoinTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CoinTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coinTransactions,
      getReferencedColumn: (t) => t.relatedPackTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoinTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.coinTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PackTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackTypesTable,
          PackTypeRow,
          $$PackTypesTableFilterComposer,
          $$PackTypesTableOrderingComposer,
          $$PackTypesTableAnnotationComposer,
          $$PackTypesTableCreateCompanionBuilder,
          $$PackTypesTableUpdateCompanionBuilder,
          (PackTypeRow, $$PackTypesTableReferences),
          PackTypeRow,
          PrefetchHooks Function({
            bool contentVersionId,
            bool frontAssetId,
            bool backAssetId,
            bool collectionProjectsRefs,
            bool installedCollectionsRefs,
            bool packCardPoolRefs,
            bool packSlotRulesRefs,
            bool packInventoryRefs,
            bool packOpeningsRefs,
            bool coinTransactionsRefs,
          })
        > {
  $$PackTypesTableTableManager(_$AppDatabase db, $PackTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> contentVersionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> frontAssetId = const Value.absent(),
                Value<String?> backAssetId = const Value.absent(),
                Value<int> cardCount = const Value.absent(),
                Value<int> rechargeSeconds = const Value.absent(),
                Value<int> maxAccumulated = const Value.absent(),
                Value<bool> isMain = const Value.absent(),
                Value<int> coinsPerFullRecharge = const Value.absent(),
                Value<int> sortIndex = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackTypesCompanion(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                name: name,
                description: description,
                frontAssetId: frontAssetId,
                backAssetId: backAssetId,
                cardCount: cardCount,
                rechargeSeconds: rechargeSeconds,
                maxAccumulated: maxAccumulated,
                isMain: isMain,
                coinsPerFullRecharge: coinsPerFullRecharge,
                sortIndex: sortIndex,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String contentVersionId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> frontAssetId = const Value.absent(),
                Value<String?> backAssetId = const Value.absent(),
                required int cardCount,
                required int rechargeSeconds,
                required int maxAccumulated,
                required bool isMain,
                required int coinsPerFullRecharge,
                required int sortIndex,
                Value<int> rowid = const Value.absent(),
              }) => PackTypesCompanion.insert(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                name: name,
                description: description,
                frontAssetId: frontAssetId,
                backAssetId: backAssetId,
                cardCount: cardCount,
                rechargeSeconds: rechargeSeconds,
                maxAccumulated: maxAccumulated,
                isMain: isMain,
                coinsPerFullRecharge: coinsPerFullRecharge,
                sortIndex: sortIndex,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                contentVersionId = false,
                frontAssetId = false,
                backAssetId = false,
                collectionProjectsRefs = false,
                installedCollectionsRefs = false,
                packCardPoolRefs = false,
                packSlotRulesRefs = false,
                packInventoryRefs = false,
                packOpeningsRefs = false,
                coinTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectionProjectsRefs) db.collectionProjects,
                    if (installedCollectionsRefs) db.installedCollections,
                    if (packCardPoolRefs) db.packCardPool,
                    if (packSlotRulesRefs) db.packSlotRules,
                    if (packInventoryRefs) db.packInventory,
                    if (packOpeningsRefs) db.packOpenings,
                    if (coinTransactionsRefs) db.coinTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (contentVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contentVersionId,
                                    referencedTable: $$PackTypesTableReferences
                                        ._contentVersionIdTable(db),
                                    referencedColumn: $$PackTypesTableReferences
                                        ._contentVersionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (frontAssetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.frontAssetId,
                                    referencedTable: $$PackTypesTableReferences
                                        ._frontAssetIdTable(db),
                                    referencedColumn: $$PackTypesTableReferences
                                        ._frontAssetIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (backAssetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.backAssetId,
                                    referencedTable: $$PackTypesTableReferences
                                        ._backAssetIdTable(db),
                                    referencedColumn: $$PackTypesTableReferences
                                        ._backAssetIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (collectionProjectsRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          CollectionProjectRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._collectionProjectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionProjectsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mainPackTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (installedCollectionsRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          InstalledCollectionRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._installedCollectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).installedCollectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.mainPackTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packCardPoolRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          PackCardPoolRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._packCardPoolRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).packCardPoolRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packSlotRulesRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          PackSlotRuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._packSlotRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).packSlotRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packInventoryRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          PackInventoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._packInventoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).packInventoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packOpeningsRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          PackOpeningRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._packOpeningsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).packOpeningsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.packTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coinTransactionsRefs)
                        await $_getPrefetchedData<
                          PackTypeRow,
                          $PackTypesTable,
                          CoinTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackTypesTableReferences
                              ._coinTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).coinTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.relatedPackTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PackTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackTypesTable,
      PackTypeRow,
      $$PackTypesTableFilterComposer,
      $$PackTypesTableOrderingComposer,
      $$PackTypesTableAnnotationComposer,
      $$PackTypesTableCreateCompanionBuilder,
      $$PackTypesTableUpdateCompanionBuilder,
      (PackTypeRow, $$PackTypesTableReferences),
      PackTypeRow,
      PrefetchHooks Function({
        bool contentVersionId,
        bool frontAssetId,
        bool backAssetId,
        bool collectionProjectsRefs,
        bool installedCollectionsRefs,
        bool packCardPoolRefs,
        bool packSlotRulesRefs,
        bool packInventoryRefs,
        bool packOpeningsRefs,
        bool coinTransactionsRefs,
      })
    >;
typedef $$CollectionProjectsTableCreateCompanionBuilder =
    CollectionProjectsCompanion Function({
      required String id,
      required String collectionId,
      required String name,
      Value<String?> author,
      Value<String?> description,
      Value<String?> coverAssetId,
      required CollectionProjectStatus status,
      required DateTime createdAtUtc,
      required DateTime updatedAtUtc,
      required int currentContentVersion,
      Value<String?> currentContentVersionId,
      Value<String?> mainPackTypeId,
      required int startingPackCount,
      Value<int> rowid,
    });
typedef $$CollectionProjectsTableUpdateCompanionBuilder =
    CollectionProjectsCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> name,
      Value<String?> author,
      Value<String?> description,
      Value<String?> coverAssetId,
      Value<CollectionProjectStatus> status,
      Value<DateTime> createdAtUtc,
      Value<DateTime> updatedAtUtc,
      Value<int> currentContentVersion,
      Value<String?> currentContentVersionId,
      Value<String?> mainPackTypeId,
      Value<int> startingPackCount,
      Value<int> rowid,
    });

final class $$CollectionProjectsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionProjectsTable,
          CollectionProjectRow
        > {
  $$CollectionProjectsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MediaAssetsTable _coverAssetIdTable(_$AppDatabase db) => db
      .mediaAssets
      .createAlias('collection_projects__cover_asset_id__media_assets__id');

  $$MediaAssetsTableProcessedTableManager? get coverAssetId {
    final $_column = $_itemColumn<String>('cover_asset_id');
    if ($_column == null) return null;
    final manager = $$MediaAssetsTableTableManager(
      $_db,
      $_db.mediaAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coverAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContentVersionsTable _currentContentVersionIdTable(
    _$AppDatabase db,
  ) => db.contentVersions.createAlias(
    'collection_projects__current_content_version_id__content_versions__id',
  );

  $$ContentVersionsTableProcessedTableManager? get currentContentVersionId {
    final $_column = $_itemColumn<String>('current_content_version_id');
    if ($_column == null) return null;
    final manager = $$ContentVersionsTableTableManager(
      $_db,
      $_db.contentVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _currentContentVersionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PackTypesTable _mainPackTypeIdTable(_$AppDatabase db) => db.packTypes
      .createAlias('collection_projects__main_pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager? get mainPackTypeId {
    final $_column = $_itemColumn<String>('main_pack_type_id');
    if ($_column == null) return null;
    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainPackTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionProjectsTable> {
  $$CollectionProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CollectionProjectStatus,
    CollectionProjectStatus,
    String
  >
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentContentVersion => $composableBuilder(
    column: $table.currentContentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startingPackCount => $composableBuilder(
    column: $table.startingPackCount,
    builder: (column) => ColumnFilters(column),
  );

  $$MediaAssetsTableFilterComposer get coverAssetId {
    final $$MediaAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableFilterComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentVersionsTableFilterComposer get currentContentVersionId {
    final $$ContentVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentContentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableFilterComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableFilterComposer get mainPackTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionProjectsTable> {
  $$CollectionProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentContentVersion => $composableBuilder(
    column: $table.currentContentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startingPackCount => $composableBuilder(
    column: $table.startingPackCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$MediaAssetsTableOrderingComposer get coverAssetId {
    final $$MediaAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentVersionsTableOrderingComposer get currentContentVersionId {
    final $$ContentVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentContentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableOrderingComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableOrderingComposer get mainPackTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionProjectsTable> {
  $$CollectionProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<CollectionProjectStatus, String>
  get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentContentVersion => $composableBuilder(
    column: $table.currentContentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get startingPackCount => $composableBuilder(
    column: $table.startingPackCount,
    builder: (column) => column,
  );

  $$MediaAssetsTableAnnotationComposer get coverAssetId {
    final $$MediaAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coverAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentVersionsTableAnnotationComposer get currentContentVersionId {
    final $$ContentVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.currentContentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableAnnotationComposer get mainPackTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionProjectsTable,
          CollectionProjectRow,
          $$CollectionProjectsTableFilterComposer,
          $$CollectionProjectsTableOrderingComposer,
          $$CollectionProjectsTableAnnotationComposer,
          $$CollectionProjectsTableCreateCompanionBuilder,
          $$CollectionProjectsTableUpdateCompanionBuilder,
          (CollectionProjectRow, $$CollectionProjectsTableReferences),
          CollectionProjectRow,
          PrefetchHooks Function({
            bool coverAssetId,
            bool currentContentVersionId,
            bool mainPackTypeId,
          })
        > {
  $$CollectionProjectsTableTableManager(
    _$AppDatabase db,
    $CollectionProjectsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionProjectsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> coverAssetId = const Value.absent(),
                Value<CollectionProjectStatus> status = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<DateTime> updatedAtUtc = const Value.absent(),
                Value<int> currentContentVersion = const Value.absent(),
                Value<String?> currentContentVersionId = const Value.absent(),
                Value<String?> mainPackTypeId = const Value.absent(),
                Value<int> startingPackCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CollectionProjectsCompanion(
                id: id,
                collectionId: collectionId,
                name: name,
                author: author,
                description: description,
                coverAssetId: coverAssetId,
                status: status,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
                currentContentVersion: currentContentVersion,
                currentContentVersionId: currentContentVersionId,
                mainPackTypeId: mainPackTypeId,
                startingPackCount: startingPackCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String name,
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> coverAssetId = const Value.absent(),
                required CollectionProjectStatus status,
                required DateTime createdAtUtc,
                required DateTime updatedAtUtc,
                required int currentContentVersion,
                Value<String?> currentContentVersionId = const Value.absent(),
                Value<String?> mainPackTypeId = const Value.absent(),
                required int startingPackCount,
                Value<int> rowid = const Value.absent(),
              }) => CollectionProjectsCompanion.insert(
                id: id,
                collectionId: collectionId,
                name: name,
                author: author,
                description: description,
                coverAssetId: coverAssetId,
                status: status,
                createdAtUtc: createdAtUtc,
                updatedAtUtc: updatedAtUtc,
                currentContentVersion: currentContentVersion,
                currentContentVersionId: currentContentVersionId,
                mainPackTypeId: mainPackTypeId,
                startingPackCount: startingPackCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                coverAssetId = false,
                currentContentVersionId = false,
                mainPackTypeId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (coverAssetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.coverAssetId,
                                    referencedTable:
                                        $$CollectionProjectsTableReferences
                                            ._coverAssetIdTable(db),
                                    referencedColumn:
                                        $$CollectionProjectsTableReferences
                                            ._coverAssetIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (currentContentVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn:
                                        table.currentContentVersionId,
                                    referencedTable:
                                        $$CollectionProjectsTableReferences
                                            ._currentContentVersionIdTable(db),
                                    referencedColumn:
                                        $$CollectionProjectsTableReferences
                                            ._currentContentVersionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (mainPackTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mainPackTypeId,
                                    referencedTable:
                                        $$CollectionProjectsTableReferences
                                            ._mainPackTypeIdTable(db),
                                    referencedColumn:
                                        $$CollectionProjectsTableReferences
                                            ._mainPackTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CollectionProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionProjectsTable,
      CollectionProjectRow,
      $$CollectionProjectsTableFilterComposer,
      $$CollectionProjectsTableOrderingComposer,
      $$CollectionProjectsTableAnnotationComposer,
      $$CollectionProjectsTableCreateCompanionBuilder,
      $$CollectionProjectsTableUpdateCompanionBuilder,
      (CollectionProjectRow, $$CollectionProjectsTableReferences),
      CollectionProjectRow,
      PrefetchHooks Function({
        bool coverAssetId,
        bool currentContentVersionId,
        bool mainPackTypeId,
      })
    >;
typedef $$InstalledCollectionsTableCreateCompanionBuilder =
    InstalledCollectionsCompanion Function({
      required String id,
      required String collectionId,
      required String contentVersionId,
      required String name,
      Value<String?> author,
      Value<String?> description,
      Value<String?> coverRelativePath,
      Value<String?> mainPackTypeId,
      required DateTime installedAtUtc,
      required InstalledCollectionSource source,
      required int coins,
      required int totalCardCount,
      required int distinctOwnedCount,
      Value<int> rowid,
    });
typedef $$InstalledCollectionsTableUpdateCompanionBuilder =
    InstalledCollectionsCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> contentVersionId,
      Value<String> name,
      Value<String?> author,
      Value<String?> description,
      Value<String?> coverRelativePath,
      Value<String?> mainPackTypeId,
      Value<DateTime> installedAtUtc,
      Value<InstalledCollectionSource> source,
      Value<int> coins,
      Value<int> totalCardCount,
      Value<int> distinctOwnedCount,
      Value<int> rowid,
    });

final class $$InstalledCollectionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InstalledCollectionsTable,
          InstalledCollectionRow
        > {
  $$InstalledCollectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ContentVersionsTable _contentVersionIdTable(_$AppDatabase db) =>
      db.contentVersions.createAlias(
        'installed_collections__content_version_id__content_versions__id',
      );

  $$ContentVersionsTableProcessedTableManager get contentVersionId {
    final $_column = $_itemColumn<String>('content_version_id')!;

    final manager = $$ContentVersionsTableTableManager(
      $_db,
      $_db.contentVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentVersionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PackTypesTable _mainPackTypeIdTable(_$AppDatabase db) => db.packTypes
      .createAlias('installed_collections__main_pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager? get mainPackTypeId {
    final $_column = $_itemColumn<String>('main_pack_type_id');
    if ($_column == null) return null;
    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mainPackTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PackInventoryTable, List<PackInventoryRow>>
  _packInventoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packInventory,
    aliasName:
        'installed_collections__id__pack_inventory__installed_collection_id',
  );

  $$PackInventoryTableProcessedTableManager get packInventoryRefs {
    final manager = $$PackInventoryTableTableManager($_db, $_db.packInventory)
        .filter(
          (f) =>
              f.installedCollectionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_packInventoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OwnedCardsTable, List<OwnedCardRow>>
  _ownedCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ownedCards,
    aliasName:
        'installed_collections__id__owned_cards__installed_collection_id',
  );

  $$OwnedCardsTableProcessedTableManager get ownedCardsRefs {
    final manager = $$OwnedCardsTableTableManager($_db, $_db.ownedCards).filter(
      (f) => f.installedCollectionId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_ownedCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackOpeningsTable, List<PackOpeningRow>>
  _packOpeningsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packOpenings,
    aliasName:
        'installed_collections__id__pack_openings__installed_collection_id',
  );

  $$PackOpeningsTableProcessedTableManager get packOpeningsRefs {
    final manager = $$PackOpeningsTableTableManager($_db, $_db.packOpenings)
        .filter(
          (f) =>
              f.installedCollectionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_packOpeningsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoinTransactionsTable, List<CoinTransactionRow>>
  _coinTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coinTransactions,
    aliasName:
        'installed_collections__id__coin_transactions__installed_collection_id',
  );

  $$CoinTransactionsTableProcessedTableManager get coinTransactionsRefs {
    final manager =
        $$CoinTransactionsTableTableManager($_db, $_db.coinTransactions).filter(
          (f) =>
              f.installedCollectionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _coinTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InstalledCollectionsTableFilterComposer
    extends Composer<_$AppDatabase, $InstalledCollectionsTable> {
  $$InstalledCollectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverRelativePath => $composableBuilder(
    column: $table.coverRelativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installedAtUtc => $composableBuilder(
    column: $table.installedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    InstalledCollectionSource,
    InstalledCollectionSource,
    String
  >
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCardCount => $composableBuilder(
    column: $table.totalCardCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get distinctOwnedCount => $composableBuilder(
    column: $table.distinctOwnedCount,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentVersionsTableFilterComposer get contentVersionId {
    final $$ContentVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableFilterComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableFilterComposer get mainPackTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> packInventoryRefs(
    Expression<bool> Function($$PackInventoryTableFilterComposer f) f,
  ) {
    final $$PackInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packInventory,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackInventoryTableFilterComposer(
            $db: $db,
            $table: $db.packInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ownedCardsRefs(
    Expression<bool> Function($$OwnedCardsTableFilterComposer f) f,
  ) {
    final $$OwnedCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ownedCards,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OwnedCardsTableFilterComposer(
            $db: $db,
            $table: $db.ownedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packOpeningsRefs(
    Expression<bool> Function($$PackOpeningsTableFilterComposer f) f,
  ) {
    final $$PackOpeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableFilterComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coinTransactionsRefs(
    Expression<bool> Function($$CoinTransactionsTableFilterComposer f) f,
  ) {
    final $$CoinTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coinTransactions,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoinTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.coinTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstalledCollectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InstalledCollectionsTable> {
  $$InstalledCollectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverRelativePath => $composableBuilder(
    column: $table.coverRelativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installedAtUtc => $composableBuilder(
    column: $table.installedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coins => $composableBuilder(
    column: $table.coins,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCardCount => $composableBuilder(
    column: $table.totalCardCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get distinctOwnedCount => $composableBuilder(
    column: $table.distinctOwnedCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentVersionsTableOrderingComposer get contentVersionId {
    final $$ContentVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableOrderingComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableOrderingComposer get mainPackTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InstalledCollectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InstalledCollectionsTable> {
  $$InstalledCollectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get coverRelativePath => $composableBuilder(
    column: $table.coverRelativePath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get installedAtUtc => $composableBuilder(
    column: $table.installedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<InstalledCollectionSource, String>
  get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get coins =>
      $composableBuilder(column: $table.coins, builder: (column) => column);

  GeneratedColumn<int> get totalCardCount => $composableBuilder(
    column: $table.totalCardCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get distinctOwnedCount => $composableBuilder(
    column: $table.distinctOwnedCount,
    builder: (column) => column,
  );

  $$ContentVersionsTableAnnotationComposer get contentVersionId {
    final $$ContentVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableAnnotationComposer get mainPackTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mainPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> packInventoryRefs<T extends Object>(
    Expression<T> Function($$PackInventoryTableAnnotationComposer a) f,
  ) {
    final $$PackInventoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packInventory,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackInventoryTableAnnotationComposer(
            $db: $db,
            $table: $db.packInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ownedCardsRefs<T extends Object>(
    Expression<T> Function($$OwnedCardsTableAnnotationComposer a) f,
  ) {
    final $$OwnedCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ownedCards,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OwnedCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.ownedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packOpeningsRefs<T extends Object>(
    Expression<T> Function($$PackOpeningsTableAnnotationComposer a) f,
  ) {
    final $$PackOpeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coinTransactionsRefs<T extends Object>(
    Expression<T> Function($$CoinTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CoinTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coinTransactions,
      getReferencedColumn: (t) => t.installedCollectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoinTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.coinTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InstalledCollectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InstalledCollectionsTable,
          InstalledCollectionRow,
          $$InstalledCollectionsTableFilterComposer,
          $$InstalledCollectionsTableOrderingComposer,
          $$InstalledCollectionsTableAnnotationComposer,
          $$InstalledCollectionsTableCreateCompanionBuilder,
          $$InstalledCollectionsTableUpdateCompanionBuilder,
          (InstalledCollectionRow, $$InstalledCollectionsTableReferences),
          InstalledCollectionRow,
          PrefetchHooks Function({
            bool contentVersionId,
            bool mainPackTypeId,
            bool packInventoryRefs,
            bool ownedCardsRefs,
            bool packOpeningsRefs,
            bool coinTransactionsRefs,
          })
        > {
  $$InstalledCollectionsTableTableManager(
    _$AppDatabase db,
    $InstalledCollectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InstalledCollectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InstalledCollectionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InstalledCollectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> contentVersionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> coverRelativePath = const Value.absent(),
                Value<String?> mainPackTypeId = const Value.absent(),
                Value<DateTime> installedAtUtc = const Value.absent(),
                Value<InstalledCollectionSource> source = const Value.absent(),
                Value<int> coins = const Value.absent(),
                Value<int> totalCardCount = const Value.absent(),
                Value<int> distinctOwnedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InstalledCollectionsCompanion(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                name: name,
                author: author,
                description: description,
                coverRelativePath: coverRelativePath,
                mainPackTypeId: mainPackTypeId,
                installedAtUtc: installedAtUtc,
                source: source,
                coins: coins,
                totalCardCount: totalCardCount,
                distinctOwnedCount: distinctOwnedCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String contentVersionId,
                required String name,
                Value<String?> author = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> coverRelativePath = const Value.absent(),
                Value<String?> mainPackTypeId = const Value.absent(),
                required DateTime installedAtUtc,
                required InstalledCollectionSource source,
                required int coins,
                required int totalCardCount,
                required int distinctOwnedCount,
                Value<int> rowid = const Value.absent(),
              }) => InstalledCollectionsCompanion.insert(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                name: name,
                author: author,
                description: description,
                coverRelativePath: coverRelativePath,
                mainPackTypeId: mainPackTypeId,
                installedAtUtc: installedAtUtc,
                source: source,
                coins: coins,
                totalCardCount: totalCardCount,
                distinctOwnedCount: distinctOwnedCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InstalledCollectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                contentVersionId = false,
                mainPackTypeId = false,
                packInventoryRefs = false,
                ownedCardsRefs = false,
                packOpeningsRefs = false,
                coinTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (packInventoryRefs) db.packInventory,
                    if (ownedCardsRefs) db.ownedCards,
                    if (packOpeningsRefs) db.packOpenings,
                    if (coinTransactionsRefs) db.coinTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (contentVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contentVersionId,
                                    referencedTable:
                                        $$InstalledCollectionsTableReferences
                                            ._contentVersionIdTable(db),
                                    referencedColumn:
                                        $$InstalledCollectionsTableReferences
                                            ._contentVersionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (mainPackTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mainPackTypeId,
                                    referencedTable:
                                        $$InstalledCollectionsTableReferences
                                            ._mainPackTypeIdTable(db),
                                    referencedColumn:
                                        $$InstalledCollectionsTableReferences
                                            ._mainPackTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (packInventoryRefs)
                        await $_getPrefetchedData<
                          InstalledCollectionRow,
                          $InstalledCollectionsTable,
                          PackInventoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$InstalledCollectionsTableReferences
                              ._packInventoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstalledCollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).packInventoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installedCollectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ownedCardsRefs)
                        await $_getPrefetchedData<
                          InstalledCollectionRow,
                          $InstalledCollectionsTable,
                          OwnedCardRow
                        >(
                          currentTable: table,
                          referencedTable: $$InstalledCollectionsTableReferences
                              ._ownedCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstalledCollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).ownedCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installedCollectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packOpeningsRefs)
                        await $_getPrefetchedData<
                          InstalledCollectionRow,
                          $InstalledCollectionsTable,
                          PackOpeningRow
                        >(
                          currentTable: table,
                          referencedTable: $$InstalledCollectionsTableReferences
                              ._packOpeningsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstalledCollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).packOpeningsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installedCollectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coinTransactionsRefs)
                        await $_getPrefetchedData<
                          InstalledCollectionRow,
                          $InstalledCollectionsTable,
                          CoinTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$InstalledCollectionsTableReferences
                              ._coinTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InstalledCollectionsTableReferences(
                                db,
                                table,
                                p0,
                              ).coinTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.installedCollectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InstalledCollectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InstalledCollectionsTable,
      InstalledCollectionRow,
      $$InstalledCollectionsTableFilterComposer,
      $$InstalledCollectionsTableOrderingComposer,
      $$InstalledCollectionsTableAnnotationComposer,
      $$InstalledCollectionsTableCreateCompanionBuilder,
      $$InstalledCollectionsTableUpdateCompanionBuilder,
      (InstalledCollectionRow, $$InstalledCollectionsTableReferences),
      InstalledCollectionRow,
      PrefetchHooks Function({
        bool contentVersionId,
        bool mainPackTypeId,
        bool packInventoryRefs,
        bool ownedCardsRefs,
        bool packOpeningsRefs,
        bool coinTransactionsRefs,
      })
    >;
typedef $$RaritiesTableCreateCompanionBuilder =
    RaritiesCompanion Function({
      required String id,
      required String collectionId,
      required String contentVersionId,
      required String name,
      required int orderIndex,
      required int colorValue,
      required String iconId,
      required String frameId,
      Value<String?> effectId,
      required int sellValue,
      required bool isEnabled,
      Value<int> rowid,
    });
typedef $$RaritiesTableUpdateCompanionBuilder =
    RaritiesCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> contentVersionId,
      Value<String> name,
      Value<int> orderIndex,
      Value<int> colorValue,
      Value<String> iconId,
      Value<String> frameId,
      Value<String?> effectId,
      Value<int> sellValue,
      Value<bool> isEnabled,
      Value<int> rowid,
    });

final class $$RaritiesTableReferences
    extends BaseReferences<_$AppDatabase, $RaritiesTable, RarityRow> {
  $$RaritiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContentVersionsTable _contentVersionIdTable(_$AppDatabase db) => db
      .contentVersions
      .createAlias('rarities__content_version_id__content_versions__id');

  $$ContentVersionsTableProcessedTableManager get contentVersionId {
    final $_column = $_itemColumn<String>('content_version_id')!;

    final manager = $$ContentVersionsTableTableManager(
      $_db,
      $_db.contentVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentVersionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CardsTable, List<CardRow>> _cardsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.cards,
    aliasName: 'rarities__id__cards__rarity_id',
  );

  $$CardsTableProcessedTableManager get cardsRefs {
    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.rarityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackSlotRulesTable, List<PackSlotRuleRow>>
  _packSlotRulesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packSlotRules,
    aliasName: 'rarities__id__pack_slot_rules__fixed_rarity_id',
  );

  $$PackSlotRulesTableProcessedTableManager get packSlotRulesRefs {
    final manager = $$PackSlotRulesTableTableManager(
      $_db,
      $_db.packSlotRules,
    ).filter((f) => f.fixedRarityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_packSlotRulesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PackRarityProbabilitiesTable,
    List<PackRarityProbabilityRow>
  >
  _packRarityProbabilitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.packRarityProbabilities,
        aliasName: 'rarities__id__pack_rarity_probabilities__rarity_id',
      );

  $$PackRarityProbabilitiesTableProcessedTableManager
  get packRarityProbabilitiesRefs {
    final manager = $$PackRarityProbabilitiesTableTableManager(
      $_db,
      $_db.packRarityProbabilities,
    ).filter((f) => f.rarityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _packRarityProbabilitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RaritiesTableFilterComposer
    extends Composer<_$AppDatabase, $RaritiesTable> {
  $$RaritiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconId => $composableBuilder(
    column: $table.iconId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frameId => $composableBuilder(
    column: $table.frameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectId => $composableBuilder(
    column: $table.effectId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sellValue => $composableBuilder(
    column: $table.sellValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentVersionsTableFilterComposer get contentVersionId {
    final $$ContentVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableFilterComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> cardsRefs(
    Expression<bool> Function($$CardsTableFilterComposer f) f,
  ) {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.rarityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packSlotRulesRefs(
    Expression<bool> Function($$PackSlotRulesTableFilterComposer f) f,
  ) {
    final $$PackSlotRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packSlotRules,
      getReferencedColumn: (t) => t.fixedRarityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackSlotRulesTableFilterComposer(
            $db: $db,
            $table: $db.packSlotRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packRarityProbabilitiesRefs(
    Expression<bool> Function($$PackRarityProbabilitiesTableFilterComposer f) f,
  ) {
    final $$PackRarityProbabilitiesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.packRarityProbabilities,
          getReferencedColumn: (t) => t.rarityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PackRarityProbabilitiesTableFilterComposer(
                $db: $db,
                $table: $db.packRarityProbabilities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RaritiesTableOrderingComposer
    extends Composer<_$AppDatabase, $RaritiesTable> {
  $$RaritiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconId => $composableBuilder(
    column: $table.iconId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frameId => $composableBuilder(
    column: $table.frameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectId => $composableBuilder(
    column: $table.effectId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sellValue => $composableBuilder(
    column: $table.sellValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentVersionsTableOrderingComposer get contentVersionId {
    final $$ContentVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableOrderingComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RaritiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RaritiesTable> {
  $$RaritiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconId =>
      $composableBuilder(column: $table.iconId, builder: (column) => column);

  GeneratedColumn<String> get frameId =>
      $composableBuilder(column: $table.frameId, builder: (column) => column);

  GeneratedColumn<String> get effectId =>
      $composableBuilder(column: $table.effectId, builder: (column) => column);

  GeneratedColumn<int> get sellValue =>
      $composableBuilder(column: $table.sellValue, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$ContentVersionsTableAnnotationComposer get contentVersionId {
    final $$ContentVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> cardsRefs<T extends Object>(
    Expression<T> Function($$CardsTableAnnotationComposer a) f,
  ) {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.rarityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packSlotRulesRefs<T extends Object>(
    Expression<T> Function($$PackSlotRulesTableAnnotationComposer a) f,
  ) {
    final $$PackSlotRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packSlotRules,
      getReferencedColumn: (t) => t.fixedRarityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackSlotRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.packSlotRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packRarityProbabilitiesRefs<T extends Object>(
    Expression<T> Function($$PackRarityProbabilitiesTableAnnotationComposer a)
    f,
  ) {
    final $$PackRarityProbabilitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.packRarityProbabilities,
          getReferencedColumn: (t) => t.rarityId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PackRarityProbabilitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.packRarityProbabilities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RaritiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RaritiesTable,
          RarityRow,
          $$RaritiesTableFilterComposer,
          $$RaritiesTableOrderingComposer,
          $$RaritiesTableAnnotationComposer,
          $$RaritiesTableCreateCompanionBuilder,
          $$RaritiesTableUpdateCompanionBuilder,
          (RarityRow, $$RaritiesTableReferences),
          RarityRow,
          PrefetchHooks Function({
            bool contentVersionId,
            bool cardsRefs,
            bool packSlotRulesRefs,
            bool packRarityProbabilitiesRefs,
          })
        > {
  $$RaritiesTableTableManager(_$AppDatabase db, $RaritiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RaritiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RaritiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RaritiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> contentVersionId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<String> iconId = const Value.absent(),
                Value<String> frameId = const Value.absent(),
                Value<String?> effectId = const Value.absent(),
                Value<int> sellValue = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RaritiesCompanion(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                name: name,
                orderIndex: orderIndex,
                colorValue: colorValue,
                iconId: iconId,
                frameId: frameId,
                effectId: effectId,
                sellValue: sellValue,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String contentVersionId,
                required String name,
                required int orderIndex,
                required int colorValue,
                required String iconId,
                required String frameId,
                Value<String?> effectId = const Value.absent(),
                required int sellValue,
                required bool isEnabled,
                Value<int> rowid = const Value.absent(),
              }) => RaritiesCompanion.insert(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                name: name,
                orderIndex: orderIndex,
                colorValue: colorValue,
                iconId: iconId,
                frameId: frameId,
                effectId: effectId,
                sellValue: sellValue,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RaritiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                contentVersionId = false,
                cardsRefs = false,
                packSlotRulesRefs = false,
                packRarityProbabilitiesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cardsRefs) db.cards,
                    if (packSlotRulesRefs) db.packSlotRules,
                    if (packRarityProbabilitiesRefs) db.packRarityProbabilities,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (contentVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contentVersionId,
                                    referencedTable: $$RaritiesTableReferences
                                        ._contentVersionIdTable(db),
                                    referencedColumn: $$RaritiesTableReferences
                                        ._contentVersionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cardsRefs)
                        await $_getPrefetchedData<
                          RarityRow,
                          $RaritiesTable,
                          CardRow
                        >(
                          currentTable: table,
                          referencedTable: $$RaritiesTableReferences
                              ._cardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RaritiesTableReferences(
                                db,
                                table,
                                p0,
                              ).cardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rarityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packSlotRulesRefs)
                        await $_getPrefetchedData<
                          RarityRow,
                          $RaritiesTable,
                          PackSlotRuleRow
                        >(
                          currentTable: table,
                          referencedTable: $$RaritiesTableReferences
                              ._packSlotRulesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RaritiesTableReferences(
                                db,
                                table,
                                p0,
                              ).packSlotRulesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fixedRarityId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packRarityProbabilitiesRefs)
                        await $_getPrefetchedData<
                          RarityRow,
                          $RaritiesTable,
                          PackRarityProbabilityRow
                        >(
                          currentTable: table,
                          referencedTable: $$RaritiesTableReferences
                              ._packRarityProbabilitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RaritiesTableReferences(
                                db,
                                table,
                                p0,
                              ).packRarityProbabilitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rarityId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RaritiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RaritiesTable,
      RarityRow,
      $$RaritiesTableFilterComposer,
      $$RaritiesTableOrderingComposer,
      $$RaritiesTableAnnotationComposer,
      $$RaritiesTableCreateCompanionBuilder,
      $$RaritiesTableUpdateCompanionBuilder,
      (RarityRow, $$RaritiesTableReferences),
      RarityRow,
      PrefetchHooks Function({
        bool contentVersionId,
        bool cardsRefs,
        bool packSlotRulesRefs,
        bool packRarityProbabilitiesRefs,
      })
    >;
typedef $$CardsTableCreateCompanionBuilder =
    CardsCompanion Function({
      required String id,
      required String collectionId,
      required String contentVersionId,
      required int collectionNumber,
      required String name,
      required int health,
      required String rarityId,
      required String mediaAssetId,
      required MediaType mediaType,
      Value<String?> thumbnailAssetId,
      required String templateId,
      required String frameId,
      required int primaryColor,
      required int secondaryColor,
      Value<String?> description,
      required int sortIndex,
      required DateTime createdAtUtc,
      Value<int> rowid,
    });
typedef $$CardsTableUpdateCompanionBuilder =
    CardsCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> contentVersionId,
      Value<int> collectionNumber,
      Value<String> name,
      Value<int> health,
      Value<String> rarityId,
      Value<String> mediaAssetId,
      Value<MediaType> mediaType,
      Value<String?> thumbnailAssetId,
      Value<String> templateId,
      Value<String> frameId,
      Value<int> primaryColor,
      Value<int> secondaryColor,
      Value<String?> description,
      Value<int> sortIndex,
      Value<DateTime> createdAtUtc,
      Value<int> rowid,
    });

final class $$CardsTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTable, CardRow> {
  $$CardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContentVersionsTable _contentVersionIdTable(_$AppDatabase db) => db
      .contentVersions
      .createAlias('cards__content_version_id__content_versions__id');

  $$ContentVersionsTableProcessedTableManager get contentVersionId {
    final $_column = $_itemColumn<String>('content_version_id')!;

    final manager = $$ContentVersionsTableTableManager(
      $_db,
      $_db.contentVersions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentVersionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RaritiesTable _rarityIdTable(_$AppDatabase db) =>
      db.rarities.createAlias('cards__rarity_id__rarities__id');

  $$RaritiesTableProcessedTableManager get rarityId {
    final $_column = $_itemColumn<String>('rarity_id')!;

    final manager = $$RaritiesTableTableManager(
      $_db,
      $_db.rarities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rarityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaAssetsTable _mediaAssetIdTable(_$AppDatabase db) =>
      db.mediaAssets.createAlias('cards__media_asset_id__media_assets__id');

  $$MediaAssetsTableProcessedTableManager get mediaAssetId {
    final $_column = $_itemColumn<String>('media_asset_id')!;

    final manager = $$MediaAssetsTableTableManager(
      $_db,
      $_db.mediaAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mediaAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MediaAssetsTable _thumbnailAssetIdTable(_$AppDatabase db) =>
      db.mediaAssets.createAlias('cards__thumbnail_asset_id__media_assets__id');

  $$MediaAssetsTableProcessedTableManager? get thumbnailAssetId {
    final $_column = $_itemColumn<String>('thumbnail_asset_id');
    if ($_column == null) return null;
    final manager = $$MediaAssetsTableTableManager(
      $_db,
      $_db.mediaAssets,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_thumbnailAssetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CardFieldValuesTable, List<CardFieldValueRow>>
  _cardFieldValuesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardFieldValues,
    aliasName: 'cards__id__card_field_values__card_id',
  );

  $$CardFieldValuesTableProcessedTableManager get cardFieldValuesRefs {
    final manager = $$CardFieldValuesTableTableManager(
      $_db,
      $_db.cardFieldValues,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cardFieldValuesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackCardPoolTable, List<PackCardPoolRow>>
  _packCardPoolRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packCardPool,
    aliasName: 'cards__id__pack_card_pool__card_id',
  );

  $$PackCardPoolTableProcessedTableManager get packCardPoolRefs {
    final manager = $$PackCardPoolTableTableManager(
      $_db,
      $_db.packCardPool,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_packCardPoolRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OwnedCardsTable, List<OwnedCardRow>>
  _ownedCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.ownedCards,
    aliasName: 'cards__id__owned_cards__card_id',
  );

  $$OwnedCardsTableProcessedTableManager get ownedCardsRefs {
    final manager = $$OwnedCardsTableTableManager(
      $_db,
      $_db.ownedCards,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_ownedCardsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackOpeningCardsTable, List<PackOpeningCardRow>>
  _packOpeningCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packOpeningCards,
    aliasName: 'cards__id__pack_opening_cards__card_id',
  );

  $$PackOpeningCardsTableProcessedTableManager get packOpeningCardsRefs {
    final manager = $$PackOpeningCardsTableTableManager(
      $_db,
      $_db.packOpeningCards,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _packOpeningCardsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoinTransactionsTable, List<CoinTransactionRow>>
  _coinTransactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coinTransactions,
    aliasName: 'cards__id__coin_transactions__related_card_id',
  );

  $$CoinTransactionsTableProcessedTableManager get coinTransactionsRefs {
    final manager = $$CoinTransactionsTableTableManager(
      $_db,
      $_db.coinTransactions,
    ).filter((f) => f.relatedCardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _coinTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CardsTableFilterComposer extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get collectionNumber => $composableBuilder(
    column: $table.collectionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get health => $composableBuilder(
    column: $table.health,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MediaType, MediaType, String> get mediaType =>
      $composableBuilder(
        column: $table.mediaType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frameId => $composableBuilder(
    column: $table.frameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get secondaryColor => $composableBuilder(
    column: $table.secondaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$ContentVersionsTableFilterComposer get contentVersionId {
    final $$ContentVersionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableFilterComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RaritiesTableFilterComposer get rarityId {
    final $$RaritiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableFilterComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableFilterComposer get mediaAssetId {
    final $$MediaAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableFilterComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableFilterComposer get thumbnailAssetId {
    final $$MediaAssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.thumbnailAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableFilterComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> cardFieldValuesRefs(
    Expression<bool> Function($$CardFieldValuesTableFilterComposer f) f,
  ) {
    final $$CardFieldValuesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardFieldValues,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardFieldValuesTableFilterComposer(
            $db: $db,
            $table: $db.cardFieldValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packCardPoolRefs(
    Expression<bool> Function($$PackCardPoolTableFilterComposer f) f,
  ) {
    final $$PackCardPoolTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packCardPool,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackCardPoolTableFilterComposer(
            $db: $db,
            $table: $db.packCardPool,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> ownedCardsRefs(
    Expression<bool> Function($$OwnedCardsTableFilterComposer f) f,
  ) {
    final $$OwnedCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ownedCards,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OwnedCardsTableFilterComposer(
            $db: $db,
            $table: $db.ownedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packOpeningCardsRefs(
    Expression<bool> Function($$PackOpeningCardsTableFilterComposer f) f,
  ) {
    final $$PackOpeningCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpeningCards,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningCardsTableFilterComposer(
            $db: $db,
            $table: $db.packOpeningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coinTransactionsRefs(
    Expression<bool> Function($$CoinTransactionsTableFilterComposer f) f,
  ) {
    final $$CoinTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coinTransactions,
      getReferencedColumn: (t) => t.relatedCardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoinTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.coinTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardsTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get collectionNumber => $composableBuilder(
    column: $table.collectionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get health => $composableBuilder(
    column: $table.health,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frameId => $composableBuilder(
    column: $table.frameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get secondaryColor => $composableBuilder(
    column: $table.secondaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortIndex => $composableBuilder(
    column: $table.sortIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$ContentVersionsTableOrderingComposer get contentVersionId {
    final $$ContentVersionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableOrderingComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RaritiesTableOrderingComposer get rarityId {
    final $$RaritiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableOrderingComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableOrderingComposer get mediaAssetId {
    final $$MediaAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableOrderingComposer get thumbnailAssetId {
    final $$MediaAssetsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.thumbnailAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableOrderingComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTable> {
  $$CardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get collectionNumber => $composableBuilder(
    column: $table.collectionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get health =>
      $composableBuilder(column: $table.health, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MediaType, String> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get frameId =>
      $composableBuilder(column: $table.frameId, builder: (column) => column);

  GeneratedColumn<int> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get secondaryColor => $composableBuilder(
    column: $table.secondaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortIndex =>
      $composableBuilder(column: $table.sortIndex, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  $$ContentVersionsTableAnnotationComposer get contentVersionId {
    final $$ContentVersionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentVersionId,
      referencedTable: $db.contentVersions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentVersionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contentVersions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RaritiesTableAnnotationComposer get rarityId {
    final $$RaritiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableAnnotationComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableAnnotationComposer get mediaAssetId {
    final $$MediaAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.mediaAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MediaAssetsTableAnnotationComposer get thumbnailAssetId {
    final $$MediaAssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.thumbnailAssetId,
      referencedTable: $db.mediaAssets,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MediaAssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.mediaAssets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> cardFieldValuesRefs<T extends Object>(
    Expression<T> Function($$CardFieldValuesTableAnnotationComposer a) f,
  ) {
    final $$CardFieldValuesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardFieldValues,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardFieldValuesTableAnnotationComposer(
            $db: $db,
            $table: $db.cardFieldValues,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packCardPoolRefs<T extends Object>(
    Expression<T> Function($$PackCardPoolTableAnnotationComposer a) f,
  ) {
    final $$PackCardPoolTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packCardPool,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackCardPoolTableAnnotationComposer(
            $db: $db,
            $table: $db.packCardPool,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> ownedCardsRefs<T extends Object>(
    Expression<T> Function($$OwnedCardsTableAnnotationComposer a) f,
  ) {
    final $$OwnedCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ownedCards,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OwnedCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.ownedCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packOpeningCardsRefs<T extends Object>(
    Expression<T> Function($$PackOpeningCardsTableAnnotationComposer a) f,
  ) {
    final $$PackOpeningCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpeningCards,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.packOpeningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coinTransactionsRefs<T extends Object>(
    Expression<T> Function($$CoinTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CoinTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coinTransactions,
      getReferencedColumn: (t) => t.relatedCardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoinTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.coinTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardsTable,
          CardRow,
          $$CardsTableFilterComposer,
          $$CardsTableOrderingComposer,
          $$CardsTableAnnotationComposer,
          $$CardsTableCreateCompanionBuilder,
          $$CardsTableUpdateCompanionBuilder,
          (CardRow, $$CardsTableReferences),
          CardRow,
          PrefetchHooks Function({
            bool contentVersionId,
            bool rarityId,
            bool mediaAssetId,
            bool thumbnailAssetId,
            bool cardFieldValuesRefs,
            bool packCardPoolRefs,
            bool ownedCardsRefs,
            bool packOpeningCardsRefs,
            bool coinTransactionsRefs,
          })
        > {
  $$CardsTableTableManager(_$AppDatabase db, $CardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> contentVersionId = const Value.absent(),
                Value<int> collectionNumber = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> health = const Value.absent(),
                Value<String> rarityId = const Value.absent(),
                Value<String> mediaAssetId = const Value.absent(),
                Value<MediaType> mediaType = const Value.absent(),
                Value<String?> thumbnailAssetId = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<String> frameId = const Value.absent(),
                Value<int> primaryColor = const Value.absent(),
                Value<int> secondaryColor = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> sortIndex = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsCompanion(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                collectionNumber: collectionNumber,
                name: name,
                health: health,
                rarityId: rarityId,
                mediaAssetId: mediaAssetId,
                mediaType: mediaType,
                thumbnailAssetId: thumbnailAssetId,
                templateId: templateId,
                frameId: frameId,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                description: description,
                sortIndex: sortIndex,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String contentVersionId,
                required int collectionNumber,
                required String name,
                required int health,
                required String rarityId,
                required String mediaAssetId,
                required MediaType mediaType,
                Value<String?> thumbnailAssetId = const Value.absent(),
                required String templateId,
                required String frameId,
                required int primaryColor,
                required int secondaryColor,
                Value<String?> description = const Value.absent(),
                required int sortIndex,
                required DateTime createdAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => CardsCompanion.insert(
                id: id,
                collectionId: collectionId,
                contentVersionId: contentVersionId,
                collectionNumber: collectionNumber,
                name: name,
                health: health,
                rarityId: rarityId,
                mediaAssetId: mediaAssetId,
                mediaType: mediaType,
                thumbnailAssetId: thumbnailAssetId,
                templateId: templateId,
                frameId: frameId,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                description: description,
                sortIndex: sortIndex,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CardsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                contentVersionId = false,
                rarityId = false,
                mediaAssetId = false,
                thumbnailAssetId = false,
                cardFieldValuesRefs = false,
                packCardPoolRefs = false,
                ownedCardsRefs = false,
                packOpeningCardsRefs = false,
                coinTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cardFieldValuesRefs) db.cardFieldValues,
                    if (packCardPoolRefs) db.packCardPool,
                    if (ownedCardsRefs) db.ownedCards,
                    if (packOpeningCardsRefs) db.packOpeningCards,
                    if (coinTransactionsRefs) db.coinTransactions,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (contentVersionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contentVersionId,
                                    referencedTable: $$CardsTableReferences
                                        ._contentVersionIdTable(db),
                                    referencedColumn: $$CardsTableReferences
                                        ._contentVersionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (rarityId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.rarityId,
                                    referencedTable: $$CardsTableReferences
                                        ._rarityIdTable(db),
                                    referencedColumn: $$CardsTableReferences
                                        ._rarityIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (mediaAssetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.mediaAssetId,
                                    referencedTable: $$CardsTableReferences
                                        ._mediaAssetIdTable(db),
                                    referencedColumn: $$CardsTableReferences
                                        ._mediaAssetIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (thumbnailAssetId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.thumbnailAssetId,
                                    referencedTable: $$CardsTableReferences
                                        ._thumbnailAssetIdTable(db),
                                    referencedColumn: $$CardsTableReferences
                                        ._thumbnailAssetIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cardFieldValuesRefs)
                        await $_getPrefetchedData<
                          CardRow,
                          $CardsTable,
                          CardFieldValueRow
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableReferences
                              ._cardFieldValuesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableReferences(
                                db,
                                table,
                                p0,
                              ).cardFieldValuesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packCardPoolRefs)
                        await $_getPrefetchedData<
                          CardRow,
                          $CardsTable,
                          PackCardPoolRow
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableReferences
                              ._packCardPoolRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableReferences(
                                db,
                                table,
                                p0,
                              ).packCardPoolRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (ownedCardsRefs)
                        await $_getPrefetchedData<
                          CardRow,
                          $CardsTable,
                          OwnedCardRow
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableReferences
                              ._ownedCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableReferences(
                                db,
                                table,
                                p0,
                              ).ownedCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packOpeningCardsRefs)
                        await $_getPrefetchedData<
                          CardRow,
                          $CardsTable,
                          PackOpeningCardRow
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableReferences
                              ._packOpeningCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableReferences(
                                db,
                                table,
                                p0,
                              ).packOpeningCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coinTransactionsRefs)
                        await $_getPrefetchedData<
                          CardRow,
                          $CardsTable,
                          CoinTransactionRow
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableReferences
                              ._coinTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableReferences(
                                db,
                                table,
                                p0,
                              ).coinTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.relatedCardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardsTable,
      CardRow,
      $$CardsTableFilterComposer,
      $$CardsTableOrderingComposer,
      $$CardsTableAnnotationComposer,
      $$CardsTableCreateCompanionBuilder,
      $$CardsTableUpdateCompanionBuilder,
      (CardRow, $$CardsTableReferences),
      CardRow,
      PrefetchHooks Function({
        bool contentVersionId,
        bool rarityId,
        bool mediaAssetId,
        bool thumbnailAssetId,
        bool cardFieldValuesRefs,
        bool packCardPoolRefs,
        bool ownedCardsRefs,
        bool packOpeningCardsRefs,
        bool coinTransactionsRefs,
      })
    >;
typedef $$CardFieldValuesTableCreateCompanionBuilder =
    CardFieldValuesCompanion Function({
      required String id,
      required String cardId,
      required String fieldTypeId,
      required String value,
      required int displayOrder,
      Value<int> rowid,
    });
typedef $$CardFieldValuesTableUpdateCompanionBuilder =
    CardFieldValuesCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<String> fieldTypeId,
      Value<String> value,
      Value<int> displayOrder,
      Value<int> rowid,
    });

final class $$CardFieldValuesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CardFieldValuesTable,
          CardFieldValueRow
        > {
  $$CardFieldValuesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CardsTable _cardIdTable(_$AppDatabase db) =>
      db.cards.createAlias('card_field_values__card_id__cards__id');

  $$CardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CardFieldValuesTableFilterComposer
    extends Composer<_$AppDatabase, $CardFieldValuesTable> {
  $$CardFieldValuesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldTypeId => $composableBuilder(
    column: $table.fieldTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardFieldValuesTableOrderingComposer
    extends Composer<_$AppDatabase, $CardFieldValuesTable> {
  $$CardFieldValuesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldTypeId => $composableBuilder(
    column: $table.fieldTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableOrderingComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardFieldValuesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardFieldValuesTable> {
  $$CardFieldValuesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldTypeId => $composableBuilder(
    column: $table.fieldTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardFieldValuesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardFieldValuesTable,
          CardFieldValueRow,
          $$CardFieldValuesTableFilterComposer,
          $$CardFieldValuesTableOrderingComposer,
          $$CardFieldValuesTableAnnotationComposer,
          $$CardFieldValuesTableCreateCompanionBuilder,
          $$CardFieldValuesTableUpdateCompanionBuilder,
          (CardFieldValueRow, $$CardFieldValuesTableReferences),
          CardFieldValueRow,
          PrefetchHooks Function({bool cardId})
        > {
  $$CardFieldValuesTableTableManager(
    _$AppDatabase db,
    $CardFieldValuesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardFieldValuesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardFieldValuesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardFieldValuesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> fieldTypeId = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardFieldValuesCompanion(
                id: id,
                cardId: cardId,
                fieldTypeId: fieldTypeId,
                value: value,
                displayOrder: displayOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                required String fieldTypeId,
                required String value,
                required int displayOrder,
                Value<int> rowid = const Value.absent(),
              }) => CardFieldValuesCompanion.insert(
                id: id,
                cardId: cardId,
                fieldTypeId: fieldTypeId,
                value: value,
                displayOrder: displayOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CardFieldValuesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable:
                                    $$CardFieldValuesTableReferences
                                        ._cardIdTable(db),
                                referencedColumn:
                                    $$CardFieldValuesTableReferences
                                        ._cardIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CardFieldValuesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardFieldValuesTable,
      CardFieldValueRow,
      $$CardFieldValuesTableFilterComposer,
      $$CardFieldValuesTableOrderingComposer,
      $$CardFieldValuesTableAnnotationComposer,
      $$CardFieldValuesTableCreateCompanionBuilder,
      $$CardFieldValuesTableUpdateCompanionBuilder,
      (CardFieldValueRow, $$CardFieldValuesTableReferences),
      CardFieldValueRow,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$PackCardPoolTableCreateCompanionBuilder =
    PackCardPoolCompanion Function({
      required String packTypeId,
      required String cardId,
      required bool isEnabled,
      Value<int> rowid,
    });
typedef $$PackCardPoolTableUpdateCompanionBuilder =
    PackCardPoolCompanion Function({
      Value<String> packTypeId,
      Value<String> cardId,
      Value<bool> isEnabled,
      Value<int> rowid,
    });

final class $$PackCardPoolTableReferences
    extends BaseReferences<_$AppDatabase, $PackCardPoolTable, PackCardPoolRow> {
  $$PackCardPoolTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PackTypesTable _packTypeIdTable(_$AppDatabase db) =>
      db.packTypes.createAlias('pack_card_pool__pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager get packTypeId {
    final $_column = $_itemColumn<String>('pack_type_id')!;

    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CardsTable _cardIdTable(_$AppDatabase db) =>
      db.cards.createAlias('pack_card_pool__card_id__cards__id');

  $$CardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackCardPoolTableFilterComposer
    extends Composer<_$AppDatabase, $PackCardPoolTable> {
  $$PackCardPoolTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$PackTypesTableFilterComposer get packTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackCardPoolTableOrderingComposer
    extends Composer<_$AppDatabase, $PackCardPoolTable> {
  $$PackCardPoolTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$PackTypesTableOrderingComposer get packTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableOrderingComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackCardPoolTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackCardPoolTable> {
  $$PackCardPoolTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  $$PackTypesTableAnnotationComposer get packTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackCardPoolTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackCardPoolTable,
          PackCardPoolRow,
          $$PackCardPoolTableFilterComposer,
          $$PackCardPoolTableOrderingComposer,
          $$PackCardPoolTableAnnotationComposer,
          $$PackCardPoolTableCreateCompanionBuilder,
          $$PackCardPoolTableUpdateCompanionBuilder,
          (PackCardPoolRow, $$PackCardPoolTableReferences),
          PackCardPoolRow,
          PrefetchHooks Function({bool packTypeId, bool cardId})
        > {
  $$PackCardPoolTableTableManager(_$AppDatabase db, $PackCardPoolTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackCardPoolTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackCardPoolTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackCardPoolTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> packTypeId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackCardPoolCompanion(
                packTypeId: packTypeId,
                cardId: cardId,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String packTypeId,
                required String cardId,
                required bool isEnabled,
                Value<int> rowid = const Value.absent(),
              }) => PackCardPoolCompanion.insert(
                packTypeId: packTypeId,
                cardId: cardId,
                isEnabled: isEnabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackCardPoolTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({packTypeId = false, cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (packTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.packTypeId,
                                referencedTable: $$PackCardPoolTableReferences
                                    ._packTypeIdTable(db),
                                referencedColumn: $$PackCardPoolTableReferences
                                    ._packTypeIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable: $$PackCardPoolTableReferences
                                    ._cardIdTable(db),
                                referencedColumn: $$PackCardPoolTableReferences
                                    ._cardIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PackCardPoolTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackCardPoolTable,
      PackCardPoolRow,
      $$PackCardPoolTableFilterComposer,
      $$PackCardPoolTableOrderingComposer,
      $$PackCardPoolTableAnnotationComposer,
      $$PackCardPoolTableCreateCompanionBuilder,
      $$PackCardPoolTableUpdateCompanionBuilder,
      (PackCardPoolRow, $$PackCardPoolTableReferences),
      PackCardPoolRow,
      PrefetchHooks Function({bool packTypeId, bool cardId})
    >;
typedef $$PackSlotRulesTableCreateCompanionBuilder =
    PackSlotRulesCompanion Function({
      required String id,
      required String packTypeId,
      required int slotIndex,
      required PackSlotRuleType ruleType,
      Value<String?> fixedRarityId,
      Value<int?> minimumRarityOrder,
      Value<String?> probabilityGroupId,
      Value<int> rowid,
    });
typedef $$PackSlotRulesTableUpdateCompanionBuilder =
    PackSlotRulesCompanion Function({
      Value<String> id,
      Value<String> packTypeId,
      Value<int> slotIndex,
      Value<PackSlotRuleType> ruleType,
      Value<String?> fixedRarityId,
      Value<int?> minimumRarityOrder,
      Value<String?> probabilityGroupId,
      Value<int> rowid,
    });

final class $$PackSlotRulesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PackSlotRulesTable, PackSlotRuleRow> {
  $$PackSlotRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PackTypesTable _packTypeIdTable(_$AppDatabase db) =>
      db.packTypes.createAlias('pack_slot_rules__pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager get packTypeId {
    final $_column = $_itemColumn<String>('pack_type_id')!;

    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RaritiesTable _fixedRarityIdTable(_$AppDatabase db) =>
      db.rarities.createAlias('pack_slot_rules__fixed_rarity_id__rarities__id');

  $$RaritiesTableProcessedTableManager? get fixedRarityId {
    final $_column = $_itemColumn<String>('fixed_rarity_id');
    if ($_column == null) return null;
    final manager = $$RaritiesTableTableManager(
      $_db,
      $_db.rarities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fixedRarityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackSlotRulesTableFilterComposer
    extends Composer<_$AppDatabase, $PackSlotRulesTable> {
  $$PackSlotRulesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PackSlotRuleType, PackSlotRuleType, String>
  get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get minimumRarityOrder => $composableBuilder(
    column: $table.minimumRarityOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get probabilityGroupId => $composableBuilder(
    column: $table.probabilityGroupId,
    builder: (column) => ColumnFilters(column),
  );

  $$PackTypesTableFilterComposer get packTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RaritiesTableFilterComposer get fixedRarityId {
    final $$RaritiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixedRarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableFilterComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackSlotRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $PackSlotRulesTable> {
  $$PackSlotRulesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleType => $composableBuilder(
    column: $table.ruleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minimumRarityOrder => $composableBuilder(
    column: $table.minimumRarityOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get probabilityGroupId => $composableBuilder(
    column: $table.probabilityGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PackTypesTableOrderingComposer get packTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RaritiesTableOrderingComposer get fixedRarityId {
    final $$RaritiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixedRarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableOrderingComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackSlotRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackSlotRulesTable> {
  $$PackSlotRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get slotIndex =>
      $composableBuilder(column: $table.slotIndex, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PackSlotRuleType, String> get ruleType =>
      $composableBuilder(column: $table.ruleType, builder: (column) => column);

  GeneratedColumn<int> get minimumRarityOrder => $composableBuilder(
    column: $table.minimumRarityOrder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get probabilityGroupId => $composableBuilder(
    column: $table.probabilityGroupId,
    builder: (column) => column,
  );

  $$PackTypesTableAnnotationComposer get packTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RaritiesTableAnnotationComposer get fixedRarityId {
    final $$RaritiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixedRarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableAnnotationComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackSlotRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackSlotRulesTable,
          PackSlotRuleRow,
          $$PackSlotRulesTableFilterComposer,
          $$PackSlotRulesTableOrderingComposer,
          $$PackSlotRulesTableAnnotationComposer,
          $$PackSlotRulesTableCreateCompanionBuilder,
          $$PackSlotRulesTableUpdateCompanionBuilder,
          (PackSlotRuleRow, $$PackSlotRulesTableReferences),
          PackSlotRuleRow,
          PrefetchHooks Function({bool packTypeId, bool fixedRarityId})
        > {
  $$PackSlotRulesTableTableManager(_$AppDatabase db, $PackSlotRulesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackSlotRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackSlotRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackSlotRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> packTypeId = const Value.absent(),
                Value<int> slotIndex = const Value.absent(),
                Value<PackSlotRuleType> ruleType = const Value.absent(),
                Value<String?> fixedRarityId = const Value.absent(),
                Value<int?> minimumRarityOrder = const Value.absent(),
                Value<String?> probabilityGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackSlotRulesCompanion(
                id: id,
                packTypeId: packTypeId,
                slotIndex: slotIndex,
                ruleType: ruleType,
                fixedRarityId: fixedRarityId,
                minimumRarityOrder: minimumRarityOrder,
                probabilityGroupId: probabilityGroupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String packTypeId,
                required int slotIndex,
                required PackSlotRuleType ruleType,
                Value<String?> fixedRarityId = const Value.absent(),
                Value<int?> minimumRarityOrder = const Value.absent(),
                Value<String?> probabilityGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackSlotRulesCompanion.insert(
                id: id,
                packTypeId: packTypeId,
                slotIndex: slotIndex,
                ruleType: ruleType,
                fixedRarityId: fixedRarityId,
                minimumRarityOrder: minimumRarityOrder,
                probabilityGroupId: probabilityGroupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackSlotRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({packTypeId = false, fixedRarityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (packTypeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.packTypeId,
                                referencedTable: $$PackSlotRulesTableReferences
                                    ._packTypeIdTable(db),
                                referencedColumn: $$PackSlotRulesTableReferences
                                    ._packTypeIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (fixedRarityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fixedRarityId,
                                referencedTable: $$PackSlotRulesTableReferences
                                    ._fixedRarityIdTable(db),
                                referencedColumn: $$PackSlotRulesTableReferences
                                    ._fixedRarityIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PackSlotRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackSlotRulesTable,
      PackSlotRuleRow,
      $$PackSlotRulesTableFilterComposer,
      $$PackSlotRulesTableOrderingComposer,
      $$PackSlotRulesTableAnnotationComposer,
      $$PackSlotRulesTableCreateCompanionBuilder,
      $$PackSlotRulesTableUpdateCompanionBuilder,
      (PackSlotRuleRow, $$PackSlotRulesTableReferences),
      PackSlotRuleRow,
      PrefetchHooks Function({bool packTypeId, bool fixedRarityId})
    >;
typedef $$PackRarityProbabilitiesTableCreateCompanionBuilder =
    PackRarityProbabilitiesCompanion Function({
      required String probabilityGroupId,
      required String rarityId,
      required int weight,
      Value<int> rowid,
    });
typedef $$PackRarityProbabilitiesTableUpdateCompanionBuilder =
    PackRarityProbabilitiesCompanion Function({
      Value<String> probabilityGroupId,
      Value<String> rarityId,
      Value<int> weight,
      Value<int> rowid,
    });

final class $$PackRarityProbabilitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PackRarityProbabilitiesTable,
          PackRarityProbabilityRow
        > {
  $$PackRarityProbabilitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RaritiesTable _rarityIdTable(_$AppDatabase db) => db.rarities
      .createAlias('pack_rarity_probabilities__rarity_id__rarities__id');

  $$RaritiesTableProcessedTableManager get rarityId {
    final $_column = $_itemColumn<String>('rarity_id')!;

    final manager = $$RaritiesTableTableManager(
      $_db,
      $_db.rarities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rarityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackRarityProbabilitiesTableFilterComposer
    extends Composer<_$AppDatabase, $PackRarityProbabilitiesTable> {
  $$PackRarityProbabilitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get probabilityGroupId => $composableBuilder(
    column: $table.probabilityGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  $$RaritiesTableFilterComposer get rarityId {
    final $$RaritiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableFilterComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackRarityProbabilitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PackRarityProbabilitiesTable> {
  $$PackRarityProbabilitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get probabilityGroupId => $composableBuilder(
    column: $table.probabilityGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  $$RaritiesTableOrderingComposer get rarityId {
    final $$RaritiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableOrderingComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackRarityProbabilitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackRarityProbabilitiesTable> {
  $$PackRarityProbabilitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get probabilityGroupId => $composableBuilder(
    column: $table.probabilityGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  $$RaritiesTableAnnotationComposer get rarityId {
    final $$RaritiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rarityId,
      referencedTable: $db.rarities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RaritiesTableAnnotationComposer(
            $db: $db,
            $table: $db.rarities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackRarityProbabilitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackRarityProbabilitiesTable,
          PackRarityProbabilityRow,
          $$PackRarityProbabilitiesTableFilterComposer,
          $$PackRarityProbabilitiesTableOrderingComposer,
          $$PackRarityProbabilitiesTableAnnotationComposer,
          $$PackRarityProbabilitiesTableCreateCompanionBuilder,
          $$PackRarityProbabilitiesTableUpdateCompanionBuilder,
          (PackRarityProbabilityRow, $$PackRarityProbabilitiesTableReferences),
          PackRarityProbabilityRow,
          PrefetchHooks Function({bool rarityId})
        > {
  $$PackRarityProbabilitiesTableTableManager(
    _$AppDatabase db,
    $PackRarityProbabilitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackRarityProbabilitiesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PackRarityProbabilitiesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PackRarityProbabilitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> probabilityGroupId = const Value.absent(),
                Value<String> rarityId = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackRarityProbabilitiesCompanion(
                probabilityGroupId: probabilityGroupId,
                rarityId: rarityId,
                weight: weight,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String probabilityGroupId,
                required String rarityId,
                required int weight,
                Value<int> rowid = const Value.absent(),
              }) => PackRarityProbabilitiesCompanion.insert(
                probabilityGroupId: probabilityGroupId,
                rarityId: rarityId,
                weight: weight,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackRarityProbabilitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rarityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (rarityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.rarityId,
                                referencedTable:
                                    $$PackRarityProbabilitiesTableReferences
                                        ._rarityIdTable(db),
                                referencedColumn:
                                    $$PackRarityProbabilitiesTableReferences
                                        ._rarityIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PackRarityProbabilitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackRarityProbabilitiesTable,
      PackRarityProbabilityRow,
      $$PackRarityProbabilitiesTableFilterComposer,
      $$PackRarityProbabilitiesTableOrderingComposer,
      $$PackRarityProbabilitiesTableAnnotationComposer,
      $$PackRarityProbabilitiesTableCreateCompanionBuilder,
      $$PackRarityProbabilitiesTableUpdateCompanionBuilder,
      (PackRarityProbabilityRow, $$PackRarityProbabilitiesTableReferences),
      PackRarityProbabilityRow,
      PrefetchHooks Function({bool rarityId})
    >;
typedef $$PackInventoryTableCreateCompanionBuilder =
    PackInventoryCompanion Function({
      required String installedCollectionId,
      required String packTypeId,
      required int availableCount,
      required int maxAccumulated,
      required DateTime nextRechargeAtUtc,
      required DateTime lastCalculatedAtUtc,
      Value<int> rowid,
    });
typedef $$PackInventoryTableUpdateCompanionBuilder =
    PackInventoryCompanion Function({
      Value<String> installedCollectionId,
      Value<String> packTypeId,
      Value<int> availableCount,
      Value<int> maxAccumulated,
      Value<DateTime> nextRechargeAtUtc,
      Value<DateTime> lastCalculatedAtUtc,
      Value<int> rowid,
    });

final class $$PackInventoryTableReferences
    extends
        BaseReferences<_$AppDatabase, $PackInventoryTable, PackInventoryRow> {
  $$PackInventoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstalledCollectionsTable _installedCollectionIdTable(
    _$AppDatabase db,
  ) => db.installedCollections.createAlias(
    'pack_inventory__installed_collection_id__installed_collections__id',
  );

  $$InstalledCollectionsTableProcessedTableManager get installedCollectionId {
    final $_column = $_itemColumn<String>('installed_collection_id')!;

    final manager = $$InstalledCollectionsTableTableManager(
      $_db,
      $_db.installedCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _installedCollectionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PackTypesTable _packTypeIdTable(_$AppDatabase db) =>
      db.packTypes.createAlias('pack_inventory__pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager get packTypeId {
    final $_column = $_itemColumn<String>('pack_type_id')!;

    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackInventoryTableFilterComposer
    extends Composer<_$AppDatabase, $PackInventoryTable> {
  $$PackInventoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get availableCount => $composableBuilder(
    column: $table.availableCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAccumulated => $composableBuilder(
    column: $table.maxAccumulated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextRechargeAtUtc => $composableBuilder(
    column: $table.nextRechargeAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastCalculatedAtUtc => $composableBuilder(
    column: $table.lastCalculatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$InstalledCollectionsTableFilterComposer get installedCollectionId {
    final $$InstalledCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installedCollectionId,
      referencedTable: $db.installedCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstalledCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.installedCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableFilterComposer get packTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackInventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $PackInventoryTable> {
  $$PackInventoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get availableCount => $composableBuilder(
    column: $table.availableCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAccumulated => $composableBuilder(
    column: $table.maxAccumulated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextRechargeAtUtc => $composableBuilder(
    column: $table.nextRechargeAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCalculatedAtUtc => $composableBuilder(
    column: $table.lastCalculatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstalledCollectionsTableOrderingComposer get installedCollectionId {
    final $$InstalledCollectionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableOrderingComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PackTypesTableOrderingComposer get packTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackInventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackInventoryTable> {
  $$PackInventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get availableCount => $composableBuilder(
    column: $table.availableCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxAccumulated => $composableBuilder(
    column: $table.maxAccumulated,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextRechargeAtUtc => $composableBuilder(
    column: $table.nextRechargeAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastCalculatedAtUtc => $composableBuilder(
    column: $table.lastCalculatedAtUtc,
    builder: (column) => column,
  );

  $$InstalledCollectionsTableAnnotationComposer get installedCollectionId {
    final $$InstalledCollectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PackTypesTableAnnotationComposer get packTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackInventoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackInventoryTable,
          PackInventoryRow,
          $$PackInventoryTableFilterComposer,
          $$PackInventoryTableOrderingComposer,
          $$PackInventoryTableAnnotationComposer,
          $$PackInventoryTableCreateCompanionBuilder,
          $$PackInventoryTableUpdateCompanionBuilder,
          (PackInventoryRow, $$PackInventoryTableReferences),
          PackInventoryRow,
          PrefetchHooks Function({bool installedCollectionId, bool packTypeId})
        > {
  $$PackInventoryTableTableManager(_$AppDatabase db, $PackInventoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackInventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackInventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackInventoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> installedCollectionId = const Value.absent(),
                Value<String> packTypeId = const Value.absent(),
                Value<int> availableCount = const Value.absent(),
                Value<int> maxAccumulated = const Value.absent(),
                Value<DateTime> nextRechargeAtUtc = const Value.absent(),
                Value<DateTime> lastCalculatedAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackInventoryCompanion(
                installedCollectionId: installedCollectionId,
                packTypeId: packTypeId,
                availableCount: availableCount,
                maxAccumulated: maxAccumulated,
                nextRechargeAtUtc: nextRechargeAtUtc,
                lastCalculatedAtUtc: lastCalculatedAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String installedCollectionId,
                required String packTypeId,
                required int availableCount,
                required int maxAccumulated,
                required DateTime nextRechargeAtUtc,
                required DateTime lastCalculatedAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => PackInventoryCompanion.insert(
                installedCollectionId: installedCollectionId,
                packTypeId: packTypeId,
                availableCount: availableCount,
                maxAccumulated: maxAccumulated,
                nextRechargeAtUtc: nextRechargeAtUtc,
                lastCalculatedAtUtc: lastCalculatedAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackInventoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({installedCollectionId = false, packTypeId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (installedCollectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installedCollectionId,
                                    referencedTable:
                                        $$PackInventoryTableReferences
                                            ._installedCollectionIdTable(db),
                                    referencedColumn:
                                        $$PackInventoryTableReferences
                                            ._installedCollectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (packTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.packTypeId,
                                    referencedTable:
                                        $$PackInventoryTableReferences
                                            ._packTypeIdTable(db),
                                    referencedColumn:
                                        $$PackInventoryTableReferences
                                            ._packTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PackInventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackInventoryTable,
      PackInventoryRow,
      $$PackInventoryTableFilterComposer,
      $$PackInventoryTableOrderingComposer,
      $$PackInventoryTableAnnotationComposer,
      $$PackInventoryTableCreateCompanionBuilder,
      $$PackInventoryTableUpdateCompanionBuilder,
      (PackInventoryRow, $$PackInventoryTableReferences),
      PackInventoryRow,
      PrefetchHooks Function({bool installedCollectionId, bool packTypeId})
    >;
typedef $$OwnedCardsTableCreateCompanionBuilder =
    OwnedCardsCompanion Function({
      required String installedCollectionId,
      required String cardId,
      required int quantity,
      required DateTime firstObtainedAtUtc,
      required DateTime lastObtainedAtUtc,
      required bool isFavorite,
      Value<int> rowid,
    });
typedef $$OwnedCardsTableUpdateCompanionBuilder =
    OwnedCardsCompanion Function({
      Value<String> installedCollectionId,
      Value<String> cardId,
      Value<int> quantity,
      Value<DateTime> firstObtainedAtUtc,
      Value<DateTime> lastObtainedAtUtc,
      Value<bool> isFavorite,
      Value<int> rowid,
    });

final class $$OwnedCardsTableReferences
    extends BaseReferences<_$AppDatabase, $OwnedCardsTable, OwnedCardRow> {
  $$OwnedCardsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InstalledCollectionsTable _installedCollectionIdTable(
    _$AppDatabase db,
  ) => db.installedCollections.createAlias(
    'owned_cards__installed_collection_id__installed_collections__id',
  );

  $$InstalledCollectionsTableProcessedTableManager get installedCollectionId {
    final $_column = $_itemColumn<String>('installed_collection_id')!;

    final manager = $$InstalledCollectionsTableTableManager(
      $_db,
      $_db.installedCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _installedCollectionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CardsTable _cardIdTable(_$AppDatabase db) =>
      db.cards.createAlias('owned_cards__card_id__cards__id');

  $$CardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OwnedCardsTableFilterComposer
    extends Composer<_$AppDatabase, $OwnedCardsTable> {
  $$OwnedCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstObtainedAtUtc => $composableBuilder(
    column: $table.firstObtainedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastObtainedAtUtc => $composableBuilder(
    column: $table.lastObtainedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  $$InstalledCollectionsTableFilterComposer get installedCollectionId {
    final $$InstalledCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installedCollectionId,
      referencedTable: $db.installedCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstalledCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.installedCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OwnedCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $OwnedCardsTable> {
  $$OwnedCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstObtainedAtUtc => $composableBuilder(
    column: $table.firstObtainedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastObtainedAtUtc => $composableBuilder(
    column: $table.lastObtainedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstalledCollectionsTableOrderingComposer get installedCollectionId {
    final $$InstalledCollectionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableOrderingComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableOrderingComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OwnedCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OwnedCardsTable> {
  $$OwnedCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get firstObtainedAtUtc => $composableBuilder(
    column: $table.firstObtainedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastObtainedAtUtc => $composableBuilder(
    column: $table.lastObtainedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  $$InstalledCollectionsTableAnnotationComposer get installedCollectionId {
    final $$InstalledCollectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OwnedCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OwnedCardsTable,
          OwnedCardRow,
          $$OwnedCardsTableFilterComposer,
          $$OwnedCardsTableOrderingComposer,
          $$OwnedCardsTableAnnotationComposer,
          $$OwnedCardsTableCreateCompanionBuilder,
          $$OwnedCardsTableUpdateCompanionBuilder,
          (OwnedCardRow, $$OwnedCardsTableReferences),
          OwnedCardRow,
          PrefetchHooks Function({bool installedCollectionId, bool cardId})
        > {
  $$OwnedCardsTableTableManager(_$AppDatabase db, $OwnedCardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OwnedCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OwnedCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OwnedCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> installedCollectionId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<DateTime> firstObtainedAtUtc = const Value.absent(),
                Value<DateTime> lastObtainedAtUtc = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OwnedCardsCompanion(
                installedCollectionId: installedCollectionId,
                cardId: cardId,
                quantity: quantity,
                firstObtainedAtUtc: firstObtainedAtUtc,
                lastObtainedAtUtc: lastObtainedAtUtc,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String installedCollectionId,
                required String cardId,
                required int quantity,
                required DateTime firstObtainedAtUtc,
                required DateTime lastObtainedAtUtc,
                required bool isFavorite,
                Value<int> rowid = const Value.absent(),
              }) => OwnedCardsCompanion.insert(
                installedCollectionId: installedCollectionId,
                cardId: cardId,
                quantity: quantity,
                firstObtainedAtUtc: firstObtainedAtUtc,
                lastObtainedAtUtc: lastObtainedAtUtc,
                isFavorite: isFavorite,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OwnedCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({installedCollectionId = false, cardId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (installedCollectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installedCollectionId,
                                    referencedTable: $$OwnedCardsTableReferences
                                        ._installedCollectionIdTable(db),
                                    referencedColumn:
                                        $$OwnedCardsTableReferences
                                            ._installedCollectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (cardId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.cardId,
                                    referencedTable: $$OwnedCardsTableReferences
                                        ._cardIdTable(db),
                                    referencedColumn:
                                        $$OwnedCardsTableReferences
                                            ._cardIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$OwnedCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OwnedCardsTable,
      OwnedCardRow,
      $$OwnedCardsTableFilterComposer,
      $$OwnedCardsTableOrderingComposer,
      $$OwnedCardsTableAnnotationComposer,
      $$OwnedCardsTableCreateCompanionBuilder,
      $$OwnedCardsTableUpdateCompanionBuilder,
      (OwnedCardRow, $$OwnedCardsTableReferences),
      OwnedCardRow,
      PrefetchHooks Function({bool installedCollectionId, bool cardId})
    >;
typedef $$PackOpeningsTableCreateCompanionBuilder =
    PackOpeningsCompanion Function({
      required String id,
      required String installedCollectionId,
      required String packTypeId,
      required PackOpeningStatus status,
      required DateTime generatedAtUtc,
      Value<DateTime?> completedAtUtc,
      Value<int> rowid,
    });
typedef $$PackOpeningsTableUpdateCompanionBuilder =
    PackOpeningsCompanion Function({
      Value<String> id,
      Value<String> installedCollectionId,
      Value<String> packTypeId,
      Value<PackOpeningStatus> status,
      Value<DateTime> generatedAtUtc,
      Value<DateTime?> completedAtUtc,
      Value<int> rowid,
    });

final class $$PackOpeningsTableReferences
    extends BaseReferences<_$AppDatabase, $PackOpeningsTable, PackOpeningRow> {
  $$PackOpeningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InstalledCollectionsTable _installedCollectionIdTable(
    _$AppDatabase db,
  ) => db.installedCollections.createAlias(
    'pack_openings__installed_collection_id__installed_collections__id',
  );

  $$InstalledCollectionsTableProcessedTableManager get installedCollectionId {
    final $_column = $_itemColumn<String>('installed_collection_id')!;

    final manager = $$InstalledCollectionsTableTableManager(
      $_db,
      $_db.installedCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _installedCollectionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PackTypesTable _packTypeIdTable(_$AppDatabase db) =>
      db.packTypes.createAlias('pack_openings__pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager get packTypeId {
    final $_column = $_itemColumn<String>('pack_type_id')!;

    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_packTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PackOpeningCardsTable, List<PackOpeningCardRow>>
  _packOpeningCardsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packOpeningCards,
    aliasName: 'pack_openings__id__pack_opening_cards__opening_id',
  );

  $$PackOpeningCardsTableProcessedTableManager get packOpeningCardsRefs {
    final manager = $$PackOpeningCardsTableTableManager(
      $_db,
      $_db.packOpeningCards,
    ).filter((f) => f.openingId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _packOpeningCardsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PackOpeningsTableFilterComposer
    extends Composer<_$AppDatabase, $PackOpeningsTable> {
  $$PackOpeningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PackOpeningStatus, PackOpeningStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get generatedAtUtc => $composableBuilder(
    column: $table.generatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAtUtc => $composableBuilder(
    column: $table.completedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  $$InstalledCollectionsTableFilterComposer get installedCollectionId {
    final $$InstalledCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installedCollectionId,
      referencedTable: $db.installedCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstalledCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.installedCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableFilterComposer get packTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> packOpeningCardsRefs(
    Expression<bool> Function($$PackOpeningCardsTableFilterComposer f) f,
  ) {
    final $$PackOpeningCardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpeningCards,
      getReferencedColumn: (t) => t.openingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningCardsTableFilterComposer(
            $db: $db,
            $table: $db.packOpeningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PackOpeningsTableOrderingComposer
    extends Composer<_$AppDatabase, $PackOpeningsTable> {
  $$PackOpeningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAtUtc => $composableBuilder(
    column: $table.generatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAtUtc => $composableBuilder(
    column: $table.completedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstalledCollectionsTableOrderingComposer get installedCollectionId {
    final $$InstalledCollectionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableOrderingComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PackTypesTableOrderingComposer get packTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackOpeningsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackOpeningsTable> {
  $$PackOpeningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PackOpeningStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAtUtc => $composableBuilder(
    column: $table.generatedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAtUtc => $composableBuilder(
    column: $table.completedAtUtc,
    builder: (column) => column,
  );

  $$InstalledCollectionsTableAnnotationComposer get installedCollectionId {
    final $$InstalledCollectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PackTypesTableAnnotationComposer get packTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.packTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> packOpeningCardsRefs<T extends Object>(
    Expression<T> Function($$PackOpeningCardsTableAnnotationComposer a) f,
  ) {
    final $$PackOpeningCardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packOpeningCards,
      getReferencedColumn: (t) => t.openingId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningCardsTableAnnotationComposer(
            $db: $db,
            $table: $db.packOpeningCards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PackOpeningsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackOpeningsTable,
          PackOpeningRow,
          $$PackOpeningsTableFilterComposer,
          $$PackOpeningsTableOrderingComposer,
          $$PackOpeningsTableAnnotationComposer,
          $$PackOpeningsTableCreateCompanionBuilder,
          $$PackOpeningsTableUpdateCompanionBuilder,
          (PackOpeningRow, $$PackOpeningsTableReferences),
          PackOpeningRow,
          PrefetchHooks Function({
            bool installedCollectionId,
            bool packTypeId,
            bool packOpeningCardsRefs,
          })
        > {
  $$PackOpeningsTableTableManager(_$AppDatabase db, $PackOpeningsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackOpeningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackOpeningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackOpeningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> installedCollectionId = const Value.absent(),
                Value<String> packTypeId = const Value.absent(),
                Value<PackOpeningStatus> status = const Value.absent(),
                Value<DateTime> generatedAtUtc = const Value.absent(),
                Value<DateTime?> completedAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackOpeningsCompanion(
                id: id,
                installedCollectionId: installedCollectionId,
                packTypeId: packTypeId,
                status: status,
                generatedAtUtc: generatedAtUtc,
                completedAtUtc: completedAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String installedCollectionId,
                required String packTypeId,
                required PackOpeningStatus status,
                required DateTime generatedAtUtc,
                Value<DateTime?> completedAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackOpeningsCompanion.insert(
                id: id,
                installedCollectionId: installedCollectionId,
                packTypeId: packTypeId,
                status: status,
                generatedAtUtc: generatedAtUtc,
                completedAtUtc: completedAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackOpeningsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                installedCollectionId = false,
                packTypeId = false,
                packOpeningCardsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (packOpeningCardsRefs) db.packOpeningCards,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (installedCollectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installedCollectionId,
                                    referencedTable:
                                        $$PackOpeningsTableReferences
                                            ._installedCollectionIdTable(db),
                                    referencedColumn:
                                        $$PackOpeningsTableReferences
                                            ._installedCollectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (packTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.packTypeId,
                                    referencedTable:
                                        $$PackOpeningsTableReferences
                                            ._packTypeIdTable(db),
                                    referencedColumn:
                                        $$PackOpeningsTableReferences
                                            ._packTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (packOpeningCardsRefs)
                        await $_getPrefetchedData<
                          PackOpeningRow,
                          $PackOpeningsTable,
                          PackOpeningCardRow
                        >(
                          currentTable: table,
                          referencedTable: $$PackOpeningsTableReferences
                              ._packOpeningCardsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PackOpeningsTableReferences(
                                db,
                                table,
                                p0,
                              ).packOpeningCardsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.openingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PackOpeningsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackOpeningsTable,
      PackOpeningRow,
      $$PackOpeningsTableFilterComposer,
      $$PackOpeningsTableOrderingComposer,
      $$PackOpeningsTableAnnotationComposer,
      $$PackOpeningsTableCreateCompanionBuilder,
      $$PackOpeningsTableUpdateCompanionBuilder,
      (PackOpeningRow, $$PackOpeningsTableReferences),
      PackOpeningRow,
      PrefetchHooks Function({
        bool installedCollectionId,
        bool packTypeId,
        bool packOpeningCardsRefs,
      })
    >;
typedef $$PackOpeningCardsTableCreateCompanionBuilder =
    PackOpeningCardsCompanion Function({
      required String openingId,
      required String cardId,
      required int slotIndex,
      required bool wasNew,
      required int quantityAfter,
      required bool revealed,
      Value<int> rowid,
    });
typedef $$PackOpeningCardsTableUpdateCompanionBuilder =
    PackOpeningCardsCompanion Function({
      Value<String> openingId,
      Value<String> cardId,
      Value<int> slotIndex,
      Value<bool> wasNew,
      Value<int> quantityAfter,
      Value<bool> revealed,
      Value<int> rowid,
    });

final class $$PackOpeningCardsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PackOpeningCardsTable,
          PackOpeningCardRow
        > {
  $$PackOpeningCardsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PackOpeningsTable _openingIdTable(_$AppDatabase db) => db.packOpenings
      .createAlias('pack_opening_cards__opening_id__pack_openings__id');

  $$PackOpeningsTableProcessedTableManager get openingId {
    final $_column = $_itemColumn<String>('opening_id')!;

    final manager = $$PackOpeningsTableTableManager(
      $_db,
      $_db.packOpenings,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_openingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CardsTable _cardIdTable(_$AppDatabase db) =>
      db.cards.createAlias('pack_opening_cards__card_id__cards__id');

  $$CardsTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackOpeningCardsTableFilterComposer
    extends Composer<_$AppDatabase, $PackOpeningCardsTable> {
  $$PackOpeningCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasNew => $composableBuilder(
    column: $table.wasNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityAfter => $composableBuilder(
    column: $table.quantityAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get revealed => $composableBuilder(
    column: $table.revealed,
    builder: (column) => ColumnFilters(column),
  );

  $$PackOpeningsTableFilterComposer get openingId {
    final $$PackOpeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.openingId,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableFilterComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableFilterComposer get cardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackOpeningCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $PackOpeningCardsTable> {
  $$PackOpeningCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get slotIndex => $composableBuilder(
    column: $table.slotIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasNew => $composableBuilder(
    column: $table.wasNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityAfter => $composableBuilder(
    column: $table.quantityAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get revealed => $composableBuilder(
    column: $table.revealed,
    builder: (column) => ColumnOrderings(column),
  );

  $$PackOpeningsTableOrderingComposer get openingId {
    final $$PackOpeningsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.openingId,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableOrderingComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableOrderingComposer get cardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableOrderingComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackOpeningCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackOpeningCardsTable> {
  $$PackOpeningCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get slotIndex =>
      $composableBuilder(column: $table.slotIndex, builder: (column) => column);

  GeneratedColumn<bool> get wasNew =>
      $composableBuilder(column: $table.wasNew, builder: (column) => column);

  GeneratedColumn<int> get quantityAfter => $composableBuilder(
    column: $table.quantityAfter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get revealed =>
      $composableBuilder(column: $table.revealed, builder: (column) => column);

  $$PackOpeningsTableAnnotationComposer get openingId {
    final $$PackOpeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.openingId,
      referencedTable: $db.packOpenings,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackOpeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.packOpenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableAnnotationComposer get cardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackOpeningCardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackOpeningCardsTable,
          PackOpeningCardRow,
          $$PackOpeningCardsTableFilterComposer,
          $$PackOpeningCardsTableOrderingComposer,
          $$PackOpeningCardsTableAnnotationComposer,
          $$PackOpeningCardsTableCreateCompanionBuilder,
          $$PackOpeningCardsTableUpdateCompanionBuilder,
          (PackOpeningCardRow, $$PackOpeningCardsTableReferences),
          PackOpeningCardRow,
          PrefetchHooks Function({bool openingId, bool cardId})
        > {
  $$PackOpeningCardsTableTableManager(
    _$AppDatabase db,
    $PackOpeningCardsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackOpeningCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackOpeningCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackOpeningCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> openingId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> slotIndex = const Value.absent(),
                Value<bool> wasNew = const Value.absent(),
                Value<int> quantityAfter = const Value.absent(),
                Value<bool> revealed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PackOpeningCardsCompanion(
                openingId: openingId,
                cardId: cardId,
                slotIndex: slotIndex,
                wasNew: wasNew,
                quantityAfter: quantityAfter,
                revealed: revealed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String openingId,
                required String cardId,
                required int slotIndex,
                required bool wasNew,
                required int quantityAfter,
                required bool revealed,
                Value<int> rowid = const Value.absent(),
              }) => PackOpeningCardsCompanion.insert(
                openingId: openingId,
                cardId: cardId,
                slotIndex: slotIndex,
                wasNew: wasNew,
                quantityAfter: quantityAfter,
                revealed: revealed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackOpeningCardsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({openingId = false, cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (openingId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.openingId,
                                referencedTable:
                                    $$PackOpeningCardsTableReferences
                                        ._openingIdTable(db),
                                referencedColumn:
                                    $$PackOpeningCardsTableReferences
                                        ._openingIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (cardId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cardId,
                                referencedTable:
                                    $$PackOpeningCardsTableReferences
                                        ._cardIdTable(db),
                                referencedColumn:
                                    $$PackOpeningCardsTableReferences
                                        ._cardIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PackOpeningCardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackOpeningCardsTable,
      PackOpeningCardRow,
      $$PackOpeningCardsTableFilterComposer,
      $$PackOpeningCardsTableOrderingComposer,
      $$PackOpeningCardsTableAnnotationComposer,
      $$PackOpeningCardsTableCreateCompanionBuilder,
      $$PackOpeningCardsTableUpdateCompanionBuilder,
      (PackOpeningCardRow, $$PackOpeningCardsTableReferences),
      PackOpeningCardRow,
      PrefetchHooks Function({bool openingId, bool cardId})
    >;
typedef $$CoinTransactionsTableCreateCompanionBuilder =
    CoinTransactionsCompanion Function({
      required String id,
      required String installedCollectionId,
      required CoinTransactionType transactionType,
      required int amount,
      required int balanceAfter,
      Value<String?> relatedCardId,
      Value<String?> relatedPackTypeId,
      required DateTime createdAtUtc,
      Value<String?> metadataJson,
      Value<int> rowid,
    });
typedef $$CoinTransactionsTableUpdateCompanionBuilder =
    CoinTransactionsCompanion Function({
      Value<String> id,
      Value<String> installedCollectionId,
      Value<CoinTransactionType> transactionType,
      Value<int> amount,
      Value<int> balanceAfter,
      Value<String?> relatedCardId,
      Value<String?> relatedPackTypeId,
      Value<DateTime> createdAtUtc,
      Value<String?> metadataJson,
      Value<int> rowid,
    });

final class $$CoinTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CoinTransactionsTable,
          CoinTransactionRow
        > {
  $$CoinTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InstalledCollectionsTable _installedCollectionIdTable(
    _$AppDatabase db,
  ) => db.installedCollections.createAlias(
    'coin_transactions__installed_collection_id__installed_collections__id',
  );

  $$InstalledCollectionsTableProcessedTableManager get installedCollectionId {
    final $_column = $_itemColumn<String>('installed_collection_id')!;

    final manager = $$InstalledCollectionsTableTableManager(
      $_db,
      $_db.installedCollections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _installedCollectionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CardsTable _relatedCardIdTable(_$AppDatabase db) =>
      db.cards.createAlias('coin_transactions__related_card_id__cards__id');

  $$CardsTableProcessedTableManager? get relatedCardId {
    final $_column = $_itemColumn<String>('related_card_id');
    if ($_column == null) return null;
    final manager = $$CardsTableTableManager(
      $_db,
      $_db.cards,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedCardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PackTypesTable _relatedPackTypeIdTable(_$AppDatabase db) => db
      .packTypes
      .createAlias('coin_transactions__related_pack_type_id__pack_types__id');

  $$PackTypesTableProcessedTableManager? get relatedPackTypeId {
    final $_column = $_itemColumn<String>('related_pack_type_id');
    if ($_column == null) return null;
    final manager = $$PackTypesTableTableManager(
      $_db,
      $_db.packTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_relatedPackTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoinTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $CoinTransactionsTable> {
  $$CoinTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CoinTransactionType,
    CoinTransactionType,
    String
  >
  get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  $$InstalledCollectionsTableFilterComposer get installedCollectionId {
    final $$InstalledCollectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.installedCollectionId,
      referencedTable: $db.installedCollections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InstalledCollectionsTableFilterComposer(
            $db: $db,
            $table: $db.installedCollections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CardsTableFilterComposer get relatedCardId {
    final $$CardsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedCardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableFilterComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableFilterComposer get relatedPackTypeId {
    final $$PackTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableFilterComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoinTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoinTransactionsTable> {
  $$CoinTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$InstalledCollectionsTableOrderingComposer get installedCollectionId {
    final $$InstalledCollectionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableOrderingComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CardsTableOrderingComposer get relatedCardId {
    final $$CardsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedCardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableOrderingComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableOrderingComposer get relatedPackTypeId {
    final $$PackTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableOrderingComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoinTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoinTransactionsTable> {
  $$CoinTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CoinTransactionType, String>
  get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get balanceAfter => $composableBuilder(
    column: $table.balanceAfter,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  $$InstalledCollectionsTableAnnotationComposer get installedCollectionId {
    final $$InstalledCollectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.installedCollectionId,
          referencedTable: $db.installedCollections,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InstalledCollectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.installedCollections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$CardsTableAnnotationComposer get relatedCardId {
    final $$CardsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedCardId,
      referencedTable: $db.cards,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableAnnotationComposer(
            $db: $db,
            $table: $db.cards,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PackTypesTableAnnotationComposer get relatedPackTypeId {
    final $$PackTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.relatedPackTypeId,
      referencedTable: $db.packTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.packTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoinTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoinTransactionsTable,
          CoinTransactionRow,
          $$CoinTransactionsTableFilterComposer,
          $$CoinTransactionsTableOrderingComposer,
          $$CoinTransactionsTableAnnotationComposer,
          $$CoinTransactionsTableCreateCompanionBuilder,
          $$CoinTransactionsTableUpdateCompanionBuilder,
          (CoinTransactionRow, $$CoinTransactionsTableReferences),
          CoinTransactionRow,
          PrefetchHooks Function({
            bool installedCollectionId,
            bool relatedCardId,
            bool relatedPackTypeId,
          })
        > {
  $$CoinTransactionsTableTableManager(
    _$AppDatabase db,
    $CoinTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoinTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoinTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoinTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> installedCollectionId = const Value.absent(),
                Value<CoinTransactionType> transactionType =
                    const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> balanceAfter = const Value.absent(),
                Value<String?> relatedCardId = const Value.absent(),
                Value<String?> relatedPackTypeId = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoinTransactionsCompanion(
                id: id,
                installedCollectionId: installedCollectionId,
                transactionType: transactionType,
                amount: amount,
                balanceAfter: balanceAfter,
                relatedCardId: relatedCardId,
                relatedPackTypeId: relatedPackTypeId,
                createdAtUtc: createdAtUtc,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String installedCollectionId,
                required CoinTransactionType transactionType,
                required int amount,
                required int balanceAfter,
                Value<String?> relatedCardId = const Value.absent(),
                Value<String?> relatedPackTypeId = const Value.absent(),
                required DateTime createdAtUtc,
                Value<String?> metadataJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoinTransactionsCompanion.insert(
                id: id,
                installedCollectionId: installedCollectionId,
                transactionType: transactionType,
                amount: amount,
                balanceAfter: balanceAfter,
                relatedCardId: relatedCardId,
                relatedPackTypeId: relatedPackTypeId,
                createdAtUtc: createdAtUtc,
                metadataJson: metadataJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoinTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                installedCollectionId = false,
                relatedCardId = false,
                relatedPackTypeId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (installedCollectionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.installedCollectionId,
                                    referencedTable:
                                        $$CoinTransactionsTableReferences
                                            ._installedCollectionIdTable(db),
                                    referencedColumn:
                                        $$CoinTransactionsTableReferences
                                            ._installedCollectionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (relatedCardId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.relatedCardId,
                                    referencedTable:
                                        $$CoinTransactionsTableReferences
                                            ._relatedCardIdTable(db),
                                    referencedColumn:
                                        $$CoinTransactionsTableReferences
                                            ._relatedCardIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (relatedPackTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.relatedPackTypeId,
                                    referencedTable:
                                        $$CoinTransactionsTableReferences
                                            ._relatedPackTypeIdTable(db),
                                    referencedColumn:
                                        $$CoinTransactionsTableReferences
                                            ._relatedPackTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CoinTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoinTransactionsTable,
      CoinTransactionRow,
      $$CoinTransactionsTableFilterComposer,
      $$CoinTransactionsTableOrderingComposer,
      $$CoinTransactionsTableAnnotationComposer,
      $$CoinTransactionsTableCreateCompanionBuilder,
      $$CoinTransactionsTableUpdateCompanionBuilder,
      (CoinTransactionRow, $$CoinTransactionsTableReferences),
      CoinTransactionRow,
      PrefetchHooks Function({
        bool installedCollectionId,
        bool relatedCardId,
        bool relatedPackTypeId,
      })
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db, _db.mediaAssets);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(_db, _db.contentVersions);
  $$PackTypesTableTableManager get packTypes =>
      $$PackTypesTableTableManager(_db, _db.packTypes);
  $$CollectionProjectsTableTableManager get collectionProjects =>
      $$CollectionProjectsTableTableManager(_db, _db.collectionProjects);
  $$InstalledCollectionsTableTableManager get installedCollections =>
      $$InstalledCollectionsTableTableManager(_db, _db.installedCollections);
  $$RaritiesTableTableManager get rarities =>
      $$RaritiesTableTableManager(_db, _db.rarities);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db, _db.cards);
  $$CardFieldValuesTableTableManager get cardFieldValues =>
      $$CardFieldValuesTableTableManager(_db, _db.cardFieldValues);
  $$PackCardPoolTableTableManager get packCardPool =>
      $$PackCardPoolTableTableManager(_db, _db.packCardPool);
  $$PackSlotRulesTableTableManager get packSlotRules =>
      $$PackSlotRulesTableTableManager(_db, _db.packSlotRules);
  $$PackRarityProbabilitiesTableTableManager get packRarityProbabilities =>
      $$PackRarityProbabilitiesTableTableManager(
        _db,
        _db.packRarityProbabilities,
      );
  $$PackInventoryTableTableManager get packInventory =>
      $$PackInventoryTableTableManager(_db, _db.packInventory);
  $$OwnedCardsTableTableManager get ownedCards =>
      $$OwnedCardsTableTableManager(_db, _db.ownedCards);
  $$PackOpeningsTableTableManager get packOpenings =>
      $$PackOpeningsTableTableManager(_db, _db.packOpenings);
  $$PackOpeningCardsTableTableManager get packOpeningCards =>
      $$PackOpeningCardsTableTableManager(_db, _db.packOpeningCards);
  $$CoinTransactionsTableTableManager get coinTransactions =>
      $$CoinTransactionsTableTableManager(_db, _db.coinTransactions);
}

mixin _$CollectionProjectsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MediaAssetsTable get mediaAssets => attachedDatabase.mediaAssets;
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  $PackTypesTable get packTypes => attachedDatabase.packTypes;
  $CollectionProjectsTable get collectionProjects =>
      attachedDatabase.collectionProjects;
  $InstalledCollectionsTable get installedCollections =>
      attachedDatabase.installedCollections;
  $RaritiesTable get rarities => attachedDatabase.rarities;
  $PackRarityProbabilitiesTable get packRarityProbabilities =>
      attachedDatabase.packRarityProbabilities;
  CollectionProjectsDaoManager get managers =>
      CollectionProjectsDaoManager(this);
}

class CollectionProjectsDaoManager {
  final _$CollectionProjectsDaoMixin _db;
  CollectionProjectsDaoManager(this._db);
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db.attachedDatabase, _db.mediaAssets);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
  $$PackTypesTableTableManager get packTypes =>
      $$PackTypesTableTableManager(_db.attachedDatabase, _db.packTypes);
  $$CollectionProjectsTableTableManager get collectionProjects =>
      $$CollectionProjectsTableTableManager(
        _db.attachedDatabase,
        _db.collectionProjects,
      );
  $$InstalledCollectionsTableTableManager get installedCollections =>
      $$InstalledCollectionsTableTableManager(
        _db.attachedDatabase,
        _db.installedCollections,
      );
  $$RaritiesTableTableManager get rarities =>
      $$RaritiesTableTableManager(_db.attachedDatabase, _db.rarities);
  $$PackRarityProbabilitiesTableTableManager get packRarityProbabilities =>
      $$PackRarityProbabilitiesTableTableManager(
        _db.attachedDatabase,
        _db.packRarityProbabilities,
      );
}

mixin _$ContentVersionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  ContentVersionsDaoManager get managers => ContentVersionsDaoManager(this);
}

class ContentVersionsDaoManager {
  final _$ContentVersionsDaoMixin _db;
  ContentVersionsDaoManager(this._db);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
}

mixin _$RaritiesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  $RaritiesTable get rarities => attachedDatabase.rarities;
  RaritiesDaoManager get managers => RaritiesDaoManager(this);
}

class RaritiesDaoManager {
  final _$RaritiesDaoMixin _db;
  RaritiesDaoManager(this._db);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
  $$RaritiesTableTableManager get rarities =>
      $$RaritiesTableTableManager(_db.attachedDatabase, _db.rarities);
}

mixin _$CardsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  $RaritiesTable get rarities => attachedDatabase.rarities;
  $MediaAssetsTable get mediaAssets => attachedDatabase.mediaAssets;
  $CardsTable get cards => attachedDatabase.cards;
  $CardFieldValuesTable get cardFieldValues => attachedDatabase.cardFieldValues;
  CardsDaoManager get managers => CardsDaoManager(this);
}

class CardsDaoManager {
  final _$CardsDaoMixin _db;
  CardsDaoManager(this._db);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
  $$RaritiesTableTableManager get rarities =>
      $$RaritiesTableTableManager(_db.attachedDatabase, _db.rarities);
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db.attachedDatabase, _db.mediaAssets);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db.attachedDatabase, _db.cards);
  $$CardFieldValuesTableTableManager get cardFieldValues =>
      $$CardFieldValuesTableTableManager(
        _db.attachedDatabase,
        _db.cardFieldValues,
      );
}

mixin _$PackTypesDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  $MediaAssetsTable get mediaAssets => attachedDatabase.mediaAssets;
  $PackTypesTable get packTypes => attachedDatabase.packTypes;
  PackTypesDaoManager get managers => PackTypesDaoManager(this);
}

class PackTypesDaoManager {
  final _$PackTypesDaoMixin _db;
  PackTypesDaoManager(this._db);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db.attachedDatabase, _db.mediaAssets);
  $$PackTypesTableTableManager get packTypes =>
      $$PackTypesTableTableManager(_db.attachedDatabase, _db.packTypes);
}

mixin _$InstalledCollectionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  $MediaAssetsTable get mediaAssets => attachedDatabase.mediaAssets;
  $PackTypesTable get packTypes => attachedDatabase.packTypes;
  $InstalledCollectionsTable get installedCollections =>
      attachedDatabase.installedCollections;
  InstalledCollectionsDaoManager get managers =>
      InstalledCollectionsDaoManager(this);
}

class InstalledCollectionsDaoManager {
  final _$InstalledCollectionsDaoMixin _db;
  InstalledCollectionsDaoManager(this._db);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db.attachedDatabase, _db.mediaAssets);
  $$PackTypesTableTableManager get packTypes =>
      $$PackTypesTableTableManager(_db.attachedDatabase, _db.packTypes);
  $$InstalledCollectionsTableTableManager get installedCollections =>
      $$InstalledCollectionsTableTableManager(
        _db.attachedDatabase,
        _db.installedCollections,
      );
}

mixin _$PlayerProgressDaoMixin on DatabaseAccessor<AppDatabase> {
  $ContentVersionsTable get contentVersions => attachedDatabase.contentVersions;
  $MediaAssetsTable get mediaAssets => attachedDatabase.mediaAssets;
  $PackTypesTable get packTypes => attachedDatabase.packTypes;
  $InstalledCollectionsTable get installedCollections =>
      attachedDatabase.installedCollections;
  $PackInventoryTable get packInventory => attachedDatabase.packInventory;
  $RaritiesTable get rarities => attachedDatabase.rarities;
  $CardsTable get cards => attachedDatabase.cards;
  $OwnedCardsTable get ownedCards => attachedDatabase.ownedCards;
  $CoinTransactionsTable get coinTransactions =>
      attachedDatabase.coinTransactions;
  $PackOpeningsTable get packOpenings => attachedDatabase.packOpenings;
  $PackOpeningCardsTable get packOpeningCards =>
      attachedDatabase.packOpeningCards;
  PlayerProgressDaoManager get managers => PlayerProgressDaoManager(this);
}

class PlayerProgressDaoManager {
  final _$PlayerProgressDaoMixin _db;
  PlayerProgressDaoManager(this._db);
  $$ContentVersionsTableTableManager get contentVersions =>
      $$ContentVersionsTableTableManager(
        _db.attachedDatabase,
        _db.contentVersions,
      );
  $$MediaAssetsTableTableManager get mediaAssets =>
      $$MediaAssetsTableTableManager(_db.attachedDatabase, _db.mediaAssets);
  $$PackTypesTableTableManager get packTypes =>
      $$PackTypesTableTableManager(_db.attachedDatabase, _db.packTypes);
  $$InstalledCollectionsTableTableManager get installedCollections =>
      $$InstalledCollectionsTableTableManager(
        _db.attachedDatabase,
        _db.installedCollections,
      );
  $$PackInventoryTableTableManager get packInventory =>
      $$PackInventoryTableTableManager(_db.attachedDatabase, _db.packInventory);
  $$RaritiesTableTableManager get rarities =>
      $$RaritiesTableTableManager(_db.attachedDatabase, _db.rarities);
  $$CardsTableTableManager get cards =>
      $$CardsTableTableManager(_db.attachedDatabase, _db.cards);
  $$OwnedCardsTableTableManager get ownedCards =>
      $$OwnedCardsTableTableManager(_db.attachedDatabase, _db.ownedCards);
  $$CoinTransactionsTableTableManager get coinTransactions =>
      $$CoinTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.coinTransactions,
      );
  $$PackOpeningsTableTableManager get packOpenings =>
      $$PackOpeningsTableTableManager(_db.attachedDatabase, _db.packOpenings);
  $$PackOpeningCardsTableTableManager get packOpeningCards =>
      $$PackOpeningCardsTableTableManager(
        _db.attachedDatabase,
        _db.packOpeningCards,
      );
}
