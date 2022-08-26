import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';

abstract class ISavingsDatasource {
  Future<void> createSaving(SavingEntity savingEntity, DateTime date);
  Future<List<SavingEntity>> getSavingsByMonth(String id, DateTime date);
  Future<void> updateSaving(String id, SavingEntity savingEntity);
  Future<void> removeSaving(String id, SavingEntity savingEntity);
}
