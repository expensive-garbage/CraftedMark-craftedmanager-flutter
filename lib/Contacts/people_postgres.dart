import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Orders/database_functions.dart';

class PeoplePostgres {
  // Fetch a customer by customerId
  static Future<People?> fetchCustomer(String customerId) async {
    final connection = await connectToPostgres();
    final result = await connection.query(
        'SELECT * FROM people WHERE id = @customerId',
        substitutionValues: {'customerId': customerId});

    await connection.close();
    return result.isNotEmpty
        ? People.fromMap(result.first.toColumnMap())
        : null;
  }
  static Future<void> updateCustomer(People customer) async {
    final connection = await connectToPostgres();
    final map = customer.toMap();
    final values = <String>[];
    map.forEach((key, value) {
      if (key != "created_by" && key != "updated_by") {
        values.add("$key = '$value'");
      }
    });
    final allValues = values.join(",\n");
    await connection.execute(
      "UPDATE people SET $allValues WHERE id = @customerId",
      substitutionValues: {'customerId': customer.id}
    );
    await connection.close();
  }
}
