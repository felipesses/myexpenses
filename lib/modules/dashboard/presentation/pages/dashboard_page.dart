import 'package:myexpenses/modules/app/presentation/controllers/app_controller.dart';
import 'package:myexpenses/modules/app/presentation/controllers/loading_controller.dart';
import 'package:myexpenses/modules/dashboard/presentation/models/total_model.dart';
import 'package:myexpenses/modules/home/presentation/controllers/home_controller.dart';
import 'package:myexpenses/modules/income/presentation/controllers/income_controller.dart';
import 'package:myexpenses/modules/savings/presentation/controllers/saving_controller.dart';
import 'package:myexpenses/modules/transactions/presentation/controllers/transactions_controller.dart';
import 'package:myexpenses/utils/format_number.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:myexpenses/modules/dashboard/presentation/components/total_income/total_income.dart';
import 'package:myexpenses/modules/dashboard/presentation/components/total_savings/total_savings.dart';
import 'package:myexpenses/modules/dashboard/presentation/components/total_transactions/total_transactions.dart';
import 'package:myexpenses/styles/colors.dart';

class DashboardPage extends StatefulWidget {
  final int monthValue;
  const DashboardPage({Key? key, this.monthValue = 0}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final appController = Modular.get<AppController>();
  final transactionsController = Modular.get<TransactionsController>();
  final homeController = Modular.get<HomeController>();
  final incomeController = Modular.get<IncomeController>();
  final savingsController = Modular.get<SavingController>();
  final loading = Modular.get<LoadingController>();

  updateControllers(DateTime dateTime) {
    transactionsController.getTransactionsbyMonth('1', dateTime);
    incomeController.getIncomebyMonth('1', dateTime);
    savingsController.getSavingsByMonth('1', dateTime);
  }

  double updateTotal() {
    return totalModel.calculateTotal(
      incomeTotal: incomeController.incomeTotal,
      transactionsTotal: transactionsController.transactionsTotal,
      savingsTotal: savingsController.savingsTotal,
    );
  }

  List<Color> colorList = [
    Color(0xFF4CAF50),
    Color(0xFFF44336),
    Color(0xFF0D47A1),
  ];

  late DateTime date;

  TotalModel totalModel = TotalModel.empty();

  @override
  void initState() {
    super.initState();
    date = DateTime.fromMillisecondsSinceEpoch(widget.monthValue);
    updateControllers(date);
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
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Dashboard',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Observer(
                      builder: (_) {
                        return Container(
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
                                ? homeController.monthsList[date.month - 1]
                                : homeController.selectedItem.value,
                          ),
                        );
                      },
                    ),
                    Observer(builder: (_) {
                      return Text(
                        'Saldo: ${formatNumber(updateTotal())}',
                        style: TextStyle(
                          fontFamily: 'San Francisco',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 30),
                Observer(builder: (_) {
                  if (loading.status.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    height: 230,
                    child: PieChart(
                      dataMap: {
                        'Renda no mês': incomeController.incomeTotal,
                        'Gastos': transactionsController.transactionsTotal,
                        'Economias': savingsController.savingsTotal,
                      },
                      legendOptions: LegendOptions(
                        legendPosition: LegendPosition.bottom,
                        showLegendsInRow: true,
                      ),
                      chartType: ChartType.ring,
                      formatChartValues: (value) {
                        return formatNumber(value);
                      },
                      animationDuration: const Duration(milliseconds: 1500),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValues: true,
                        showChartValuesOutside: true,
                        showChartValuesInPercentage: false,
                        showChartValueBackground: true,
                        decimalPlaces: 2,
                      ),
                      emptyColor: grey,
                      colorList: colorList,
                    ),
                  );
                }),
                SizedBox(height: 20),
                Observer(builder: (_) {
                  if (loading.status.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return TotalIncome(
                    total: incomeController.incomeTotal,
                  );
                }),
                SizedBox(height: 20),
                Observer(
                  builder: (_) {
                    if (loading.status.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return TotalTransactions(
                      total: transactionsController.transactionsTotal,
                    );
                  },
                ),
                SizedBox(height: 20),
                Observer(
                  builder: (_) {
                    if (loading.status.value) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return TotalSavings(
                      total: savingsController.savingsTotal,
                    );
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
