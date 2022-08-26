import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myexpenses/modules/app/presentation/controllers/loading_controller.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/domain/usecases/add_income/add_income_usecase.dart';
import 'package:myexpenses/modules/income/domain/usecases/get_income/get_income_usecase.dart';
import 'package:myexpenses/modules/income/domain/usecases/remove_income/remove_income_usecase.dart';
import 'package:myexpenses/modules/income/domain/usecases/update_income/update_income_usecase.dart';
part 'income_controller.g.dart';

class IncomeController = _IncomeControllerBase with _$IncomeController;

abstract class _IncomeControllerBase with Store {
  final _createIncomeUsecase = Modular.get<CreateIncome>();
  final _getIncomeUsecase = Modular.get<GetIncomeByMonth>();
  final loading = Modular.get<LoadingController>();
  final _removeIncomeUsecase = Modular.get<RemoveIncome>();
  final _updateIncomeUsecase = Modular.get<UpdateIncome>();

  @observable
  List<IncomeEntity>? incomeList;

  @observable
  double incomeTotal = 0.0;

  @action
  createIncome(IncomeEntity incomeEntity, DateTime date) async {
    await _createIncomeUsecase(incomeEntity, date);
  }

  @action
  removeIncome(IncomeEntity incomeEntity) async {
    await _removeIncomeUsecase('', incomeEntity);
  }

  @action
  updateIncome(IncomeEntity incomeEntity) async {
    await _updateIncomeUsecase('', incomeEntity);
  }

  @action
  getIncomebyMonth(
    String id,
    DateTime date,
  ) async {
    incomeList = await _getIncomeUsecase(id, date);
    calculateAllTransactions();
  }

  @action
  calculateAllTransactions() {
    try {
      loading.on();
      if (incomeList != null) {
        incomeTotal = incomeList!
            .map((e) => e.value)
            .fold(0, (previousValue, element) => previousValue + element);
      }
    } finally {
      loading.out();
    }
  }
}
