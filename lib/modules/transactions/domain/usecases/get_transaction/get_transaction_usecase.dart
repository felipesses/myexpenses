import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/domain/repositories/transactions_repository.dart';

abstract class IGetTransactionsByMonth {
  Future<List<TransactionEntity>> call(String id, DateTime date);
}

class GetTransactionsByMonth implements IGetTransactionsByMonth {
  final ITransactionsRepository repository;

  GetTransactionsByMonth(this.repository);

  @override
  Future<List<TransactionEntity>> call(String id, DateTime date) {
    return repository.getTransactionsByMonth(id, date);
  }
}
