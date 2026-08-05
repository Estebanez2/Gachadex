import 'package:path/path.dart' as path;

final class RelativeMediaPath {
  RelativeMediaPath(String value) : value = _validate(value);

  final String value;

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) {
    return other is RelativeMediaPath && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  static String _validate(String rawValue) {
    final value = rawValue.trim();
    if (value.isEmpty) {
      throw ArgumentError.value(rawValue, 'value', 'Must not be empty.');
    }

    if (value.contains(r'\')) {
      throw ArgumentError.value(
        rawValue,
        'value',
        'Use forward slashes for stored media paths.',
      );
    }

    if (value.contains('://') ||
        value.startsWith('file:') ||
        value.contains(':')) {
      throw ArgumentError.value(
        rawValue,
        'value',
        'Must not be an URI or contain a drive prefix.',
      );
    }

    if (path.posix.isAbsolute(value)) {
      throw ArgumentError.value(rawValue, 'value', 'Must be relative.');
    }

    final segments = value.split('/');
    if (segments.any((segment) => segment.isEmpty || segment == '.')) {
      throw ArgumentError.value(
        rawValue,
        'value',
        'Must not contain empty or current directory segments.',
      );
    }

    if (segments.contains('..')) {
      throw ArgumentError.value(
        rawValue,
        'value',
        'Must not traverse parent directories.',
      );
    }

    if (path.posix.normalize(value) != value) {
      throw ArgumentError.value(rawValue, 'value', 'Must be normalized.');
    }

    return value;
  }
}
