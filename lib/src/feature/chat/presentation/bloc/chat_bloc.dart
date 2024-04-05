import 'package:bloc/bloc.dart';
import 'package:flutter_riverpod_base/src/commons/usecases/use_case.dart';
import 'package:flutter_riverpod_base/src/core/models/agent_details.dart';
import 'package:flutter_riverpod_base/src/core/models/chat_model.dart';
import 'package:flutter_riverpod_base/src/feature/chat/domain/usecase/chat_service.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService _chatService;
  final SendMessage _sendMessage;
  final GetAgentDetails _agentDetails;
  ChatBloc(
      {required ChatService chatService,
      required SendMessage sendMessage,
      required GetAgentDetails getAgentdetails})
      : _chatService = chatService,
        _sendMessage = sendMessage,
        _agentDetails = getAgentdetails,
        super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});

    on<GetChatDataEvent>(
      (event, emit) async {
        emit(LoadingState());
        final res = await _chatService.call(event.chatParams);

        res.fold((l) => emit(ChatFailureState(message: l.message)),
            (r) => emit(ChatSuccessState(messages: r)));
      },
    );

    on<SendChatEvent>(
      (event, emit) async {
        final res = await _sendMessage.call(event.chatMessage);

        res.fold((l) => emit(ChatFailureState(message: l.message)),
            (r) => emit(ChatSuccessState(messages: r)));
      },
    );
    on<GetAgentDetailsEvent>(
      (event, emit) async {
        emit(LoadingState());
        final res = await _agentDetails.call(event.agentID);
        res.fold((l) => emit(ChatFailureState(message: l.message)),
            (r) => emit(AgentDetailsSuccessState(agentDetails: r)));
      },
    );
  }
}
