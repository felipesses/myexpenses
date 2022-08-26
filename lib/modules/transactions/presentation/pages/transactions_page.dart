import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myexpenses/modules/app/presentation/controllers/app_controller.dart';
import 'package:myexpenses/modules/home/presentation/controllers/home_controller.dart';
import 'package:myexpenses/modules/income/presentation/controllers/income_controller.dart';
import 'package:myexpenses/modules/savings/presentation/controllers/saving_controller.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/presentation/components/transaction_card/transaction_card.dart';
import 'package:myexpenses/modules/transactions/presentation/controllers/transactions_controller.dart';
import 'package:myexpenses/modules/transactions/presentation/pages/add_transactions_page.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class TransactionsPage extends StatefulWidget {
  final DateTime date;
  const TransactionsPage({
    super.key,
    required this.date,
  });

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage>
    with AutomaticKeepAliveClientMixin {
  final controller = Modular.get<TransactionsController>();
  final transactionsController = Modular.get<TransactionsController>();
  final homeController = Modular.get<HomeController>();
  final appController = Modular.get<AppController>();
  final incomeController = Modular.get<IncomeController>();
  final savingsController = Modular.get<SavingController>();

  updateControllers(DateTime dateTime) {
    transactionsController.getTransactionsbyMonth('1', dateTime);
    incomeController.getIncomebyMonth('1', dateTime);
    savingsController.getSavingsByMonth('1', dateTime);
  }

  late DateTime date;

  @override
  void initState() {
    super.initState();
    date = widget.date;
    controller.getTransactionsbyMonth('1', widget.date);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Gastos',
            style: TextStyle(
              fontFamily: 'San Francisco',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
          actions: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: () {
                  pushNewScreen(
                    context,
                    screen: AddTransactionsPage(date: date),
                  );
                },
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(primary.withOpacity(0.1)),
                ),
                icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: primary),
                  ),
                  child: Icon(
                    Icons.add,
                    color: primary,
                  ),
                ),
                label: Text(
                  'Adicionar gasto',
                  style: TextStyle(
                    fontFamily: 'San Francisco',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            child: Observer(builder: (_) {
              return Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.zero,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(color: Colors.transparent),
                      items: homeController.monthsList
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontFamily: 'San Francisco',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              onTap: () {
                                homeController.changeSelectedItem(e);
                                date = DateTime(
                                  DateTime.now().year,
                                  homeController.monthsList.indexOf(
                                        homeController.selectedItem.value,
                                      ) +
                                      1,
                                );

                                updateControllers(date);

                                appController.setMonthDropdown(
                                  date.millisecondsSinceEpoch,
                                );
                              },
                              value: e,
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        homeController.changeSelectedItem(value ?? '');
                      },
                      value: homeController.selectedItem.value.isEmpty
                          ? homeController.monthsList[widget.date.month - 1]
                          : homeController.selectedItem.value,
                    ),
                  ),
                ),
              );
            }),
            preferredSize: Size.fromHeight(
              65,
            ),
          ),
        ),
        body: Observer(builder: (_) {
          List<TransactionEntity>? list = controller.transactionList;

          if (list == null) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  primary,
                ),
              ),
            );
          }

          if (list.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/expense.svg',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Sem gastos por enquanto!',
                    style: TextStyle(
                      fontFamily: 'San Francisco',
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Adicione um gasto no botão acima',
                    style: TextStyle(
                      fontFamily: 'San Francisco',
                      color: primary,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 40,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: list
                    .map(
                      (e) => SizedBox(
                        child: TransactionCard(
                          transactionEntity: e,
                          date: date,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
