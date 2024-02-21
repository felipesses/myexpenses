class IncomeEntity {
  String? id;
  String userId;
  String name;
  double value;
  int month;
  int year;

  IncomeEntity({
    this.id,
    required this.userId,
    required this.name,
    required this.value,
    required this.month,
    required this.year,
  });
}
