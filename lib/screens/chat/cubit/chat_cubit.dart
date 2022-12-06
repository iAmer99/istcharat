import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istchrat/screens/chat/cubit/chat_states.dart';
import 'package:istchrat/screens/chat/model/chat_model.dart';
import 'package:istchrat/screens/chat/model/firestore_constants.dart';
import 'package:istchrat/screens/chat/repository/chat_repository.dart';

class ChatCubit extends Cubit<ChatStates>{

  ChatCubit() : super (ChatInitialStates());
  final ChatRepository _repository = ChatRepository();
  String img = "";
  String channelName = "";

  static ChatCubit get(context)=> BlocProvider.of(context);

  final firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy(FirestoreConstants.timestamp, descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendMessage(String content, int type, String groupChatId, String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    MessageChat messageChat = MessageChat(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      type: type,
    );

    firebaseFirestore.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        messageChat.toJson(),
      );
    });
  }

  Future<String?> startChat(
      {required String id,
        required bool isLecturer}) async {
    if (isLecturer) {
      emit(ChatStartingState());
      final response = await _repository.startChat(id: id, key: "chat_consultations");
      response.fold((error) {
        emit(ChatFailedState(error));
      }, (model) {
        img = model.data?.channel?.reciverImage ?? "";
        channelName = model.data?.channel?.channelName ?? "";
        emit(ChatStartedState(model.data?.channel?.period ?? "0"));
      });
    }
  }
}
