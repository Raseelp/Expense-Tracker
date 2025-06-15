import 'package:expence_tracker/controllers/common_controller.dart';
import 'package:expence_tracker/db/expense_db.dart';
import 'package:expence_tracker/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  RxString selectedMethod = 'inHand'.obs;
  RxString selectedCatagory = 'Food'.obs;
  RxDouble totalExpense = 0.0.obs;
  var expenses = <Expense>[].obs;

  RxList<String> expenseCatagories =
      ['Food', 'Fuel', 'Home', 'Medicine', 'Bills', 'Shopping', 'Movies'].obs;
  List<String> expenseCatagoriesImages = [
    'assets/food.svg',
    'assets/fuel.svg',
    'assets/home.svg',
    'assets/medicine.svg',
    'assets/bills.svg',
    'assets/shopping.svg',
    'assets/movies.svg',
  ];

  final List<Color> colorsList = [
    const Color(0xFFB7DAAC), // soft green
    const Color(0xFFFFB8A9), // soft coral
    const Color(0xFFFBEDD4), // soft beige
    const Color(0xFFF2E8FF), // soft lavender
    const Color(0xFFA5D8FF), // soft sky blue
    const Color(0xFFFFD6E8), // soft pink
    const Color(0xFFFFF3B0), // soft yellow
    // const Color(0xFFD5C4F6), // soft purple
    // const Color(0xFFE0F7DA), // mint green
    // const Color(0xFFFFE9C6), // peachy cream
  ];

  List<String> filterByGap = ['All', 'Today', 'This Week', 'This Month'];
  TextEditingController expenseAmountController = TextEditingController();
  TextEditingController expenseNotesController = TextEditingController();
  final db = ExpenseDatabaseHelper.instance;

  RxBool isSaving = false.obs;
  Future<void> addExpense(Expense expense) async {
    await db.insertExpense(expense);
    await fetchAllExpenses();
  }

  Future<void> fetchAllExpenses() async {
    expenses.value = await db.fetchAllExpenses();
    sumOfAllExpenses();
  }

  Future<void> saveExpense() async {
    isSaving.value = true;

    final newExpense = Expense(
        amount: double.parse(expenseAmountController.text),
        category: selectedCatagory.value,
        notes: expenseNotesController.text,
        paymentType: selectedMethod.value,
        date: DateTime.now(),
        isIncome: false);

    await addExpense(newExpense);
    isSaving.value = false;
  }

  void sumOfAllExpenses() {
    totalExpense.value = expenses.fold(
      0.0,
      (sum, item) => sum + item.amount,
    );
  }

  Future<void> deleteExpense(int id) async {
    await db.deleteExpenseById(id);
    await fetchAllExpenses();
  }
}
