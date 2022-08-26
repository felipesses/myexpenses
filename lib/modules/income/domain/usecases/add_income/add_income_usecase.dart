import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/domain/repositories/income_repository.dart';

abstract class ICreateIncome {
  Future<void> call(IncomeEntity incomeEntity, DateTime date);
}

class CreateIncome implements ICreateIncome {
  final IIncomeRepository repository;

  CreateIncome(this.repository);

  @override
  Future<void> call(IncomeEntity incomeEntity, DateTime date) {
    return repository.createIncome(incomeEntity, date);
  }
}
