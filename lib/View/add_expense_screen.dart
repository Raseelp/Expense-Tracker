import 'package:expence_tracker/controllers/common_controller.dart';
import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  ExpenseController expenseController = Get.find();
  IncomeController incomeController = Get.find();
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
                      'Add Expenses',
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
                        TextField(
                          maxLines: 1,
                          controller: expenseController.expenseAmountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.phone,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
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
                          'Catagory',
                          style: TextStyle(
                              color: Colors.grey.shade900, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(() {
                                  int selectedIndex = expenseController
                                      .expenseCatagories
                                      .indexOf(expenseController
                                          .selectedCatagory.value);

                                  String imagePath = selectedIndex >= 0
                                      ? expenseController
                                              .expenseCatagoriesImages[
                                          selectedIndex]
                                      : 'assets/food.svg';
                                  Color color = selectedIndex >= 0
                                      ? expenseController
                                          .colorsList[selectedIndex]
                                      : Colors.red.shade100;
                                  return Container(
                                    height: 45,
                                    width: 45,
                                    decoration: BoxDecoration(
                                        color: color,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        imagePath,
                                        height: 25,
                                        width: 25,
                                      ),
                                    ),
                                  );
                                }),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Obx(
                                    () => Text(
                                      expenseController.selectedCatagory.value,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   height: 40,
                            //   width: 40,
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(100)),
                            //   child: const Icon(
                            //       Icons.keyboard_arrow_down_outlined),
                            // ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: DropdownButton<String>(
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 30,
                                  ),
                                  elevation: 0,
                                  dropdownColor: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                  style: TextStyle(
                                      color: Colors.red.shade900, fontSize: 18),
                                  items:
                                      expenseController.expenseCatagories.map(
                                    (String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (newValue) {
                                    expenseController.selectedCatagory.value =
                                        newValue!;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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
                          'Notes (Optional)',
                          style: TextStyle(
                              color: Colors.grey.shade900, fontSize: 16),
                        ),
                        TextField(
                          maxLines: 1,
                          controller: expenseController.expenseNotesController,
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
                  'Payment Type',
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
                          controller: expenseController,
                        ),
                        _buildPaymentOption(
                          label: "Credit/Debit Card",
                          value: "Card",
                          controller: expenseController,
                        ),
                        _buildPaymentOption(
                          label: "Google Pay",
                          value: "Gpay",
                          controller: expenseController,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (expenseController
                          .expenseAmountController.text.isNotEmpty) {
                        await expenseController.saveExpense();
                        await expenseController.fetchAllExpenses();
                        commonController.updateTransactions(
                            incomes: incomeController.incomes,
                            expenses: expenseController.expenses);
                        Get.back();
                      } else {
                        Get.closeAllSnackbars();
                        Get.snackbar('Amount missing',
                            'Expense amount must be provided');
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Center(
                        child: Obx(
                          () => expenseController.isSaving.value
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.bold,
                                  ),
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
    required ExpenseController controller,
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
            color: isSelected ? Colors.red.shade100 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.red.shade100 : Colors.grey.shade400,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? Colors.red.shade900 : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.red.shade900 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
