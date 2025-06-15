import 'package:expence_tracker/View/widgets/balance_pichart_widget.dart';
import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    ExpenseController expenseController = Get.find();
    IncomeController incomeController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 23),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Totel Income',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                    ),
                    Obx(
                      () => Text(
                        '  ₹${incomeController.totelIncome}',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 10,
                            color: Colors.red.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Spent',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Obx(
                        () => Text(
                          '  ₹${expenseController.totalExpense}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 10,
                            color: expenseController.colorsList[4],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Balance',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Obx(
                        () => Text(
                          '  ₹${incomeController.totelIncome.value - expenseController.totalExpense.value}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  PieChartDemo()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
