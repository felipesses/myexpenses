class TotalModel {
  double value;

  TotalModel({this.value = 0.0});

  factory TotalModel.empty() => TotalModel(value: 0);

  double calculateTotal(
      {required double incomeTotal,
      required double transactionsTotal,
      required double savingsTotal}) {
    return value = incomeTotal - (transactionsTotal + savingsTotal);
  }
}
