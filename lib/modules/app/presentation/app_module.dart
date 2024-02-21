import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:myexpenses/core/auth/auth.dart';
import 'package:myexpenses/modules/app/auth/presentation/controllers/auth_controller.dart';
import 'package:myexpenses/modules/app/presentation/controllers/app_controller.dart';
import 'package:myexpenses/modules/home/presentation/pages/home_page.dart';
import 'package:myexpenses/modules/income/domain/usecases/remove_income/remove_income_usecase.dart';
import 'package:myexpenses/modules/income/domain/usecases/update_income/update_income_usecase.dart';
import 'package:myexpenses/modules/income/external/firebase/income_firebase_datasource.dart';
import 'package:myexpenses/modules/savings/domain/usecases/update_saving/update_saving_usecase.dart';
import 'package:myexpenses/modules/savings/external/firebase/savings_firebase_datasource.dart';
import 'package:myexpenses/modules/splash/presentation/splash_page.dart';
import 'package:myexpenses/modules/transactions/domain/usecases/remove_transaction/remove_transaction_usecase.dart';
import 'package:myexpenses/modules/transactions/domain/usecases/update_transaction/update_transaction_usecase.dart';
import 'package:myexpenses/modules/transactions/external/firebase/transactions_firebase_datasource.dart';
import '../auth/presentation/auth_page.dart';
import '/modules/app/presentation/controllers/loading_controller.dart';
import '/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import '/modules/home/presentation/controllers/home_controller.dart';
import '/modules/income/domain/repositories/income_repository.dart';
import '/modules/income/domain/usecases/add_income/add_income_usecase.dart';
import '/modules/income/domain/usecases/get_income/get_income_usecase.dart';
import '/modules/income/external/db/income_db_datasource.dart';
import '/modules/income/infra/datasource/income_datasource.dart';
import '/modules/income/infra/repositories/income_repository.dart';
import '/modules/income/presentation/controllers/income_controller.dart';
import '/modules/savings/domain/repositories/savings_repository.dart';
import '/modules/savings/domain/usecases/add_saving/add_saving_usecase.dart';
import '/modules/savings/domain/usecases/get_saving/get_saving_usecase.dart';
import '/modules/savings/domain/usecases/remove_saving/remove_saving_usecase.dart';
import '/modules/savings/external/db/savings_db_datasource.dart';
import '/modules/savings/infra/datasource/savings_datasource.dart';
import '/modules/savings/infra/repositories/savings_repository.dart';
import '/modules/savings/presentation/controllers/saving_controller.dart';
import '/modules/transactions/domain/repositories/transactions_repository.dart';
import '/modules/transactions/domain/usecases/add_transaction/add_transaction_usecase.dart';
import '/modules/transactions/domain/usecases/get_transaction/get_transaction_usecase.dart';
import '/modules/transactions/external/db/transactions_db_datasource.dart';
import '/modules/transactions/infra/datasource/transactions_datasource.dart';
import '/modules/transactions/infra/repositories/transactions_repository.dart';
import '/modules/transactions/presentation/controllers/transactions_controller.dart';

class AppModule extends Module {
  final List<Bind<Object>> mysqlBinds = [
    Bind.factory<IIncomeDatasource>((i) => IncomeDbDatasource()),
    Bind.factory<ITransactionsDatasource>((i) => TransactionsDbDatasource()),
    Bind.factory<ISavingsDatasource>((i) => SavingsDbDatasource()),
  ];

  final List<Bind<Object>> firebaseBinds = [
    Bind.factory<IIncomeDatasource>((i) => IncomeFirebaseDatasource()),
    Bind.factory<ITransactionsDatasource>(
        (i) => TransactionsFirebaseDatasource()),
    Bind.factory<ISavingsDatasource>((i) => SavingsFirebaseDatasource()),
  ];

  @override
  List<Bind> get binds => [
        if (kIsWeb) ...firebaseBinds else ...mysqlBinds,

        Bind.factory<IIncomeRepository>((i) => IncomeRepository(i())),
        Bind.singleton<GetIncomeByMonth>(
          (i) => GetIncomeByMonth(i()),
        ),
        Bind.singleton<CreateIncome>(
          (i) => CreateIncome(i()),
        ),
        Bind.singleton<UpdateIncome>(
          (i) => UpdateIncome(i()),
        ),
        Bind.singleton<RemoveIncome>(
          (i) => RemoveIncome(i()),
        ),

        // TRANSACTIONS

        Bind.factory<ITransactionsRepository>(
            (i) => TransactionsRepository(i())),
        Bind.singleton<GetTransactionsByMonth>(
          (i) => GetTransactionsByMonth(i()),
        ),
        Bind.singleton<CreateTransaction>(
          (i) => CreateTransaction(i()),
        ),
        Bind.singleton<UpdateTransaction>(
          (i) => UpdateTransaction(i()),
        ),
        Bind.singleton<RemoveTransaction>(
          (i) => RemoveTransaction(i()),
        ),

        // SAVINGS

        Bind.factory<ISavingsRepository>((i) => SavingsRepository(i())),
        Bind.singleton<CreateSaving>(
          (i) => CreateSaving(i()),
        ),
        Bind.singleton<GetSavingsByMonth>(
          (i) => GetSavingsByMonth(i()),
        ),
        Bind.singleton<UpdateSaving>(
          (i) => UpdateSaving(i()),
        ),
        Bind.singleton<RemoveSaving>(
          (i) => RemoveSaving(i()),
        ),

        // CONTROLLERS
        Bind.lazySingleton((i) => AppController()),
        Bind.lazySingleton((i) => LoadingController()),
        Bind.lazySingleton((i) => Auth()),
        Bind.lazySingleton((i) => AuthController()),
        Bind.lazySingleton((i) => HomeController()),
        Bind.lazySingleton((i) => DashboardController()),
        Bind.lazySingleton((i) => IncomeController()),
        Bind.lazySingleton((i) => TransactionsController()),
        Bind.lazySingleton((i) => SavingController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => SplashPage()),
        ChildRoute('/auth', child: (context, args) => AuthPage()),
        ChildRoute(
          '/home',
          child: (context, args) => HomePage(
            monthValue: args.data,
          ),
        ),
      ];
}
