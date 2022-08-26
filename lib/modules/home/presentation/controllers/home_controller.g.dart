// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$selectedItemAtom =
      Atom(name: '_HomeControllerBase.selectedItem', context: context);

  @override
  Observable<String> get selectedItem {
    _$selectedItemAtom.reportRead();
    return super.selectedItem;
  }

  @override
  set selectedItem(Observable<String> value) {
    _$selectedItemAtom.reportWrite(value, super.selectedItem, () {
      super.selectedItem = value;
    });
  }

  late final _$monthsListAtom =
      Atom(name: '_HomeControllerBase.monthsList', context: context);

  @override
  ObservableList<String> get monthsList {
    _$monthsListAtom.reportRead();
    return super.monthsList;
  }

  @override
  set monthsList(ObservableList<String> value) {
    _$monthsListAtom.reportWrite(value, super.monthsList, () {
      super.monthsList = value;
    });
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  dynamic changeSelectedItem(String value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changeSelectedItem');
    try {
      return super.changeSelectedItem(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedItem: ${selectedItem},
monthsList: ${monthsList}
    ''';
  }
}
