import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';

class SavingAdapter {
  static SavingEntity fromJson(dynamic json) {
    return SavingEntity(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      objective: json['objective'],
      month: json['month'],
      year: json['year'],
      currentAmount: json['currentAmount'],
    );
  }

  static toJson(Map<String, dynamic> map) => {
        'name': map['name'],
        'value': map['value'],
        'month': map['month'],
        'year': map['year'],
        'objective': map['objective'],
        'currentAmount': map['currentAmount'],
      };
}
