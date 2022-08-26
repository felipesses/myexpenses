import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:myexpenses/modules/transactions/domain/entities/transaction_entity.dart';
import 'package:myexpenses/modules/transactions/presentation/controllers/transactions_controller.dart';
import 'package:myexpenses/modules/transactions/presentation/pages/update_transactions_page.dart';
import 'package:myexpenses/styles/colors.dart';
import 'package:myexpenses/utils/format_number.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class TransactionCard extends StatelessWidget {
  final TransactionEntity transactionEntity;
  final DateTime date;
  const TransactionCard({
    Key? key,
    required this.transactionEntity,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<TransactionsController>();

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
                    screen: UpdateTransactionsPage(
                      transactionEntity: transactionEntity,
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
                  controller.removeTransaction(transactionEntity).then(
                        (value) => {
                          controller.getTransactionsbyMonth('1', date),
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
                        transactionEntity.name,
                        style: TextStyle(
                          fontFamily: 'San Francisco',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        transactionEntity.emojiTitle,
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
                      formatNumber(transactionEntity.value),
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
