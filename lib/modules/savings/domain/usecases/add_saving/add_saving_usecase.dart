import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/domain/repositories/savings_repository.dart';

abstract class ICreateSaving {
  Future<void> call(SavingEntity savingEntity, DateTime date);
}

class CreateSaving implements ICreateSaving {
  final ISavingsRepository repository;

  CreateSaving(this.repository);

  @override
  Future<void> call(SavingEntity savingEntity, DateTime date) {
    return repository.createSaving(savingEntity, date);
  }
}
