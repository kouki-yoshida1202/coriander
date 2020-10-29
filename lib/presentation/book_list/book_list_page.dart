import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/presentation/add_book/add_book_page.dart';
import 'package:coriander/presentation/book_list/book_list_model.dart';
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
                .map(
                  (user) => ListTile(
                    title: Text(user.full_name),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUserPage(user: user),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchUsers();
                      },
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<UserInformationListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddUserPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchUsers();
              },
            );
          },
        ),
      ),
    );
  }
}
