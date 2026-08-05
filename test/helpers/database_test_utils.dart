import 'dart:io';

import 'package:drift/native.dart';
import 'package:gachadex/core/database/app_database.dart';

AppDatabase createInMemoryDatabase() {
  return AppDatabase(NativeDatabase.memory());
}

AppDatabase createFileDatabase(File file) {
  return AppDatabase(NativeDatabase(file));
}
