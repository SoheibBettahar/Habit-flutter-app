import 'package:habit/models/habit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HabitDatabase {
  String _databaseName = 'habits_database.db';
  String _tableName = 'habits';

  //private constructor
  HabitDatabase._();

  static final db = HabitDatabase._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDatabase();

    return _database;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, name TEXT, status INTEGER, imageUrl TEXT, days INTEGER, notificationTime INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertHabit(Habit habit) async {
    print('insertHabit called: $habit');
    final Database db = await database;
    return await db.insert(
      _tableName,
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Habit>> getHabits() async {
    final Database db = await database;
    var habitsMap = await db.query(_tableName);

    return List.generate(habitsMap.length, (i) => Habit.fromMap(habitsMap[i]));
  }

  Future<Habit> getHabit(int id) async {
    final Database db = await database;
    var habitMap = await db.query(_tableName, where: 'id= ?', whereArgs: [id]);
    return habitMap.isNotEmpty ? Habit.fromMap(habitMap.first) : null;
  }

  Future<int> updateHabit(Habit habit) async {
    final Database db = await database;

    return db.update(_tableName, habit.toMap(),
        where: 'id= ?', whereArgs: [habit.id]);
  }

  Future<int> deleteHabit(int id) async {
    final Database db = await database;

    return await db.delete(_tableName, where: 'id= ?', whereArgs: [id]);
  }
}
