import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/user.dart';
import 'package:flutter/material.dart';

class UserInformationListModel extends ChangeNotifier {
  List<UserInfo> users = [];

  Future fetchUsers() async {
    final docs = await FirebaseFirestore.instance.collection('users').get();
    final users = docs.docs.map((doc) => UserInfo(doc)).toList();
    this.users = users;
    notifyListeners();
  }
}
