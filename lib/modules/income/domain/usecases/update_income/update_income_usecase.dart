import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/domain/repositories/income_repository.dart';

abstract class IUpdateIncome {
  Future<void> call(String id, IncomeEntity incomeEntity);
}

class UpdateIncome implements IUpdateIncome {
  final IIncomeRepository repository;

  UpdateIncome(this.repository);

  @override
  Future<void> call(String id, IncomeEntity incomeEntity) {
    return repository.updateIncome(id, incomeEntity);
  }
}
