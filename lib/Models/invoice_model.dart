import 'package:crafted_manager/Models/order_model.dart';
import 'package:crafted_manager/Models/ordered_item_model.dart';

class Invoice {
  final int id;
  final Order order;
  final DateTime invoiceDate;
  final DateTime dueDate;
  final String status;
  final List<OrderedItem> orderedItems;

  Invoice({
    required this.id,
    required this.order,
    required this.invoiceDate,
    required this.dueDate,
    required this.status,
    required this.orderedItems,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    List<OrderedItem> orderedItems = [];
    if (json['ordered_items'] != null) {
      orderedItems = List.from(json['ordered_items'])
          .map((item) => OrderedItem.fromJson(item))
          .toList();
    }
    return Invoice(
      id: json['id'],
      order: Order.fromJson(json['order']),
      invoiceDate: DateTime.parse(json['invoice_date']),
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'],
      orderedItems: orderedItems,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'order': order.toJson(),
        'invoice_date': invoiceDate.toIso8601String(),
        'due_date': dueDate.toIso8601String(),
        'status': status,
        'ordered_items': orderedItems.map((item) => item.toJson()).toList()
      };
}
