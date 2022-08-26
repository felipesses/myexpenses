// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TransactionsController on _TransactionsControllerBase, Store {
  late final _$transactionListAtom = Atom(
      name: '_TransactionsControllerBase.transactionList', context: context);

  @override
  List<TransactionEntity>? get transactionList {
    _$transactionListAtom.reportRead();
    return super.transactionList;
  }

  @override
  set transactionList(List<TransactionEntity>? value) {
    _$transactionListAtom.reportWrite(value, super.transactionList, () {
      super.transactionList = value;
    });
  }

  late final _$transactionsTotalAtom = Atom(
      name: '_TransactionsControllerBase.transactionsTotal', context: context);

  @override
  double get transactionsTotal {
    _$transactionsTotalAtom.reportRead();
    return super.transactionsTotal;
  }

  @override
  set transactionsTotal(double value) {
    _$transactionsTotalAtom.reportWrite(value, super.transactionsTotal, () {
      super.transactionsTotal = value;
    });
  }

  late final _$createTransactionAsyncAction = AsyncAction(
      '_TransactionsControllerBase.createTransaction',
      context: context);

  @override
  Future createTransaction(TransactionEntity transactionEntity, DateTime date) {
    return _$createTransactionAsyncAction
        .run(() => super.createTransaction(transactionEntity, date));
  }

  late final _$removeTransactionAsyncAction = AsyncAction(
      '_TransactionsControllerBase.removeTransaction',
      context: context);

  @override
  Future removeTransaction(TransactionEntity transactionEntity) {
    return _$removeTransactionAsyncAction
        .run(() => super.removeTransaction(transactionEntity));
  }

  late final _$updateTransactionAsyncAction = AsyncAction(
      '_TransactionsControllerBase.updateTransaction',
      context: context);

  @override
  Future updateTransaction(TransactionEntity transactionEntity) {
    return _$updateTransactionAsyncAction
        .run(() => super.updateTransaction(transactionEntity));
  }

  late final _$getTransactionsbyMonthAsyncAction = AsyncAction(
      '_TransactionsControllerBase.getTransactionsbyMonth',
      context: context);

  @override
  Future getTransactionsbyMonth(String id, DateTime date) {
    return _$getTransactionsbyMonthAsyncAction
        .run(() => super.getTransactionsbyMonth(id, date));
  }

  late final _$_TransactionsControllerBaseActionController =
      ActionController(name: '_TransactionsControllerBase', context: context);

  @override
  dynamic calculateAllTransactions() {
    final _$actionInfo =
        _$_TransactionsControllerBaseActionController.startAction(
            name: '_TransactionsControllerBase.calculateAllTransactions');
    try {
      return super.calculateAllTransactions();
    } finally {
      _$_TransactionsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
transactionList: ${transactionList},
transactionsTotal: ${transactionsTotal}
    ''';
  }
}
