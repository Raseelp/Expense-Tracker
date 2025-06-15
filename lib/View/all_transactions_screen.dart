import 'package:expence_tracker/View/widgets/transaction_tile.dart';
import 'package:expence_tracker/controllers/common_controller.dart';
import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class AllTransactionsScreen extends StatelessWidget {
  const AllTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find();
    IncomeController incomeController = Get.find();
    ExpenseController expenseController = Get.find();

    return Scaffold(
        appBar: AppBar(
          title: const Text('All transactions'),
        ),
        body: GetBuilder<CommonController>(
            init: commonController,
            builder: (controller) {
              final transactions = commonController.allTransactionList;
              return SingleChildScrollView(
                child: transactions.isEmpty
                    ? const Center(child: Text('No transactions Yet'))
                    : SlidableAutoCloseBehavior(
                        child: Column(
                            children: List.generate(
                          transactions.length,
                          (index) {
                            final transaction = transactions[index];
                            return Slidable(
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (_) async {
                                      if (transaction.isIncome) {
                                        await incomeController
                                            .deleteIncome(transaction.id!);
                                        controller.updateTransactions(
                                            incomes: incomeController.incomes,
                                            expenses:
                                                expenseController.expenses);
                                      } else {
                                        await expenseController
                                            .deleteExpense(transaction.id!);
                                        controller.updateTransactions(
                                            incomes: incomeController.incomes,
                                            expenses:
                                                expenseController.expenses);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: TransactionTile(
                                title: transaction.notesOrCategory!,
                                amount: transaction.amount,
                                method: transaction.methodOrType,
                                date: transaction.date,
                                isIncome: transaction.isIncome,
                              ),
                            );
                          },
                        )),
                      ),
              );
            }));
  }
}
