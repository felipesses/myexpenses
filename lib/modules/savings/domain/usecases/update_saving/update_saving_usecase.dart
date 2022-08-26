import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/domain/repositories/savings_repository.dart';

abstract class IUpdateSaving {
  Future<void> call(String id, SavingEntity savingEntity);
}

class UpdateSaving implements IUpdateSaving {
  final ISavingsRepository repository;

  UpdateSaving(this.repository);

  @override
  Future<void> call(String id, SavingEntity savingEntity) {
    return repository.updateSaving(id, savingEntity);
  }
}
