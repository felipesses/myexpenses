import 'package:myexpenses/core/db/connection.dart';
import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/infra/adapters/savings_adapter.dart';
import 'package:myexpenses/modules/savings/infra/datasource/savings_datasource.dart';

class SavingsDbDatasource implements ISavingsDatasource {
  @override
  Future<void> createSaving(SavingEntity savingEntity, DateTime date) async {
    final db = await DB.instance.database;

    await db.insert(
      'savings',
      SavingAdapter.toJson(
        {
          'name': savingEntity.name,
          'value': savingEntity.value,
          'month': date.month,
          'year': date.year,
          'objective': savingEntity.objective,
          'currentAmount': savingEntity.currentAmount,
        },
      ),
    );
  }

  @override
  Future<List<SavingEntity>> getSavingsByMonth(String id, DateTime date) async {
    final db = await DB.instance.database;
    final List<SavingEntity> savingsList = [];

    final result = await db.rawQuery(
        'SELECT * FROM savings WHERE month = ${date.month} AND year = ${date.year}');

    for (var saving in result) {
      savingsList.add(SavingAdapter.fromJson(saving));
    }

    return savingsList;
  }

  @override
  Future<void> removeSaving(String id, SavingEntity savingEntity) async {
    final db = await DB.instance.database;
    await db.delete('savings', where: 'id = ${savingEntity.id}');
  }

  @override
  Future<void> updateSaving(String id, SavingEntity savingEntity) async {
    final db = await DB.instance.database;

    await db.update(
      'savings',
      SavingAdapter.toJson(
        {
          'name': savingEntity.name,
          'value': savingEntity.value,
          'month': savingEntity.month,
          'year': savingEntity.year,
          'objective': savingEntity.objective,
          'currentAmount': savingEntity.currentAmount,
        },
      ),
      where: 'id = ${savingEntity.id}',
    );
  }
}
