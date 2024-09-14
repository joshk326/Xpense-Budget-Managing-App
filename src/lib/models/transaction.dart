class NewTransaction {
  final int? id;
  final String? title;
  final String? date;
  final String? category;
  final String? amount;

  NewTransaction({this.id, this.title, this.date, this.category, this.amount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'category': category,
      'amount': amount,
    };
  }
}
