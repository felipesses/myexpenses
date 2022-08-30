import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/infra/repositories/transactions_repository.dart';

import '../../../../core/mocks/mocks.dart';

void main() {
  final transactionEntity = TransactionEntityMock();
  setUpAll(() {
    registerFallbackValue(transactionEntity);
  });
  test('deve adicionar uma renda no mês', () async {
    final datasource = ITransactionsDatasourceMock();
    final date = DateTime.now();

    when(() => datasource.createTransaction(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = TransactionsRepository(datasource);

    expect(repository.createTransaction(transactionEntity, date), completes);
  });

  test('deve atualizar uma renda', () async {
    final datasource = ITransactionsDatasourceMock();

    when(() => datasource.updateTransaction(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = TransactionsRepository(datasource);

    expect(repository.updateTransaction('', transactionEntity), completes);
  });

  test('deve remover uma renda', () async {
    final datasource = ITransactionsDatasourceMock();

    when(() => datasource.removeTransaction(any(), any())).thenAnswer(
      (_) => Future.value(),
    );

    final repository = TransactionsRepository(datasource);

    expect(repository.removeTransaction('', transactionEntity), completes);
  });
  test('deve retornar uma lista de rendas', () async {
    final datasource = ITransactionsDatasourceMock();
    final date = DateTime.now();

    when(() => datasource.getTransactionsByMonth('', date)).thenAnswer(
      (_) => Future.value(
        [transactionEntity],
      ),
    );

    final repository = TransactionsRepository(datasource);

    final result = repository.getTransactionsByMonth('', date);

    final value = await result;

    expect(result, completion(isA<List<TransactionEntity>>()));
  });
}
