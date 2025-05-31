class Conversation {
  final String id;
  final String contactName;
  final String lastMessage;
  final DateTime timestamp;

  Conversation({
    required this.id,
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
  });
}