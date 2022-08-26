import 'package:myexpenses/core/db/connection.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/infra/adapters/transaction_adapter.dart';
import 'package:myexpenses/modules/transactions/infra/datasource/transactions_datasource.dart';

class TransactionsDbDatasource implements ITransactionsDatasource {
  @override
  Future<void> createTransaction(
      TransactionEntity transactionEntity, DateTime date) async {
    final db = await DB.instance.database;

    await db.insert(
      'transactions',
      TransactionAdapter.toJson(
        {
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
    final db = await DB.instance.database;
    final List<TransactionEntity> transactionList = [];

    final result = await db.rawQuery(
        'SELECT * FROM transactions WHERE month = ${date.month} AND year = ${date.year}');

    for (var transaction in result) {
      transactionList.add(TransactionAdapter.fromJson(transaction));
    }

    return transactionList;
  }

  @override
  Future<void> removeTransaction(
      String id, TransactionEntity transactionEntity) async {
    final db = await DB.instance.database;
    await db.delete('transactions', where: 'id = ${transactionEntity.id}');
  }

  @override
  Future<void> updateTransaction(
      String id, TransactionEntity transactionEntity) async {
    final db = await DB.instance.database;

    await db.update(
      'transactions',
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
      where: 'id = ${transactionEntity.id}',
    );
  }
}
