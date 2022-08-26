import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/domain/repositories/income_repository.dart';

abstract class IRemoveIncome {
  Future<void> call(String id, IncomeEntity incomeEntity);
}

class RemoveIncome implements IRemoveIncome {
  final IIncomeRepository repository;

  RemoveIncome(this.repository);

  @override
  Future<void> call(String id, IncomeEntity incomeEntity) {
    return repository.removeIncome(id, incomeEntity);
  }
}
