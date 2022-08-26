import 'package:flutter/material.dart';
import 'package:myexpenses/utils/format_number.dart';

class TotalIncome extends StatelessWidget {
  final double total;
  const TotalIncome({Key? key, this.total = 0.0}) : super(key: key);

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
                color: Colors.green,
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
              child: Image.asset(
                'assets/icons/income.png',
                color: Colors.green,
              ),
            ),
            Text(
              'Renda no mês',
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
