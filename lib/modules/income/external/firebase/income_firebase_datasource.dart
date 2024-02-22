import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/infra/adapters/income_adapter.dart';
import 'package:myexpenses/modules/income/infra/datasource/income_datasource.dart';
import 'package:uuid/uuid.dart';

class IncomeFirebaseDatasource implements IIncomeDatasource {
  @override
  Future<void> createIncome(IncomeEntity incomeEntity, DateTime date) async {
    final firestore = FirebaseFirestore.instance;
    var uuid = Uuid();

    await firestore
        .collection('income')
        .add(
          IncomeAdapter.toJson(
            {
              'id': uuid.v4(),
              'userId': incomeEntity.userId,
              'name': incomeEntity.name,
              'value': incomeEntity.value,
              'month': date.month,
              'year': date.year,
            },
          ),
        )
        .then((doc) async => {
              await doc.update({
                'docId': doc.id,
              })
            });
  }

  @override
  Future<List<IncomeEntity>> getIncomeByMonth(String id, DateTime date) async {
    final firestore = FirebaseFirestore.instance;

    final List<IncomeEntity> incomeList = [];

    try {
      final data = await firestore
          .collection('income')
          .where('userId', isEqualTo: id)
          .where('month', isEqualTo: date.month)
          .where('year', isEqualTo: date.year)
          .get();

      for (var income in data.docs) {
        incomeList.add(IncomeAdapter.fromJson(income));
      }

      return incomeList;
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> removeIncome(String id, IncomeEntity incomeEntity) async {
    final firestore = FirebaseFirestore.instance;

    try {
      return await firestore
          .collection('income')
          .doc(incomeEntity.docId)
          .delete();
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> updateIncome(String id, IncomeEntity incomeEntity) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('income').doc(incomeEntity.docId).update(
          IncomeAdapter.toJson(
            {
              'id': incomeEntity.id,
              'userId': incomeEntity.userId,
              'docId': incomeEntity.docId,
              'name': incomeEntity.name,
              'value': incomeEntity.value,
              'month': incomeEntity.month,
              'year': incomeEntity.year,
            },
          ),
        );
  }
}
