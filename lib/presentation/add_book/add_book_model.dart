import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/user.dart';
import 'package:flutter/material.dart';

class AddUserModel extends ChangeNotifier {
  String userName = "";

  Future addUserToFirebase() async {
    if (userName.isEmpty) {
      throw ("ユーザーネームを入力してください");
    }

    FirebaseFirestore.instance.collection("users").add(
      {
        'full_name': userName,
        'createTime': Timestamp.now(),
      },
    );
  }

  Future updateUserToFirebase(UserInfo user) async {
    if (userName.isEmpty) {
      throw ("ユーザーネームを入力してください");
    }

    final document =
        FirebaseFirestore.instance.collection("users").doc(user.docId);

    await document.update(
      {
        "full_name": userName,
        "updateTime": Timestamp.now(),
      },
    );
  }
}
