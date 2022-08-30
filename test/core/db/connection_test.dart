@TestOn('vm')
library sqflite_common_ffi.test.sqflite_ffi_doc_test;

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
  });

  test('deve inicializar uma instância fake de SQL', () async {
    final factory = databaseFactoryFfi;
    var db = await factory.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(version: 1),
    );

    expect(await db.getVersion(), 1);

    await db.close();
  });
}
