class TransactionEntity {
  String id;
  String userId;
  String docId;
  String name;
  double value;
  int category;
  int month;
  int year;
  String emojiTitle;

  TransactionEntity({
    required this.id,
    required this.userId,
    required this.docId,
    required this.name,
    required this.value,
    required this.category,
    required this.month,
    required this.year,
    required this.emojiTitle,
  });
}
