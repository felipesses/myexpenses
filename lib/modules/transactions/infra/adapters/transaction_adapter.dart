import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';

class TransactionAdapter {
  static TransactionEntity fromJson(dynamic json) {
    return TransactionEntity(
      id: json['id'],
      name: json['name'],
      value: json['value'],
      category: json['category'],
      month: json['month'],
      year: json['year'],
      emojiTitle: json['emojiTitle'],
    );
  }

  static toJson(Map<String, dynamic> map) => {
        'name': map['name'],
        'value': map['value'],
        'month': map['month'],
        'year': map['year'],
        'category': map['category'],
        'emojiTitle': map['emojiTitle'],
      };
}
