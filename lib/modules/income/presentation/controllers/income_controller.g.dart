// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$IncomeController on _IncomeControllerBase, Store {
  late final _$incomeListAtom =
      Atom(name: '_IncomeControllerBase.incomeList', context: context);

  @override
  List<IncomeEntity>? get incomeList {
    _$incomeListAtom.reportRead();
    return super.incomeList;
  }

  @override
  set incomeList(List<IncomeEntity>? value) {
    _$incomeListAtom.reportWrite(value, super.incomeList, () {
      super.incomeList = value;
    });
  }

  late final _$incomeTotalAtom =
      Atom(name: '_IncomeControllerBase.incomeTotal', context: context);

  @override
  double get incomeTotal {
    _$incomeTotalAtom.reportRead();
    return super.incomeTotal;
  }

  @override
  set incomeTotal(double value) {
    _$incomeTotalAtom.reportWrite(value, super.incomeTotal, () {
      super.incomeTotal = value;
    });
  }

  late final _$createIncomeAsyncAction =
      AsyncAction('_IncomeControllerBase.createIncome', context: context);

  @override
  Future createIncome(IncomeEntity incomeEntity, DateTime date) {
    return _$createIncomeAsyncAction
        .run(() => super.createIncome(incomeEntity, date));
  }

  late final _$removeIncomeAsyncAction =
      AsyncAction('_IncomeControllerBase.removeIncome', context: context);

  @override
  Future removeIncome(IncomeEntity incomeEntity) {
    return _$removeIncomeAsyncAction
        .run(() => super.removeIncome(incomeEntity));
  }

  late final _$updateIncomeAsyncAction =
      AsyncAction('_IncomeControllerBase.updateIncome', context: context);

  @override
  Future updateIncome(IncomeEntity incomeEntity) {
    return _$updateIncomeAsyncAction
        .run(() => super.updateIncome(incomeEntity));
  }

  late final _$getIncomebyMonthAsyncAction =
      AsyncAction('_IncomeControllerBase.getIncomebyMonth', context: context);

  @override
  Future getIncomebyMonth(String id, DateTime date) {
    return _$getIncomebyMonthAsyncAction
        .run(() => super.getIncomebyMonth(id, date));
  }

  late final _$_IncomeControllerBaseActionController =
      ActionController(name: '_IncomeControllerBase', context: context);

  @override
  dynamic calculateAllTransactions() {
    final _$actionInfo = _$_IncomeControllerBaseActionController.startAction(
        name: '_IncomeControllerBase.calculateAllTransactions');
    try {
      return super.calculateAllTransactions();
    } finally {
      _$_IncomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
incomeList: ${incomeList},
incomeTotal: ${incomeTotal}
    ''';
  }
}
