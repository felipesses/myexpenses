import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';

abstract class IIncomeRepository {
  Future<void> createIncome(IncomeEntity incomeEntity, DateTime date);
  Future<List<IncomeEntity>> getIncomeByMonth(String id, DateTime date);
  Future<void> updateIncome(String id, IncomeEntity incomeEntity);
  Future<void> removeIncome(String id, IncomeEntity incomeEntity);
}
