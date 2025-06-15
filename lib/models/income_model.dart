class Income {
  final int? id;
  final double amount;
  final String? notes;
  final String depositMethod;
  final DateTime date;
  final bool isIncome;

  Income({
    this.id,
    required this.amount,
    this.notes,
    required this.depositMethod,
    required this.date,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'notes': notes == '' ? 'Income' : notes,
      'depositMethod': depositMethod,
      'date': date.toIso8601String(),
      'isIncome': isIncome ? 1 : 0,
    };
  }

  factory Income.fromMap(Map<String, dynamic> map) {
    return Income(
      id: map['id'] as int?,
      amount: map['amount'] is int
          ? (map['amount'] as int).toDouble()
          : map['amount'] as double,
      notes: map['notes'] as String?,
      depositMethod: map['depositMethod'] as String,
      date: DateTime.parse(map['date'] as String),
      isIncome: map['isIncome'] == 1, // Convert int to bool
    );
  }

  Income copyWith({
    int? id,
    double? amount,
    String? notes,
    String? depositMethod,
    DateTime? date,
    bool? isIncome,
  }) {
    return Income(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      depositMethod: depositMethod ?? this.depositMethod,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
    );
  }
}
