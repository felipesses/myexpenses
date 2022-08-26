import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/domain/repositories/savings_repository.dart';
import 'package:myexpenses/modules/savings/infra/datasource/savings_datasource.dart';

class SavingsRepository implements ISavingsRepository {
  final ISavingsDatasource datasource;

  SavingsRepository(this.datasource);

  @override
  Future<void> createSaving(SavingEntity savingEntity, DateTime date) {
    return datasource.createSaving(savingEntity, date);
  }

  @override
  Future<List<SavingEntity>> getSavingsByMonth(String id, DateTime date) async {
    final list = await datasource.getSavingsByMonth(id, date);
    return list;
  }

  @override
  Future<void> removeSaving(String id, SavingEntity savingEntity) async {
    return datasource.removeSaving(id, savingEntity);
  }

  @override
  Future<void> updateSaving(String id, SavingEntity savingEntity) async {
    return datasource.updateSaving(id, savingEntity);
  }
}
