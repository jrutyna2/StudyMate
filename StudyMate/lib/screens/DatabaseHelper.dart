import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'schedule_screen.dart'; // Import your Event class

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        '''
        CREATE TABLE events(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          date TEXT NOT NULL,
          title TEXT NOT NULL,
          description TEXT NOT NULL
        )
        ''',
      );
    });
  }

  Future<int> insertEvent(Event event) async {
    final db = await instance.database;
    return await db.insert('events', event.toMap());
  }

  Future<List<Event>> getEventsForDay(DateTime day) async {
    final db = await instance.database;
    final dateString = day.toIso8601String().split('T')[0];
    final List<Map<String, dynamic>> maps = await db.query(
      'events',
      where: 'date LIKE ?',
      whereArgs: ['$dateString%'],
    );

    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<void> updateEvent(Event event) async {
    final db = await instance.database;
    await db.update(
      'events',
      event.toMap(),
      where: 'id = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(int id) async {
    final db = await instance.database;
    await db.delete(
      'events',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
