class FinanceDbManager {
  // Tables
  static const String paymentTable = 'payment';
  static const String billTable = 'bill';
  static const String expenseTable = 'expense';

  // Payment
  Future<List<Map<String, dynamic>>> getAllPayments() async {
    return getAll(paymentTable);
  }

  Future<List<Map<String, dynamic>>> searchPayments(
      String searchQuery, Map<String, dynamic> substitutionValues) async {
    return search(paymentTable, searchQuery, substitutionValues);
  }

  Future<void> addPayment(Map<String, dynamic> data) async {
    await add(paymentTable, data);
  }

  Future<void> updatePayment(int id, Map<String, dynamic> updatedData) async {
    await update(paymentTable, id, updatedData);
  }

  Future<void> deletePayment(int id) async {
    await delete(paymentTable, id);
  }

  // Bill
  Future<List<Map<String, dynamic>>> getAllBills() async {
    return getAll(billTable);
  }

  Future<List<Map<String, dynamic>>> searchBills(
      String searchQuery, Map<String, dynamic> substitutionValues) async {
    return search(billTable, searchQuery, substitutionValues);
  }

  Future<void> addBill(Map<String, dynamic> data) async {
    await add(billTable, data);
  }

  Future<void> updateBill(int id, Map<String, dynamic> updatedData) async {
    await update(billTable, id, updatedData);
  }

  Future<void> deleteBill(int id) async {
    await delete(billTable, id);
  }

  // Expense
  Future<List<Map<String, dynamic>>> getAllExpenses() async {
    return getAll(expenseTable);
  }

  Future<List<Map<String, dynamic>>> searchExpenses(
      String searchQuery, Map<String, dynamic> substitutionValues) async {
    return search(expenseTable, searchQuery, substitutionValues);
  }

  Future<void> addExpense(Map<String, dynamic> data) async {
    await add(expenseTable, data);
  }

  Future<void> updateExpense(int id, Map<String, dynamic> updatedData) async {
    await update(expenseTable, id, updatedData);
  }

  Future<void> deleteExpense(int id) async {
    await delete(expenseTable, id);
  }
}
