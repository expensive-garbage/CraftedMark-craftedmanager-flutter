class Payment {
  int id;
  int? orderId;
  double amount;
  DateTime dateAdded;
  String collectedBy;
  String method;
  bool collectedbymark;
  String? description;

  Payment({
    required this.id,
    this.orderId,
    required this.amount,
    required this.dateAdded,
    required this.collectedBy,
    required this.method,
    required this.collectedbymark,
    this.description,
  });

  Payment.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        orderId = data['order_id'],
        amount = data['amount'],
        dateAdded = DateTime.parse(data['date_added']),
        collectedBy = data['collected_by'],
        method = data['method'],
        collectedbymark = data['collectedbymark'] == 1,
        description = data['description'];
}

class Bill {
  int id;
  String name;
  double amount;
  DateTime dateAdded;
  DateTime dueDate;

  Bill({
    required this.id,
    required this.name,
    required this.amount,
    required this.dateAdded,
    required this.dueDate,
  });

  Bill.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        amount = data['amount'],
        dateAdded = DateTime.parse(data['date_added']),
        dueDate = DateTime.parse(data['due_date']);
}

class Expense {
  int id;
  String description;
  double amount;
  DateTime dateAdded;
  String category;
  String vendor;
  String paidBy;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.dateAdded,
    required this.category,
    required this.vendor,
    required this.paidBy,
  });

  Expense.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        description = data['description'],
        amount = data['amount'],
        dateAdded = DateTime.parse(data['date_added']),
        category = data['category'],
        vendor = data['vendor'],
        paidBy = data['paid_by'];
}
