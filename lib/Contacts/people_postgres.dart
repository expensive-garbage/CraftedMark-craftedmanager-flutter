import 'package:crafted_manager/Models/people_model.dart';
import 'package:crafted_manager/Orders/database_functions.dart';

class PeoplePostgres {
  // Fetch a customer by customerId
  static Future<People?> fetchCustomer(int customerId) async {
    final connection = await connectToPostgres();
    final result = await connection.query(
        'SELECT * FROM people WHERE id = @customerId',
        substitutionValues: {'customerId': customerId});

    await connection.close();
    return result.isNotEmpty
        ? People.fromMap(result.first.toColumnMap())
        : null;
  }
}
