import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myexpenses/modules/income/domain/entities/income_entity.dart';
import 'package:myexpenses/modules/income/presentation/controllers/income_controller.dart';
import 'package:myexpenses/modules/income/presentation/pages/update_income_page.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:myexpenses/utils/format_number.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class IncomeCard extends StatelessWidget {
  final IncomeEntity incomeEntity;
  final DateTime date;
  const IncomeCard({
    Key? key,
    required this.incomeEntity,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<IncomeController>();

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
                    screen: UpdateIncomePage(
                      incomeEntity: incomeEntity,
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
                  controller.removeIncome(incomeEntity).then((value) => {
                        controller.getIncomebyMonth('1', date),
                      });
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
                      color: Colors.green,
                    ),
                    margin: EdgeInsets.only(
                      right: 24,
                      left: 12,
                      top: 16,
                      bottom: 16,
                    ),
                  ),
                  Text(
                    incomeEntity.name,
                    style: TextStyle(
                      fontFamily: 'San Francisco',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      formatNumber(incomeEntity.value),
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
