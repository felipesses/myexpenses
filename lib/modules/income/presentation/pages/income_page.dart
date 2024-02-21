import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myexpenses/modules/app/auth/presentation/controllers/auth_controller.dart';
import 'package:myexpenses/modules/app/presentation/controllers/app_controller.dart';
import 'package:myexpenses/modules/home/presentation/controllers/home_controller.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/presentation/components/income_card/income_card.dart';
import 'package:myexpenses/modules/income/presentation/controllers/income_controller.dart';
import 'package:myexpenses/modules/income/presentation/pages/add_income_page.dart';
import 'package:myexpenses/modules/savings/presentation/controllers/saving_controller.dart';
import 'package:myexpenses/modules/transactions/presentation/controllers/transactions_controller.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class IncomePage extends StatefulWidget {
  final DateTime date;
  const IncomePage({
    super.key,
    required this.date,
  });

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final controller = Modular.get<IncomeController>();
  final appController = Modular.get<AppController>();
  final authController = Modular.get<AuthController>();
  final transactionsController = Modular.get<TransactionsController>();
  final homeController = Modular.get<HomeController>();
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
    controller.getIncomebyMonth('1', widget.date);
  }

  @override
  Widget build(BuildContext context) {
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
            'Renda',
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
                    screen: AddIncomePage(date: date),
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
                  'Adicionar renda',
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
          List<IncomeEntity>? list = controller.incomeList;

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
                  Image.asset(
                    'assets/icons/income.png',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Sem rendas por enquanto!',
                    style: TextStyle(
                      fontFamily: 'San Francisco',
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Adicione uma renda no botão acima',
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
                        child: IncomeCard(
                          incomeEntity: e,
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
}
