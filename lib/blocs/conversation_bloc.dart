import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/Conversation.dart';
import '../models/Message.dart';
import '../repositories/mock_chat_repository.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();
  @override
  List<Object> get props => [];
}

class LoadConversations extends ConversationEvent {}

class LoadMessages extends ConversationEvent {
  final String conversationId;
  const LoadMessages(this.conversationId);
  @override
  List<Object> get props => [conversationId];
}

class SendMessage extends ConversationEvent {
  final String conversationId;
  final String content;
  const SendMessage(this.conversationId, this.content);
  @override
  List<Object> get props => [conversationId, content];
}

class ReceiveMessage extends ConversationEvent {
  final String conversationId;
  final String content;
  const ReceiveMessage(this.conversationId, this.content);
  @override
  List<Object> get props => [conversationId, content];
}

class NewConversation extends ConversationEvent {
  final String contactName;
  const NewConversation(this.contactName);
  @override
  List<Object> get props => [contactName];
}

abstract class ConversationState extends Equatable {
  const ConversationState();
  @override
  List<Object> get props => [];
}

class ConversationLoading extends ConversationState {}

class ConversationListLoaded extends ConversationState {
  final List<Conversation> conversations;
  const ConversationListLoaded(this.conversations);
  @override
  List<Object> get props => [conversations];
}

class MessageListLoaded extends ConversationState {
  final List<Message> messages;
  const MessageListLoaded(this.messages);
  @override
  List<Object> get props => [messages];
}

class ConversationError extends ConversationState {
  final String message;
  const ConversationError(this.message);
  @override
  List<Object> get props => [message];
}

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final MockChatRepository repository;

  ConversationBloc(this.repository) : super(ConversationLoading()) {
    on<LoadConversations>(_onLoadConversations);
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
    on<ReceiveMessage>(_onReceiveMessage);
    on<NewConversation>(_onNewConversation); // Add handler for new event
  }

  Future<void> _onLoadConversations(
      LoadConversations event,
      Emitter<ConversationState> emit,
      ) async {
    try {
      emit(ConversationLoading());
      final conversations = await repository.getConversations();
      emit(ConversationListLoaded(conversations));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
      LoadMessages event,
      Emitter<ConversationState> emit,
      ) async {
    try {
      emit(ConversationLoading());
      final messages = await repository.getMessages(event.conversationId);
      emit(MessageListLoaded(messages));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendMessage event,
      Emitter<ConversationState> emit,
      ) async {
    try {
      final currentState = state;
      final newMessage = await repository.sendMessage(event.conversationId, event.content);
      if (currentState is MessageListLoaded) {
        final updatedMessages = List<Message>.from(currentState.messages)..add(newMessage);
        emit(MessageListLoaded(updatedMessages));
      }
      await Future.delayed(const Duration(seconds: 2));
      add(ReceiveMessage(event.conversationId, "Got it! Thanks for your message."));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  Future<void> _onReceiveMessage(
      ReceiveMessage event,
      Emitter<ConversationState> emit,
      ) async {
    try {
      final currentState = state;
      final newMessage = await repository.receiveMessage(event.conversationId, event.content);
      if (currentState is MessageListLoaded) {
        final updatedMessages = List<Message>.from(currentState.messages)..add(newMessage);
        emit(MessageListLoaded(updatedMessages));
      }
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }

  Future<void> _onNewConversation(
      NewConversation event,
      Emitter<ConversationState> emit,
      ) async {
    try {
      final currentState = state;
      final newConversation = await repository.addConversation(event.contactName);
      if (currentState is ConversationListLoaded) {
        final updatedConversations = List<Conversation>.from(currentState.conversations)
          ..add(newConversation);
        emit(ConversationListLoaded(updatedConversations));
      } else {
        emit(ConversationListLoaded([newConversation]));
      }
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }
}