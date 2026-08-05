DateTime fromDatabaseUtc(DateTime value) {
  if (value.isUtc) {
    return value;
  }

  return DateTime.fromMillisecondsSinceEpoch(
    value.millisecondsSinceEpoch,
    isUtc: true,
  );
}

DateTime toDatabaseUtc(DateTime value) {
  if (!value.isUtc) {
    throw ArgumentError.value(value, 'value', 'DateTime must be UTC.');
  }

  return value;
}
