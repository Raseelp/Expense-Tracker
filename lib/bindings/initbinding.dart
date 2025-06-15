import 'package:expence_tracker/controllers/backup_controller.dart';
import 'package:expence_tracker/controllers/common_controller.dart';
import 'package:expence_tracker/controllers/expense_controller.dart';
import 'package:expence_tracker/controllers/income_controller.dart';
import 'package:get/get.dart';

class Initbinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpenseController());
    Get.put(IncomeController());
    Get.put(CommonController());
    Get.put(BackupController());
  }
}
