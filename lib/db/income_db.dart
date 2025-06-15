import 'package:expence_tracker/models/income_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class IncomeDatabaseHelper {
  static final IncomeDatabaseHelper instance = IncomeDatabaseHelper._init();
  static Database? _database;

  IncomeDatabaseHelper._init();

  Future<Database> get database async {
    _database ??= await _initDB('income_db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE income(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      notes TEXT,
      depositMethod TEXT,
      date TEXT,
      isIncome INTEGER
    )
  ''');
  }

  Future<int> insertIncome(Income income) async {
    final db = await instance.database;
    return await db.insert('income', income.toMap());
  }

  Future<int> deleteIncomeById(int id) async {
    final db = await instance.database;
    return await db.delete(
      'income',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Income>> fetchAllIncomes() async {
    final db = await instance.database;
    final maps = await db.query('income');

    if (maps.isNotEmpty) {
      return maps.map((map) => Income.fromMap(map)).toList();
    } else {
      return [];
    }
  }
}
