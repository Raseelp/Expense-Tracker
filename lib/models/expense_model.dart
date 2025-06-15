class Expense {
  final int? id;
  final double amount;
  final String category;
  final String? notes;
  final String paymentType;
  final DateTime date;
  final bool isIncome;

  Expense({
    this.id,
    required this.amount,
    required this.category,
    this.notes,
    required this.paymentType,
    required this.date,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'notes': notes ?? '',
      'paymentType': paymentType,
      'date': date.toIso8601String(),
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] as int?,
      amount: map['amount'] is int
          ? (map['amount'] as int).toDouble()
          : map['amount'] as double,
      category: map['category'] as String,
      notes: map['notes'] as String?,
      paymentType: map['paymentType'] as String,
      date: DateTime.parse(map['date'] as String),
      isIncome: map['isIncome'] == 1, // Convert int to bool
    );
  }

  Expense copyWith({
    int? id,
    double? amount,
    String? category,
    String? notes,
    String? paymentType,
    DateTime? date,
    bool? isIncome,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      paymentType: paymentType ?? this.paymentType,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}
