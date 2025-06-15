class TransactionItem {
  final int? id;
  final double amount;
  final String? notesOrCategory;
  final String methodOrType;
  final DateTime date;
  final bool isIncome;

  TransactionItem({
    this.id,
    required this.amount,
    this.notesOrCategory,
    required this.methodOrType,
    required this.date,
    required this.isIncome,
  });
}
