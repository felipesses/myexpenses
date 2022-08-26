import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/domain/repositories/transactions_repository.dart';

abstract class IRemoveTransaction {
  Future<void> call(String id, TransactionEntity transactionEntity);
}

class RemoveTransaction implements IRemoveTransaction {
  final ITransactionsRepository repository;

  RemoveTransaction(this.repository);

  @override
  Future<void> call(String id, TransactionEntity transactionEntity) {
    return repository.removeTransaction(id, transactionEntity);
  }
}
