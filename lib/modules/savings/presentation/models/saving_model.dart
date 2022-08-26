import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';

class SavingModel extends SavingEntity {
  SavingModel({
    required super.id,
    required super.name,
    required super.value,
    required super.month,
    required super.year,
    required super.objective,
    required super.currentAmount,
  });

  factory SavingModel.empty() => SavingModel(
        name: '',
        value: -1,
        month: 0,
        year: 0,
        objective: -1,
        currentAmount: -1,
        id: 0,
      );
}
