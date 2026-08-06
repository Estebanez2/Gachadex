abstract final class DomainValidation {
  static String requireTrimmedNotEmpty(String value, String fieldName) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError.value(value, fieldName, 'Must not be empty.');
    }

    return trimmed;
  }

  static String trimmed(String value) {
    return value.trim();
  }

  static String? optionalTrimmed(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }

    return trimmed;
  }

  static int requireNonNegative(int value, String fieldName) {
    if (value < 0) {
      throw ArgumentError.value(value, fieldName, 'Must be zero or greater.');
    }

    return value;
  }

  static int requirePositive(int value, String fieldName) {
    if (value <= 0) {
      throw ArgumentError.value(value, fieldName, 'Must be greater than zero.');
    }

    return value;
  }

  static int requireMax(int value, int max, String fieldName) {
    if (value > max) {
      throw ArgumentError.value(value, fieldName, 'Must be at most $max.');
    }

    return value;
  }

  static DateTime requireUtc(DateTime value, String fieldName) {
    if (!value.isUtc) {
      throw ArgumentError.value(value, fieldName, 'Must be UTC.');
    }

    return value;
  }

  static DateTime? optionalUtc(DateTime? value, String fieldName) {
    if (value == null) {
      return null;
    }

    return requireUtc(value, fieldName);
  }
}
