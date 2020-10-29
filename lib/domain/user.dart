import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo {
  UserInfo(DocumentSnapshot doc) {
    docId = doc.id;
    full_name = doc["full_name"];
  }
  String full_name;
  String docId;
}
