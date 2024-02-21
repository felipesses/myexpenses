import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';

class IncomeModel extends IncomeEntity {
  IncomeModel({
    required super.name,
    required super.value,
    required super.month,
    required super.year,
    required super.userId,
  });

  factory IncomeModel.empty() => IncomeModel(
        name: '',
        value: -1,
        month: 0,
        year: 0,
        userId: '',
      );
}
