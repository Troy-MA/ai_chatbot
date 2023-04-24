import 'package:ai_chatbot/models/text_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final texts = <TextModel>[].obs;
//Stream Messages
  Stream<List<TextModel>> getTexts() async* {
    yield* db
        .collection('users')
        .doc("1a9SzCOqTJgF4d0X4WXmvfk0mgm2")
        .collection('chat')
        .snapshots()
        .map(
          (snap) => snap.docs.map((e) => TextModel.fromMap(e.data())).toList(),
        );
  }

//send new message
  Future sendNewMessage(String userID, TextModel message) async {
    return db.collection("users").doc(userID).collection("chat").add(
          message.toMap(),
        );
  }

  @override
  void onInit() {
    texts.bindStream(getTexts());
    texts.listen((texts) {
      texts.sort((a, b) => a.time.compareTo(b.time));
    });
    super.onInit();
  }
}
