import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:myexpenses/modules/app/presentation/controllers/loading_controller.dart';
import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/domain/usecases/add_saving/add_saving_usecase.dart';
import 'package:myexpenses/modules/savings/domain/usecases/get_saving/get_saving_usecase.dart';
import 'package:myexpenses/modules/savings/domain/usecases/remove_saving/remove_saving_usecase.dart';
import 'package:myexpenses/modules/savings/domain/usecases/update_saving/update_saving_usecase.dart';
part 'saving_controller.g.dart';

class SavingController = _SavingControllerBase with _$SavingController;

abstract class _SavingControllerBase with Store {
  final _createSavingUsecase = Modular.get<CreateSaving>();
  final _removeSavingUsecase = Modular.get<RemoveSaving>();
  final _updateSavingUsecase = Modular.get<UpdateSaving>();
  final _getSavings = Modular.get<GetSavingsByMonth>();
  final loading = Modular.get<LoadingController>();

  @observable
  List<SavingEntity>? savingList;

  @observable
  double savingsTotal = 0.0;

  @action
  createSaving(SavingEntity savingEntity, DateTime date) async {
    await _createSavingUsecase(savingEntity, date);
  }

  @action
  removeSaving(SavingEntity savingEntity) async {
    await _removeSavingUsecase('', savingEntity);
  }

  @action
  updateSaving(SavingEntity savingEntity) async {
    await _updateSavingUsecase('', savingEntity);
  }

  @action
  getSavingsByMonth(
    String id,
    DateTime date,
  ) async {
    savingList = await _getSavings(id, date);
    calculateAllSavings();
  }

  @action
  calculateAllSavings() {
    try {
      loading.on();
      if (savingList != null) {
        savingsTotal = savingList!
            .map((e) => e.value)
            .fold(0, (previousValue, element) => previousValue + element);
      }
    } finally {
      loading.out();
    }
  }
}
