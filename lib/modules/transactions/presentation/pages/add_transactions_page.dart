import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';
import 'package:myexpenses/components/app_dialog/dialog_manager.dart';
import 'package:myexpenses/components/app_dialog/dialog_service.dart';
import 'package:myexpenses/components/app_input/app_input.dart';
import 'package:myexpenses/modules/transactions/presentation/components/category_item.dart/category_item.dart';
import 'package:myexpenses/modules/transactions/presentation/controllers/transactions_controller.dart';
import 'package:myexpenses/modules/transactions/presentation/models/transaction_model.dart';
import 'package:myexpenses/modules/transactions/presentation/pages/transactions_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../styles/colors.dart';

class AddTransactionsPage extends StatefulWidget {
  final DateTime date;
  const AddTransactionsPage({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<AddTransactionsPage> createState() => _AddTransactionsPageState();
}

class _AddTransactionsPageState extends State<AddTransactionsPage> {
  final formKey = GlobalKey<FormState>();
  final controller = Modular.get<TransactionsController>();
  TransactionModel transactionModel = TransactionModel.empty();
  final _dialogService = MyExpensesDialogService();
  final formatter = CurrencyTextInputFormatter(
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
                'Adicionar gasto',
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
                      height: 500,
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
                                            transactionModel.name = name ?? '';
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
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[.,0-9]'),
                                            ),
                                            formatter,
                                          ],
                                          onSaved: (value) {
                                            transactionModel.value = formatter
                                                .getUnformattedValue()
                                                .toDouble();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 40),
                                  Text(
                                    'Selecione a categoria',
                                    style: TextStyle(
                                      fontFamily: 'San Francisco',
                                      color: grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GroupButton<CategoryItem>(
                            isRadio: true,
                            enableDeselect: true,
                            maxSelected: 1,
                            options: GroupButtonOptions(
                              mainGroupAlignment: MainGroupAlignment.center,
                              groupingType: GroupingType.wrap,
                              textPadding: EdgeInsets.zero,
                            ),
                            buttons: [
                              CategoryItem(
                                icon: Center(
                                    child: Icon(Icons.credit_card, size: 38)),
                                title: 'Cartões',
                                emojiTitle: '💳 Cartões',
                              ),
                              CategoryItem(
                                icon: SvgPicture.asset(
                                  'assets/icons/expense.svg',
                                  height: 38,
                                  fit: BoxFit.cover,
                                ),
                                title: 'Despesas',
                                emojiTitle: '🧾 Despesas',
                              ),
                              CategoryItem(
                                icon: Icon(Icons.school, size: 38),
                                title: 'Estudos',
                                emojiTitle: '📚 Estudos',
                              ),
                              CategoryItem(
                                icon: SvgPicture.asset(
                                  'assets/icons/installment.svg',
                                  height: 38,
                                  fit: BoxFit.cover,
                                ),
                                title: 'Parcelas',
                                emojiTitle: '💸 Parcelas',
                              ),
                              CategoryItem(
                                icon: Icon(Icons.restaurant, size: 38),
                                title: 'Alimentos',
                                emojiTitle: '🍔 Alimentos',
                              ),
                              CategoryItem(
                                icon: Icon(Icons.star_border, size: 38),
                                title: 'Entretenimento',
                                emojiTitle: '⭐ Entretenimento',
                              ),
                              CategoryItem(
                                icon: Icon(Icons.medical_information, size: 38),
                                title: 'Medicamentos',
                                emojiTitle: '🏥 Medicamentos',
                              ),
                              CategoryItem(
                                icon: Icon(Icons.dashboard, size: 38),
                                title: 'Outros',
                                emojiTitle: '💬 Outros',
                              ),
                            ],
                            onSelected: (value, index, isSelected) {
                              setState(() {
                                transactionModel.emojiTitle =
                                    value.emojiTitle ?? '';
                                transactionModel.category =
                                    !isSelected ? -1 : index;
                              });
                            },
                            buttonBuilder: (selected, value, context) {
                              return CategoryItem(
                                icon: value.icon,
                                title: value.title,
                                backgroundColor:
                                    selected ? Colors.orange[200] : white,
                              );
                            },
                          ),
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

                  if (transactionModel.name.isEmpty ||
                      transactionModel.category == -1 ||
                      transactionModel.value == -1) {
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
                          .createTransaction(transactionModel, widget.date)
                          .then((value) => {
                                controller.getTransactionsbyMonth(
                                  '1',
                                  widget.date,
                                ),
                              });
                    } finally {
                      controller.loading.out();
                      pushNewScreen(
                        context,
                        screen: TransactionsPage(
                          date: widget.date,
                        ),
                      );
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
