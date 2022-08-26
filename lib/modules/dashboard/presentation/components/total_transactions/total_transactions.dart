import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myexpenses/utils/format_number.dart';

class TotalTransactions extends StatelessWidget {
  final double total;
  const TotalTransactions({Key? key, this.total = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 80,
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
                color: Colors.red,
              ),
              margin: EdgeInsets.only(
                right: 24,
                left: 12,
                top: 16,
                bottom: 16,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 24,
              ),
              height: 32,
              width: 32,
              child: SvgPicture.asset(
                'assets/icons/expense.svg',
                color: Colors.red,
              ),
            ),
            Text(
              'Gastos no mês',
              style: TextStyle(
                fontFamily: 'San Francisco',
                fontSize: 16,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(
                formatNumber(total),
                style: TextStyle(
                  fontFamily: 'San Francisco',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
