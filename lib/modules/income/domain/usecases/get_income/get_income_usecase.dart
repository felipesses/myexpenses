import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/domain/repositories/income_repository.dart';

abstract class IGetIncomeByMonth {
  Future<List<IncomeEntity>> call(String id, DateTime date);
}

class GetIncomeByMonth implements IGetIncomeByMonth {
  final IIncomeRepository repository;

  GetIncomeByMonth(this.repository);

  @override
  Future<List<IncomeEntity>> call(String id, DateTime date) {
    return repository.getIncomeByMonth(id, date);
  }
}
