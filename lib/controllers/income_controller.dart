import 'package:expence_tracker/db/income_db.dart';
import 'package:expence_tracker/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController {
  RxString selectedMethod = 'inHand'.obs;
  TextEditingController incomeAmountTextEditingController =
      TextEditingController();
  TextEditingController incomeNotesTextEditingController =
      TextEditingController();
  final db = IncomeDatabaseHelper.instance;
  RxDouble totelIncome = 0.0.obs;
  var incomes = <Income>[].obs;
  RxBool isSaving = false.obs;

  Future<void> addIncome(Income income) async {
    await db.insertIncome(income);
    await fetchAllIncome();
  }

  Future<void> fetchAllIncome() async {
    incomes.value = await db.fetchAllIncomes();
    sumOfAllIncome();
  }

  Future<void> saveIncome() async {
    isSaving.value = true;
    final newIncome = Income(
        amount: double.parse(incomeAmountTextEditingController.text),
        notes: incomeNotesTextEditingController.text,
        depositMethod: selectedMethod.toString(),
        date: DateTime.now(),
        isIncome: true);

    await addIncome(newIncome);
    isSaving.value = false;
  }

  sumOfAllIncome() {
    totelIncome.value = incomes.fold(
      0.0,
      (sum, element) => sum + element.amount,
    );
  }

  Future<void> deleteIncome(int id) async {
    await db.deleteIncomeById(id);
    await fetchAllIncome();
  }
}
