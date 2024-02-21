import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myexpenses/components/app_dialog/dialog_manager.dart';
import 'package:myexpenses/components/app_dialog/dialog_service.dart';
import 'package:myexpenses/components/app_input/app_input.dart';
import 'package:myexpenses/modules/app/auth/presentation/controllers/auth_controller.dart';
import 'package:myexpenses/modules/savings/presentation/controllers/saving_controller.dart';
import 'package:myexpenses/modules/savings/presentation/models/saving_model.dart';
import 'package:myexpenses/modules/savings/presentation/pages/savings_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../styles/colors.dart';

class AddSavingsPage extends StatefulWidget {
  final DateTime date;
  const AddSavingsPage({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<AddSavingsPage> createState() => _AddSavingsPageState();
}

class _AddSavingsPageState extends State<AddSavingsPage> {
  final formKey = GlobalKey<FormState>();
  final controller = Modular.get<SavingController>();
  final authController = Modular.get<AuthController>();
  SavingModel savingModel = SavingModel.empty();
  final _dialogService = MyExpensesDialogService();
  final valueFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  final amountFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  final objectiveFormatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DialogManager(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
              title: Text(
                'Adicionar economia',
                style: TextStyle(
                  fontFamily: 'San Francisco',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: black,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: grey,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Descrição',
                                        style: TextStyle(
                                          fontFamily: 'San Francisco',
                                          color: grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 180,
                                        child: AppInput(
                                          onSaved: (name) {
                                            savingModel.name = name ?? '';
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Economia do mês',
                                        style: TextStyle(
                                          fontFamily: 'San Francisco',
                                          color: grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 180,
                                        child: AppInput(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[.,0-9]'),
                                            ),
                                            valueFormatter,
                                          ],
                                          onSaved: (value) {
                                            savingModel.value = valueFormatter
                                                .getUnformattedValue()
                                                .toDouble();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total guardado',
                                        style: TextStyle(
                                          fontFamily: 'San Francisco',
                                          color: grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 180,
                                        child: AppInput(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[.,0-9]'),
                                            ),
                                            amountFormatter,
                                          ],
                                          onSaved: (value) {
                                            savingModel.currentAmount =
                                                amountFormatter
                                                    .getUnformattedValue()
                                                    .toDouble();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Objetivo',
                                        style: TextStyle(
                                          fontFamily: 'San Francisco',
                                          color: grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 180,
                                        child: AppInput(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[.,0-9]'),
                                            ),
                                            objectiveFormatter,
                                          ],
                                          onSaved: (value) {
                                            savingModel.objective =
                                                objectiveFormatter
                                                    .getUnformattedValue()
                                                    .toDouble();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  if (kIsWeb) savingModel.userId = authController.getUser();

                  if (savingModel.name.isEmpty ||
                      savingModel.value == -1 ||
                      savingModel.currentAmount == -1 ||
                      savingModel.objective == -1) {
                    _dialogService.showDialog(
                      title: 'Erro!',
                      content: Text(
                        'Preencha todos os dados',
                      ),
                      onConfirmPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    );
                  } else {
                    try {
                      controller.loading.on();
                      await controller
                          .createSaving(savingModel, widget.date)
                          .then(
                            (value) => {
                              controller.getSavingsByMonth(
                                '1',
                                widget.date,
                              ),
                            },
                          );
                    } finally {
                      controller.loading.out();
                      pushNewScreen(context,
                          screen: SavingsPage(
                            date: widget.date,
                          ));
                    }
                  }
                }
              },
              backgroundColor: primary,
              child: Icon(
                Icons.check,
                color: white,
              ),
            ),
          ),
          Observer(
            builder: (_) {
              return Visibility(
                visible: controller.loading.status.value,
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.7),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
