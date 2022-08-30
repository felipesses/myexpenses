import 'package:mocktail/mocktail.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/infra/datasource/income_datasource.dart';
import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/infra/datasource/savings_datasource.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/infra/datasource/transactions_datasource.dart';

class IIncomeDatasourceMock extends Mock implements IIncomeDatasource {}

class IncomeEntityMock extends Mock implements IncomeEntity {}

class ISavingsDatasourceMock extends Mock implements ISavingsDatasource {}

class SavingsEntityMock extends Mock implements SavingEntity {}

class ITransactionsDatasourceMock extends Mock
    implements ITransactionsDatasource {}

class TransactionEntityMock extends Mock implements TransactionEntity {}
