import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final double amount;
  final String method;
  final DateTime date;
  final bool isIncome;

  const TransactionTile({
    super.key,
    required this.title,
    required this.amount,
    required this.method,
    required this.date,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    ExpenseController expenseController = Get.find();
    final formattedDate = DateFormat('MMM dd, yyyy').format(date);
    final color = isIncome ? Colors.green.shade100 : Colors.red.shade100;
    final amountColor = isIncome ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isIncome
                    ? Icon(
                        Icons.arrow_downward,
                        color: amountColor,
                        size: 36,
                      )
                    : Obx(() {
                        final catagory = title;
                        int selectedIndex = expenseController.expenseCatagories
                            .indexOf(catagory);

                        String imagePath = selectedIndex >= 0
                            ? expenseController
                                .expenseCatagoriesImages[selectedIndex]
                            : 'assets/food.svg';
                        return Center(
                          child: SvgPicture.asset(
                            imagePath,
                            height: 30,
                            width: 30,
                          ),
                        );
                      }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${isIncome ? '+' : '-'}₹${amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: amountColor),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          method,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
