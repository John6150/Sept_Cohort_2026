import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteDB {
  // Create / Open
  Future<Database> initDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'user.db');

    // open the database
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE UserTable (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, gender TEXT)',
        );
      },
    );

    return database;
  }

  // Write to DB
  Future<void> insertFn({
    required String name,
    required int age,
    required String gender,
  }) async {
    final database = await initDB();
    try {
      // Insert some records in a transaction
      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
          'INSERT INTO UserTable(name, age, gender) VALUES("$name", "$age", "$gender")',
        );
        print('inserted1: $id1');
        // int id2 = await txn.rawInsert(
        //   'INSERT INTO Test(name, value, num) VALUES(?, ?, ?)',
        //   ['another name', 12345678, 3.1416],
        // );
        // print('inserted2: $id2');
      });
    } catch (e) {
      print(e);
    }
  }

  // Read from DB
  Future<List<Map<String, dynamic>>?> getRecords() async {
    final database = await initDB();
    // Get the records
    try {
      List<Map<String, dynamic>> list = await database.rawQuery(
        'SELECT * FROM UserTable',
      );
      return list;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Delete from DB
  Future<void> deleteRecord(String name) async {
    final database = await initDB();

    try {
      // Delete a record
      await database.rawDelete('DELETE FROM UserTable WHERE name = ?', [name]);
    } catch (e) {
      print(e);
    }
  }

  // Update on DB

  Future<void> updateRecord({
    required String oldName,
    required String newName,
    int age = 0,
  }) async {
    final database = await initDB();

    try {
      // Update some record
      int count = await database.rawUpdate(
        age == 0
            ? 'UPDATE UserTable SET name = ?, WHERE name = ?'
            : 'UPDATE UserTable SET name = ?, age = ? WHERE name = ?',
        age == 0 ? [oldName, newName] : [oldName, age, newName],
      );
      print('updated: $count');
    } catch (e) {
      print(e);
    }
  }
}
