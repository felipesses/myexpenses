import 'package:flutter/material.dart';
import 'package:myexpenses/components/app_dialog/alert_request.dart';
import 'package:myexpenses/components/app_dialog/dialog_service.dart';
import 'package:myexpenses/styles/colors.dart';

class DialogManager extends StatefulWidget {
  final Widget? child;

  const DialogManager({Key? key, this.child}) : super(key: key);

  @override
  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  MyExpensesDialogService dialogService = MyExpensesDialogService();
  @override
  void initState() {
    super.initState();
    dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }

  _showDialog(AlertRequest request) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              request.title ?? 'Sem título',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            content: request.content ??
                Text(
                  'Conteúdo',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primary),
                ),
                child: Text(
                  request.buttonTitle ?? 'Ok',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: request.onConfirmPressed,
              ),
            ],
          );
        });
  }
}
