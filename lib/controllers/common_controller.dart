import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:expence_tracker/models/expense_model.dart';
import 'package:expence_tracker/models/income_model.dart';
import 'package:expence_tracker/models/transaction_model.dart';
import 'package:get/get.dart';

class CommonController extends GetxController {
  RxList<TransactionItem> allTransactionList = <TransactionItem>[].obs;
  ExpenseController expenseController = Get.find();
  IncomeController incomeController = Get.find();
  @override
  void onInit() async {
    await expenseController.fetchAllExpenses();
    await incomeController.fetchAllIncome();
    updateTransactions(
        expenses: expenseController.expenses,
        incomes: incomeController.incomes);
    super.onInit();
  }

  List<TransactionItem> mergeAndSortTransactions({
    required List<Income> incomes,
    required List<Expense> expenses,
  }) {
    List<TransactionItem> mergedList = [
      ...incomes.map((income) => TransactionItem(
            id: income.id,
            amount: income.amount,
            notesOrCategory: income.notes,
            methodOrType: income.depositMethod,
            date: income.date,
            isIncome: true,
          )),
      ...expenses.map((expense) => TransactionItem(
            id: expense.id,
            amount: expense.amount,
            notesOrCategory:
                expense.notes!.isEmpty ? expense.category : expense.notes,
            methodOrType: expense.paymentType,
            date: expense.date,
            isIncome: false,
          )),
    ];

    mergedList.sort((a, b) => b.date.compareTo(a.date));
    return mergedList;
  }

  void updateTransactions({
    required List<Income> incomes,
    required List<Expense> expenses,
  }) {
    allTransactionList.value = mergeAndSortTransactions(
      incomes: incomes,
      expenses: expenses,
    );
    update();
  }
}
