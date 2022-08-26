import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/domain/repositories/savings_repository.dart';

abstract class IGetSavingsByMonth {
  Future<List<SavingEntity>> call(String id, DateTime date);
}

class GetSavingsByMonth implements IGetSavingsByMonth {
  final ISavingsRepository repository;

  GetSavingsByMonth(this.repository);

  @override
  Future<List<SavingEntity>> call(String id, DateTime date) {
    return repository.getSavingsByMonth(id, date);
  }
}
