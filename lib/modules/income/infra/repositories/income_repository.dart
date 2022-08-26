import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/domain/repositories/income_repository.dart';
import 'package:myexpenses/modules/income/infra/datasource/income_datasource.dart';

class IncomeRepository implements IIncomeRepository {
  final IIncomeDatasource datasource;

  IncomeRepository(this.datasource);
  @override
  Future<void> createIncome(IncomeEntity incomeEntity, DateTime date) {
    return datasource.createIncome(incomeEntity, date);
  }

  @override
  Future<List<IncomeEntity>> getIncomeByMonth(String id, DateTime date) async {
    final list = await datasource.getIncomeByMonth(id, date);

    return list;
  }

  @override
  Future<void> removeIncome(String id, IncomeEntity incomeEntity) {
    return datasource.removeIncome(id, incomeEntity);
  }

  @override
  Future<void> updateIncome(String id, IncomeEntity incomeEntity) {
    return datasource.updateIncome(id, incomeEntity);
  }
}
