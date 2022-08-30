import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/infra/repositories/savings_repository.dart';

import '../../../../core/mocks/mocks.dart';

void main() {
  final savingEntity = SavingsEntityMock();
  setUpAll(() {
    registerFallbackValue(savingEntity);
  });
  test('deve adicionar uma economia no mês', () async {
    final datasource = ISavingsDatasourceMock();
    final date = DateTime.now();

    when(() => datasource.createSaving(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = SavingsRepository(datasource);

    expect(repository.createSaving(savingEntity, date), completes);
  });

  test('deve atualizar uma economia', () async {
    final datasource = ISavingsDatasourceMock();

    when(() => datasource.updateSaving(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = SavingsRepository(datasource);

    expect(repository.updateSaving('', savingEntity), completes);
  });

  test('deve remover uma economia', () async {
    final datasource = ISavingsDatasourceMock();

    when(() => datasource.removeSaving(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = SavingsRepository(datasource);

    expect(repository.removeSaving('', savingEntity), completes);
  });
  test('deve retornar uma lista de economias', () async {
    final datasource = ISavingsDatasourceMock();
    final date = DateTime.now();

    when(() => datasource.getSavingsByMonth('', date)).thenAnswer(
      (_) => Future.value(
        [savingEntity],
      ),
    );

    final repository = SavingsRepository(datasource);

    final result = repository.getSavingsByMonth('', date);

    expect(result, completion(isA<List<SavingEntity>>()));
  });
}
