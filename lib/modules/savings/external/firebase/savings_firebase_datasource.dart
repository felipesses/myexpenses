import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/infra/adapters/savings_adapter.dart';
import 'package:myexpenses/modules/savings/infra/datasource/savings_datasource.dart';
import 'package:uuid/uuid.dart';

class SavingsFirebaseDatasource implements ISavingsDatasource {
  @override
  Future<void> createSaving(SavingEntity savingEntity, DateTime date) async {
    final firestore = FirebaseFirestore.instance;
    var uuid = Uuid();

    await firestore.collection('savings').add(
          SavingAdapter.toJson(
            {
              'id': uuid.v4(),
              'userId': savingEntity.userId,
              'name': savingEntity.name,
              'value': savingEntity.value,
              'month': date.month,
              'year': date.year,
              'objective': savingEntity.objective,
              'currentAmount': savingEntity.currentAmount,
            },
          ),
        );
  }

  @override
  Future<List<SavingEntity>> getSavingsByMonth(String id, DateTime date) async {
    final firestore = FirebaseFirestore.instance;

    final List<SavingEntity> savingsList = [];

    try {
      final data = await firestore
          .collection('transactions')
          .where('userId', isEqualTo: id)
          .where('month', isEqualTo: date.month)
          .where('year', isEqualTo: date.year)
          .get();

      for (var saving in data.docs) {
        savingsList.add(SavingAdapter.fromJson(saving));
      }

      return savingsList;
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> removeSaving(String id, SavingEntity savingEntity) async {
    final firestore = FirebaseFirestore.instance;

    try {
      return await firestore
          .collection('savings')
          .doc(savingEntity.id)
          .delete();
    } catch (e) {
      throw Error();
    }
  }

  @override
  Future<void> updateSaving(String id, SavingEntity savingEntity) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('savings').doc(savingEntity.id).update(
          SavingAdapter.toJson(
            {
              'name': savingEntity.name,
              'value': savingEntity.value,
              'month': savingEntity.month,
              'year': savingEntity.year,
              'objective': savingEntity.objective,
              'currentAmount': savingEntity.currentAmount,
            },
          ),
        );
  }
}
