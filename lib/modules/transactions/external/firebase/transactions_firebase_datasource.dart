import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/infra/adapters/transaction_adapter.dart';
import 'package:myexpenses/modules/transactions/infra/datasource/transactions_datasource.dart';
import 'package:uuid/uuid.dart';

class TransactionsFirebaseDatasource implements ITransactionsDatasource {
  @override
  Future<void> createTransaction(
      TransactionEntity transactionEntity, DateTime date) async {
    final firestore = FirebaseFirestore.instance;
    var uuid = Uuid();

    await firestore.collection('transactions').add(
          TransactionAdapter.toJson(
            {
              'id': uuid.v4(),
              'userId': transactionEntity.userId,
              'name': transactionEntity.name,
              'value': transactionEntity.value,
              'category': transactionEntity.category,
              'month': date.month,
              'year': date.year,
              'emojiTitle': transactionEntity.emojiTitle,
            },
          ),
        );
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByMonth(
      String id, DateTime date) async {
    final firestore = FirebaseFirestore.instance;

    final List<TransactionEntity> transactionList = [];

    try {
      final data = await firestore
          .collection('transactions')
          .where('userId', isEqualTo: id)
          .where('month', isEqualTo: date.month)
          .where('year', isEqualTo: date.year)
          .get();

      for (var transaction in data.docs) {
        transactionList.add(TransactionAdapter.fromJson(transaction));
      }

      return transactionList;
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> removeTransaction(
      String id, TransactionEntity transactionEntity) async {
    final firestore = FirebaseFirestore.instance;

    try {
      return await firestore
          .collection('transactions')
          .doc(transactionEntity.id)
          .delete();
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> updateTransaction(
      String id, TransactionEntity transactionEntity) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('transactions').doc(transactionEntity.id).update(
          TransactionAdapter.toJson(
            {
              'name': transactionEntity.name,
              'value': transactionEntity.value,
              'category': transactionEntity.category,
              'month': transactionEntity.month,
              'year': transactionEntity.year,
              'emojiTitle': transactionEntity.emojiTitle,
            },
          ),
        );
  }
}
