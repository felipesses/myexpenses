import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myexpenses/modules/app/presentation/controllers/app_controller.dart';
import 'package:myexpenses/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'package:myexpenses/modules/home/presentation/controllers/home_controller.dart';
import 'package:myexpenses/modules/income/presentation/pages/income_page.dart';
import 'package:myexpenses/modules/savings/presentation/pages/savings_page.dart';
import 'package:myexpenses/modules/transactions/presentation/pages/transactions_page.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomePage extends StatefulWidget {
  final int monthValue;
  const HomePage({Key? key, this.monthValue = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  final appController = Modular.get<AppController>();

  late PersistentTabController tabController;

  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    tabController = PersistentTabController(initialIndex: 0);

    tabs = [
      DashboardPage(
        monthValue: widget.monthValue,
      ),
      IncomePage(
        date: DateTime.fromMillisecondsSinceEpoch(widget.monthValue),
      ),
      TransactionsPage(
        date: DateTime.fromMillisecondsSinceEpoch(widget.monthValue),
      ),
      SavingsPage(
        date: DateTime.fromMillisecondsSinceEpoch(widget.monthValue),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/icons/dashboard.png',
        ),
        title: ("Dashboard"),
        textStyle: TextStyle(
          fontFamily: 'San Francisco',
          fontWeight: FontWeight.bold,
          color: primary,
        ),
        activeColorPrimary: primary,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/icons/income.png',
        ),
        title: ("Renda"),
        textStyle: TextStyle(
          fontFamily: 'San Francisco',
          fontWeight: FontWeight.bold,
          color: primary,
        ),
        activeColorPrimary: primary,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/expense.svg',
        ),
        title: ("Gastos"),
        textStyle: TextStyle(
          fontFamily: 'San Francisco',
          fontWeight: FontWeight.bold,
          color: grey,
        ),
        activeColorPrimary: primary,
        inactiveColorPrimary: grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/icons/saving.png',
        ),
        title: ("Economias"),
        textStyle: TextStyle(
          fontFamily: 'San Francisco',
          fontWeight: FontWeight.bold,
          color: grey,
        ),
        activeColorPrimary: primary,
        inactiveColorPrimary: grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: tabController,
      screens: tabs,
      items: _navBarsItems(),
      confineInSafeArea: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      navBarStyle: NavBarStyle.style6,
      padding: NavBarPadding.all(8),
      decoration: NavBarDecoration(
        border: Border.all(
          color: grey,
          width: 0.3,
        ),
      ),
    );
  }
}
