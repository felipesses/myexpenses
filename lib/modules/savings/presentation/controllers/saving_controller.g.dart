// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SavingController on _SavingControllerBase, Store {
  late final _$savingListAtom =
      Atom(name: '_SavingControllerBase.savingList', context: context);

  @override
  List<SavingEntity>? get savingList {
    _$savingListAtom.reportRead();
    return super.savingList;
  }

  @override
  set savingList(List<SavingEntity>? value) {
    _$savingListAtom.reportWrite(value, super.savingList, () {
      super.savingList = value;
    });
  }

  late final _$savingsTotalAtom =
      Atom(name: '_SavingControllerBase.savingsTotal', context: context);

  @override
  double get savingsTotal {
    _$savingsTotalAtom.reportRead();
    return super.savingsTotal;
  }

  @override
  set savingsTotal(double value) {
    _$savingsTotalAtom.reportWrite(value, super.savingsTotal, () {
      super.savingsTotal = value;
    });
  }

  late final _$createSavingAsyncAction =
      AsyncAction('_SavingControllerBase.createSaving', context: context);

  @override
  Future createSaving(SavingEntity savingEntity, DateTime date) {
    return _$createSavingAsyncAction
        .run(() => super.createSaving(savingEntity, date));
  }

  late final _$removeSavingAsyncAction =
      AsyncAction('_SavingControllerBase.removeSaving', context: context);

  @override
  Future removeSaving(SavingEntity savingEntity) {
    return _$removeSavingAsyncAction
        .run(() => super.removeSaving(savingEntity));
  }

  late final _$updateSavingAsyncAction =
      AsyncAction('_SavingControllerBase.updateSaving', context: context);

  @override
  Future updateSaving(SavingEntity savingEntity) {
    return _$updateSavingAsyncAction
        .run(() => super.updateSaving(savingEntity));
  }

  late final _$getSavingsByMonthAsyncAction =
      AsyncAction('_SavingControllerBase.getSavingsByMonth', context: context);

  @override
  Future getSavingsByMonth(String id, DateTime date) {
    return _$getSavingsByMonthAsyncAction
        .run(() => super.getSavingsByMonth(id, date));
  }

  late final _$_SavingControllerBaseActionController =
      ActionController(name: '_SavingControllerBase', context: context);

  @override
  dynamic calculateAllSavings() {
    final _$actionInfo = _$_SavingControllerBaseActionController.startAction(
        name: '_SavingControllerBase.calculateAllSavings');
    try {
      return super.calculateAllSavings();
    } finally {
      _$_SavingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
savingList: ${savingList},
savingsTotal: ${savingsTotal}
    ''';
  }
}
