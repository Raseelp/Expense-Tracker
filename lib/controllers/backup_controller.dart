import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BackupController extends GetxController {
  static const _incomeDbName = 'income_db.db';
  static const _expenseDbName = 'expense_db.db';

  Future<void> backupDatabases() async {
    final dbPath = await getDatabasesPath();

    final incomeFile = File(join(dbPath, _incomeDbName));
    final expenseFile = File(join(dbPath, _expenseDbName));

    final appStorage = await getExternalStorageDirectory();
    final appBackupDir = Directory('${appStorage!.path}/backup');

    if (!await appBackupDir.exists()) {
      await appBackupDir.create(recursive: true);
    }

    final tempIncome = File(join(appBackupDir.path, 'backup_income.db'));
    final tempExpense = File(join(appBackupDir.path, 'backup_expense.db'));

    await incomeFile.copy(tempIncome.path);
    await expenseFile.copy(tempExpense.path);

    print('✅ Backup created in app folder');

    if (await Permission.manageExternalStorage.request().isGranted ||
        await Permission.storage.request().isGranted) {
      final downloadsDir =
          Directory('/storage/emulated/0/Download/ExpenseTracker');

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }
      downloadsDir.list().forEach((file) {
        print('📄 Found file: ${file.path}');
      });

      await tempIncome.copy('${downloadsDir.path}/backup_income.db');
      await tempExpense.copy('${downloadsDir.path}/backup_expense.db');

      print('✅ Backup also copied to Downloads/ExpenseTracker');
    } else {
      print(
          '❌ Permission to access Downloads denied. Backup only in app folder.');
    }
  }

  Future<void> restoreDatabase(String dbType, BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result == null) {
      print('❌ No file selected.');
      return;
    }

    final pickedFile = File(result.files.single.path!);
    final extension = result.files.single.extension;

    if (extension != 'db') {
      print('❌ Invalid file type. Please select a .db file.');
      return;
    }

    final dbPath = await getDatabasesPath();
    final fileName = dbType == 'income' ? _incomeDbName : _expenseDbName;

    await pickedFile.copy(join(dbPath, fileName));
    print('✅ $fileName restored successfully!');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$fileName restored successfully!')),
    );
  }
}
