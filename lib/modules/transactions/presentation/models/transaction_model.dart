import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.docId,
    required super.name,
    required super.value,
    required super.category,
    required super.month,
    required super.year,
    required super.emojiTitle,
    required super.userId,
  });

  factory TransactionModel.empty() => TransactionModel(
        id: '',
        docId: '',
        userId: '',
        name: '',
        value: -1,
        category: -1,
        month: 0,
        year: 0,
        emojiTitle: '',
      );
}
