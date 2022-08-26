import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/domain/repositories/transactions_repository.dart';
import 'package:myexpenses/modules/transactions/infra/datasource/transactions_datasource.dart';

class TransactionsRepository implements ITransactionsRepository {
  final ITransactionsDatasource datasource;

  TransactionsRepository(this.datasource);

  @override
  Future<void> createTransaction(
      TransactionEntity transactionEntity, DateTime date) async {
    return datasource.createTransaction(transactionEntity, date);
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByMonth(
      String id, DateTime date) async {
    final list = await datasource.getTransactionsByMonth(id, date);
    return list;
  }

  @override
  Future<void> removeTransaction(
      String id, TransactionEntity transactionEntity) async {
    return datasource.removeTransaction(id, transactionEntity);
  }

  @override
  Future<void> updateTransaction(
      String id, TransactionEntity transactionEntity) async {
    return datasource.updateTransaction(id, transactionEntity);
  }
}
