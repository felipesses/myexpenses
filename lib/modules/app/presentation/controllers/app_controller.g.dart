// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppController on _AppControllerBase, Store {
  late final _$monthNowAtom =
      Atom(name: '_AppControllerBase.monthNow', context: context);

  @override
  Observable<int> get monthNow {
    _$monthNowAtom.reportRead();
    return super.monthNow;
  }

  @override
  set monthNow(Observable<int> value) {
    _$monthNowAtom.reportWrite(value, super.monthNow, () {
      super.monthNow = value;
    });
  }

  late final _$setMonthAsyncAction =
      AsyncAction('_AppControllerBase.setMonth', context: context);

  @override
  Future setMonth({int monthValue = 0}) {
    return _$setMonthAsyncAction
        .run(() => super.setMonth(monthValue: monthValue));
  }

  late final _$setMonthDropdownAsyncAction =
      AsyncAction('_AppControllerBase.setMonthDropdown', context: context);

  @override
  Future setMonthDropdown(int monthValue) {
    return _$setMonthDropdownAsyncAction
        .run(() => super.setMonthDropdown(monthValue));
  }

  @override
  String toString() {
    return '''
monthNow: ${monthNow}
    ''';
  }
}
