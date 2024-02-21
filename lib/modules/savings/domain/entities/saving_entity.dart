class SavingEntity {
  String id;
  String userId;
  String name;
  double value;
  double currentAmount;
  double objective;
  int month;
  int year;

  SavingEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.value,
    required this.currentAmount,
    required this.objective,
    required this.month,
    required this.year,
  });
}
