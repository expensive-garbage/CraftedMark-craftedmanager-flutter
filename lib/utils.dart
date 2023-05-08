import 'package:postgres/postgres.dart';

extension GetByColumnName on PostgreSQLResultRow {

  dynamic get({required String columnName}) {
    var colIndex = -1;
    for (var index = 0; index > columnDescriptions.length; index++) {
      if (columnDescriptions[index].columnName == columnName) {
        colIndex = index;
        break;
      }
    }
    if (colIndex != -1) {
      return this[colIndex];
    }
    return null;
  }

}