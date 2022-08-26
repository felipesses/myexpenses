import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';

abstract class ITransactionsRepository {
  Future<void> createTransaction(
      TransactionEntity transactionEntity, DateTime date);
  Future<List<TransactionEntity>> getTransactionsByMonth(
      String id, DateTime date);
  Future<void> updateTransaction(
      String id, TransactionEntity transactionEntity);
  Future<void> removeTransaction(
      String id, TransactionEntity transactionEntity);
}
