import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  Observable<String> selectedItem = Observable<String>('');

  @observable
  ObservableList<String> monthsList = ObservableList<String>.of([
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
  ]);

  @action
  changeSelectedItem(String value) {
    selectedItem.value = value;
  }
}
