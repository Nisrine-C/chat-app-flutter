import '../models/Conversation.dart';
import '../models/Message.dart';

class MockChatRepository {
  final List<Conversation> mockConversations = [
    Conversation(
      id: '1',
      contactName: 'Alice',
      lastMessage: 'Hey, how are you?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Conversation(
      id: '2',
      contactName: 'Bob',
      lastMessage: 'See you tomorrow!',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Conversation(
      id: '3',
      contactName: 'Charlie',
      lastMessage: 'Thanks for the update.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final List<Message> mockMessages = [
    Message(
      id: 'm1',
      conversationId: '1',
      content: 'Hey, how are you?',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Message(
      id: 'm2',
      conversationId: '1',
      content: 'I’m good, thanks! You?',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Message(
      id: 'm3',
      conversationId: '2',
      content: 'See you tomorrow!',
      isMe: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Message(
      id: 'm4',
      conversationId: '2',
      content: 'Sounds good!',
      isMe: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
  ];

  Future<List<Conversation>> getConversations() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockConversations;
  }

  Future<List<Message>> getMessages(String conversationId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockMessages.where((msg) => msg.conversationId == conversationId).toList();
  }

  Future<Message> sendMessage(String conversationId, String content) async {
    final newMessage = Message(
      id: 'm${mockMessages.length + 1}',
      conversationId: conversationId,
      content: content,
      isMe: true,
      timestamp: DateTime.now(),
    );
    mockMessages.add(newMessage);
    return newMessage;
  }

  Future<Message> receiveMessage(String conversationId, String content) async {
    final newMessage = Message(
      id: 'm${mockMessages.length + 1}',
      conversationId: conversationId,
      content: content,
      isMe: false,
      timestamp: DateTime.now(),
    );
    mockMessages.add(newMessage);
    return newMessage;
  }
}