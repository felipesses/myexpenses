import 'package:myexpenses/core/db/connection.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/infra/adapters/income_adapter.dart';
import 'package:myexpenses/modules/income/infra/datasource/income_datasource.dart';

class IncomeDbDatasource implements IIncomeDatasource {
  @override
  Future<void> createIncome(IncomeEntity incomeEntity, DateTime date) async {
    final db = await DB.instance.database;

    await db.insert(
      'income',
      IncomeAdapter.toJson(
        {
          'name': incomeEntity.name,
          'value': incomeEntity.value,
          'month': date.month,
          'year': date.year,
        },
      ),
    );
  }

  @override
  Future<List<IncomeEntity>> getIncomeByMonth(String id, DateTime date) async {
    final db = await DB.instance.database;
    final List<IncomeEntity> incomeList = [];

    final result = await db.rawQuery(
        'SELECT * FROM income WHERE month = ${date.month} AND year = ${date.year}');

    for (var income in result) {
      incomeList.add(IncomeAdapter.fromJson(income));
    }

    return incomeList;
  }

  @override
  Future<void> removeIncome(String id, IncomeEntity incomeEntity) async {
    final db = await DB.instance.database;
    await db.delete('income', where: 'id = ${incomeEntity.id}');
  }

  @override
  Future<void> updateIncome(String id, IncomeEntity incomeEntity) async {
    final db = await DB.instance.database;

    await db.update(
      'income',
      IncomeAdapter.toJson(
        {
          'name': incomeEntity.name,
          'value': incomeEntity.value,
          'month': incomeEntity.month,
          'year': incomeEntity.year,
        },
      ),
      where: 'id = ${incomeEntity.id}',
    );
  }
}
