import 'package:expence_tracker/controllers/common_controller.dart';
import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  IncomeController incomeController = Get.find();
  ExpenseController expenseController = Get.find();
  CommonController commonController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16, bottom: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: Colors.grey.shade900),
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Add Income',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 110,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                              color: Colors.grey.shade900, fontSize: 16),
                        ),
                        TextFormField(
                          maxLines: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.phone,
                          controller: incomeController
                              .incomeAmountTextEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter the Amount',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Container(
                  height: 110,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes (Optional)',
                          style: TextStyle(
                              color: Colors.grey.shade900, fontSize: 16),
                        ),
                        TextField(
                          maxLines: 1,
                          controller:
                              incomeController.incomeNotesTextEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a Description',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade500, fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Cash Deposited in',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                children: [
                  Obx(
                    () => Column(
                      children: [
                        _buildPaymentOption(
                          label: "in Hand",
                          value: "inHand",
                          controller: incomeController,
                        ),
                        _buildPaymentOption(
                          label: "Credit/Debit Card",
                          value: "Card",
                          controller: incomeController,
                        ),
                        _buildPaymentOption(
                          label: "Google Pay",
                          value: "Gpay",
                          controller: incomeController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  InkWell(
                    onTap: () async {
                      if (incomeController
                          .incomeAmountTextEditingController.text.isNotEmpty) {
                        await incomeController.saveIncome();
                        await incomeController.fetchAllIncome();
                        commonController.updateTransactions(
                            incomes: incomeController.incomes,
                            expenses: expenseController.expenses);
                        Get.back();
                      } else {
                        Get.closeAllSnackbars();
                        Get.snackbar(
                            'Amount Empty', 'Income amount must be provided');
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 90,
                      decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: Center(
                        child: Obx(
                          () => incomeController.isSaving.value
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Add',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey.shade800,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String label,
    required String value,
    required IncomeController controller,
  }) {
    final isSelected = controller.selectedMethod.value == value;

    return InkWell(
      onTap: () => controller.selectedMethod.value = value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.green.shade100 : Colors.grey.shade400,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? Colors.green.shade900 : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.green.shade900 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
