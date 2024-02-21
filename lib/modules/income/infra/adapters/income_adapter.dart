import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';

class IncomeAdapter {
  static IncomeEntity fromJson(dynamic json) {
    return IncomeEntity(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      value: json['value'],
      month: json['month'],
      year: json['year'],
    );
  }

  static toJson(Map<String, dynamic> map) => {
        'id': map['id'],
        'userId': map['userId'],
        'name': map['name'],
        'value': map['value'],
        'month': map['month'],
        'year': map['year'],
      };
}
