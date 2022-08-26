class IncomeEntity {
  int? id;
  String name;
  double value;
  int month;
  int year;

  IncomeEntity({
    this.id,
    required this.name,
    required this.value,
    required this.month,
    required this.year,
  });
}
