import 'package:expence_tracker/controllers/backup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackupBottomsheet extends StatelessWidget {
  const BackupBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    BackupController backupController = Get.find();
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              backupController.restoreDatabase('expense', context);
              Get.back();
            },
            child: const Text('Backup Expenses'),
          ),
          ElevatedButton(
            onPressed: () {
              backupController.restoreDatabase('income', context);
              Get.back();
            },
            child: const Text('Backup Income'),
          ),
        ],
      ),
    );
  }
}
