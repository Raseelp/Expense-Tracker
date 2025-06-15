import 'package:expence_tracker/models/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ExpenseDatabaseHelper {
  static final ExpenseDatabaseHelper instance = ExpenseDatabaseHelper._init();
  static Database? _database;

  ExpenseDatabaseHelper._init();

  Future<Database> get database async {
    _database ??= await _initDB('expense_db.db');
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
    CREATE TABLE expense(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL,
      category TEXT,
      notes TEXT,
      paymentType TEXT,
      date TEXT,
      isIncome INTEGER
    )
  ''');
  }

  Future<int> insertExpense(Expense expense) async {
    final db = await instance.database;
    return await db.insert('expense', expense.toMap());
  }

  Future<int> deleteExpenseById(int id) async {
    final db = await instance.database;
    return await db.delete(
      'expense',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Expense>> fetchAllExpenses() async {
    final db = await instance.database;
    final maps = await db.query('expense');

    if (maps.isNotEmpty) {
      return maps.map((map) => Expense.fromMap(map)).toList();
    } else {
      return [];
    }
  }
}
