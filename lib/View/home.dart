import 'package:expence_tracker/View/add_expense_screen.dart';
import 'package:expence_tracker/View/add_income_screen.dart';
import 'package:expence_tracker/View/all_transactions_screen.dart';
import 'package:expence_tracker/View/widgets/card_widget.dart';
import 'package:expence_tracker/View/widgets/transaction_tile.dart';
import 'package:expence_tracker/controllers/backup_controller.dart';
import 'package:expence_tracker/controllers/common_controller.dart';
import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CommonController commonController = Get.find();
    ExpenseController expenseController = Get.find();
    IncomeController incomeController = Get.find();
    BackupController backupController = Get.find();

    final pageController = PageController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        'Raseel',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     IconButton(
                  //       onPressed: () {
                  //         backupController.backupDatabases();
                  //       },
                  //       icon: const Icon(Icons.download),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         Get.bottomSheet(const BackupBottomsheet());
                  //       },
                  //       icon: const Icon(Icons.upload),
                  //     )
                  //   ],
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: pageController,
                itemCount: 4,
                itemBuilder: (_, index) {
                  return CardWidget(
                    index: index,
                  );
                },
              ),
            ),
            Center(
              child: SizedBox(
                height: 1,
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: WormEffect(
                    dotColor: Colors.green.shade100,
                    activeDotColor: Colors.green.shade900,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 10, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Get.to(() => const AllTransactionsScreen());
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(30, 40),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  )
                ],
              ),
            ),
            GetBuilder<CommonController>(
              init: commonController,
              builder: (controller) {
                final transactions = controller.allTransactionList;
                return transactions.isEmpty
                    ? const Center(child: Text('No Transactions Yet'))
                    : Column(
                        children: List.generate(
                        transactions.length,
                        (index) {
                          final transaction = transactions[index];
                          return TransactionTile(
                            title: transaction.notesOrCategory!,
                            amount: transaction.amount,
                            method: transaction.methodOrType,
                            date: transaction.date,
                            isIncome: transaction.isIncome,
                          );
                        },
                      ));
              },
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.add_event,
        backgroundColor: Colors.green.shade300,
        foregroundColor: Colors.black,
        buttonSize: const Size(70, 70),
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        curve: Curves.elasticInOut,
        overlayColor: Colors.white,
        overlayOpacity: 0.5,
        spaceBetweenChildren: 20,
        childrenButtonSize: const Size(70, 70),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.sim_card_download_rounded),
            backgroundColor: Colors.green.shade300,
            foregroundColor: Colors.white,
            label: 'Add Income',
            onTap: () {
              Get.to(() => const AddIncomeScreen());
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.upload_file_rounded),
            backgroundColor: Colors.red.shade300,
            foregroundColor: Colors.white,
            label: 'Add Expense',
            onTap: () {
              Get.to(() => const AddExpenseScreen());
            },
          ),
        ],
      ),
    );
  }
}
