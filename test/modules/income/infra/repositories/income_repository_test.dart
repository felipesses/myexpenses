import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/infra/repositories/income_repository.dart';

import '../../../../core/mocks/mocks.dart';

void main() {
  final incomeEntity = IncomeEntityMock();
  setUpAll(() {
    registerFallbackValue(incomeEntity);
  });
  test('deve adicionar uma renda no mês', () async {
    final datasource = IIncomeDatasourceMock();
    final date = DateTime.now();

    when(() => datasource.createIncome(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = IncomeRepository(datasource);

    expect(repository.createIncome(incomeEntity, date), completes);
  });

  test('deve atualizar uma renda', () async {
    final datasource = IIncomeDatasourceMock();

    when(() => datasource.updateIncome(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = IncomeRepository(datasource);

    expect(repository.updateIncome('', incomeEntity), completes);
  });

  test('deve remover uma renda', () async {
    final datasource = IIncomeDatasourceMock();

    when(() => datasource.removeIncome(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = IncomeRepository(datasource);

    expect(repository.removeIncome('', incomeEntity), completes);
  });
  test('deve retornar uma lista de rendas', () async {
    final datasource = IIncomeDatasourceMock();
    final date = DateTime.now();

    when(() => datasource.getIncomeByMonth('', date)).thenAnswer(
      (_) => Future.value(
        [incomeEntity],
      ),
    );

    final repository = IncomeRepository(datasource);

    final result = repository.getIncomeByMonth('', date);

    final value = await result;

    expect(result, completion(isA<List<IncomeEntity>>()));
    expect(value[0].name, 'salario');
  });
}
