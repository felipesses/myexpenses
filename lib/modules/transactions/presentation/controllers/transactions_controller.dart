import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myexpenses/modules/app/auth/presentation/controllers/auth_controller.dart';
import 'package:myexpenses/modules/app/presentation/controllers/loading_controller.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/domain/usecases/add_transaction/add_transaction_usecase.dart';
import 'package:myexpenses/modules/transactions/domain/usecases/get_transaction/get_transaction_usecase.dart';
import 'package:myexpenses/modules/transactions/domain/usecases/remove_transaction/remove_transaction_usecase.dart';
import 'package:myexpenses/modules/transactions/domain/usecases/update_transaction/update_transaction_usecase.dart';
part 'transactions_controller.g.dart';

class TransactionsController = _TransactionsControllerBase
    with _$TransactionsController;

abstract class _TransactionsControllerBase with Store {
  final _createTransactionUsecase = Modular.get<CreateTransaction>();
  final _updateTransactionUsecase = Modular.get<UpdateTransaction>();
  final _getTransactionsUsecase = Modular.get<GetTransactionsByMonth>();
  final _removeTransactionUsecase = Modular.get<RemoveTransaction>();
  final loading = Modular.get<LoadingController>();
  final _authController = Modular.get<AuthController>();

  @observable
  List<TransactionEntity>? transactionList;

  @observable
  double transactionsTotal = 0.0;

  @action
  createTransaction(TransactionEntity transactionEntity, DateTime date) async {
    await _createTransactionUsecase(transactionEntity, date);
  }

  @action
  removeTransaction(TransactionEntity transactionEntity) async {
    await _removeTransactionUsecase('', transactionEntity);
  }

  @action
  updateTransaction(TransactionEntity transactionEntity) async {
    await _updateTransactionUsecase('', transactionEntity);
  }

  @action
  getTransactionsbyMonth(
    String id,
    DateTime date,
  ) async {
    var userId = '';

    if (kIsWeb) userId = _authController.getUser();

    transactionList = await _getTransactionsUsecase(userId, date);
    calculateAllTransactions();
  }

  @action
  calculateAllTransactions() {
    try {
      loading.on();
      if (transactionList != null) {
        transactionsTotal = transactionList!
            .map((e) => e.value)
            .fold(0, (previousValue, element) => previousValue + element);
      }
    } finally {
      loading.out();
    }
  }
}
