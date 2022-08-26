import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/domain/repositories/transactions_repository.dart';

abstract class IUpdateTransaction {
  Future<void> call(String id, TransactionEntity transactionEntity);
}

class UpdateTransaction implements IUpdateTransaction {
  final ITransactionsRepository repository;

  UpdateTransaction(this.repository);

  @override
  Future<void> call(String id, TransactionEntity transactionEntity) {
    return repository.updateTransaction(id, transactionEntity);
  }
}
