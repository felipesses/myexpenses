import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myexpenses/modules/savings/domain/entities/saving_entity.dart';
import 'package:myexpenses/modules/savings/presentation/controllers/saving_controller.dart';
import 'package:myexpenses/modules/savings/presentation/pages/update_saving_page.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:myexpenses/utils/format_number.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class SavingCard extends StatelessWidget {
  final SavingEntity savingEntity;
  final DateTime date;
  const SavingCard({
    Key? key,
    required this.savingEntity,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<SavingController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  pushNewScreen(
                    context,
                    screen: UpdateSavingPage(
                      savingEntity: savingEntity,
                      date: date,
                    ),
                  );
                },
                backgroundColor: Colors.transparent,
                foregroundColor: primary,
                icon: Icons.mode_edit_rounded,
                label: 'Editar',
              ),
              SlidableAction(
                onPressed: (_) async {
                  controller.removeSaving(savingEntity).then(
                        (value) => {
                          controller.getSavingsByMonth('1', date),
                        },
                      );
                },
                backgroundColor: Colors.transparent,
                foregroundColor: primary,
                icon: Icons.delete,
                label: 'Excluir',
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.zero,
            height: 90,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 5,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color:
                          Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                    ),
                    margin: EdgeInsets.only(
                      right: 24,
                      left: 12,
                      top: 16,
                      bottom: 16,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        savingEntity.name,
                        style: TextStyle(
                          fontFamily: 'San Francisco',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatNumber(savingEntity.objective),
                        style: TextStyle(
                          fontFamily: 'San Francisco',
                          color: grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      formatNumber(savingEntity.value),
                      style: TextStyle(
                        fontFamily: 'San Francisco',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
