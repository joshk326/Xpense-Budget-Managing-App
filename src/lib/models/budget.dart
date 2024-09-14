class NewBudget {
  final int? id;
  final String? amount;
  final String? startDate;
  final String? endDate;

  NewBudget({this.id, this.amount, this.startDate, this.endDate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'budgetamount': amount,
    };
  }
}
