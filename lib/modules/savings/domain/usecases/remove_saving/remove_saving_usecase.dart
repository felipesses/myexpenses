import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/domain/repositories/savings_repository.dart';

abstract class IRemoveSaving {
  Future<void> call(String id, SavingEntity savingEntity);
}

class RemoveSaving implements IRemoveSaving {
  final ISavingsRepository repository;

  RemoveSaving(this.repository);

  @override
  Future<void> call(String id, SavingEntity savingEntity) {
    return repository.removeSaving(id, savingEntity);
  }
}
