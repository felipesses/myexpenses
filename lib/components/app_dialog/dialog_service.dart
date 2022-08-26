import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myexpenses/components/app_dialog/alert_request.dart';

class MyExpensesDialogService {
  MyExpensesDialogService._privateConstructor();

  static final MyExpensesDialogService _instance =
      MyExpensesDialogService._privateConstructor();

  factory MyExpensesDialogService() {
    return _instance;
  }

  Function(AlertRequest)? _showDialogListener;
  Completer? _dialogCompleter;

  void registerDialogListener(Function(AlertRequest)? showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future? showDialog({
    String? title,
    Widget? content,
    String? buttonTitle,
    void Function()? onConfirmPressed,
    void Function()? onCancelPressed,
  }) {
    _dialogCompleter = Completer();
    _showDialogListener!(AlertRequest(
      title: title,
      content: content,
      buttonTitle: buttonTitle,
      onConfirmPressed: onConfirmPressed,
      onCancelPressed: onCancelPressed,
    ));
    return _dialogCompleter?.future;
  }

  void dialogComplete() {
    _dialogCompleter?.complete();
    _dialogCompleter = null;
  }
}
