import 'package:flutter/material.dart';

class AlertRequest {
  final String? title;
  final Widget? content;
  final String? buttonTitle;
  final void Function()? onConfirmPressed;
  final void Function()? onCancelPressed;
  AlertRequest({
    this.title,
    this.content,
    this.buttonTitle,
    this.onConfirmPressed,
    this.onCancelPressed,
  });
}
