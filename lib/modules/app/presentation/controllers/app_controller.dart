import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myexpenses/modules/home/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  @observable
  Observable<int> monthNow = Observable<int>(0);

  List<String> monthsList = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];

  @action
  setMonth({int monthValue = 0}) async {
    final prefs = await SharedPreferences.getInstance();

    final firstAccess = prefs.getBool('firstAccess');

    if (firstAccess == null) {
      prefs.setBool('firstAccess', false);
      prefs.setInt('month', DateTime.now().millisecondsSinceEpoch);
      Modular.to.navigate(
        '/home',
        arguments: DateTime.now().millisecondsSinceEpoch,
      );
    } else {
      final now = prefs.getInt('month');
      monthNow.value = now!;
      Modular.to.navigate('/home', arguments: monthNow.value);
    }
  }

  @action
  setMonthDropdown(int monthValue) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('month', monthValue);
  }
}
