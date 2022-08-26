import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/domain/repositories/transactions_repository.dart';

abstract class ICreateTransaction {
  Future<void> call(TransactionEntity transactionEntity, DateTime date);
}

class CreateTransaction implements ICreateTransaction {
  final ITransactionsRepository repository;

  CreateTransaction(this.repository);

  @override
  Future<void> call(TransactionEntity transactionEntity, DateTime date) {
    return repository.createTransaction(transactionEntity, date);
  }
}
