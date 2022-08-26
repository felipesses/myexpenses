import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myexpenses/components/app_dialog/dialog_manager.dart';
import 'package:myexpenses/components/app_dialog/dialog_service.dart';
import 'package:myexpenses/components/app_input/app_input.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/presentation/controllers/income_controller.dart';
import 'package:myexpenses/modules/income/presentation/pages/income_page.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class UpdateIncomePage extends StatefulWidget {
  final IncomeEntity incomeEntity;
  final DateTime date;
  const UpdateIncomePage({
    Key? key,
    required this.incomeEntity,
    required this.date,
  }) : super(key: key);

  @override
  State<UpdateIncomePage> createState() => _UpdateIncomePageState();
}

class _UpdateIncomePageState extends State<UpdateIncomePage> {
  final controller = Modular.get<IncomeController>();

  final _dialogService = MyExpensesDialogService();
  final formKey = GlobalKey<FormState>();
  TextEditingController incomeNameController = TextEditingController();
  TextEditingController incomeValueController = TextEditingController();
  final formatter = CurrencyTextInputFormatter(
    decimalDigits: 2,
    locale: 'pt_BR',
    symbol: 'R\$',
  );

  @override
  void initState() {
    incomeNameController.text = widget.incomeEntity.name;
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
                'Editar renda',
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
                      height: 220,
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
                                          controller: incomeNameController,
                                          onSaved: (name) {
                                            widget.incomeEntity.name =
                                                name ?? '';
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
                                        'Valor',
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
                                          initialValue: formatter
                                              .format(
                                                widget.incomeEntity.value
                                                    .toStringAsFixed(2),
                                              )
                                              .padRight(4),
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[.,0-9]'),
                                            ),
                                            formatter,
                                          ],
                                          onSaved: (value) {
                                            double newValue = formatter
                                                .getUnformattedValue()
                                                .toDouble();

                                            widget.incomeEntity.value =
                                                newValue;
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

                  if (widget.incomeEntity.name.isEmpty ||
                      widget.incomeEntity.value == -1) {
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
                          .updateIncome(widget.incomeEntity)
                          .then((value) => {
                                controller.getIncomebyMonth(
                                  '1',
                                  widget.date,
                                ),
                              });
                    } finally {
                      controller.loading.out();
                      pushNewScreen(
                        context,
                        screen: IncomePage(
                          date: widget.date,
                        ),
                      );
                    }
                  }
                }
              },
              backgroundColor: primary,
              child: Icon(
                Icons.edit_note_sharp,
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
