import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/book_list_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInformationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return ChangeNotifierProvider<UserInformationListModel>(
      create: (_) => UserInformationListModel()..fetchUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("ユーザー一覧"),
        ),
        body: Consumer<UserInformationListModel>(
          builder: (context, model, child) {
            final users = model.users;
            final listTiles = users
                .map((user) => ListTile(
                      title: Text(user.full_name),
                    ))
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
      ),
    );
  }
}
