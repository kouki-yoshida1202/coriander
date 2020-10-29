import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/user.dart';
import 'package:coriander/presentation/add_book/add_book_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({this.user});
  final UserInfo user;
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    final bool isUpdate = user != null;
    final textEditingController = TextEditingController();
    if (isUpdate) {
      textEditingController.text = user.full_name;
    }

    return ChangeNotifierProvider<AddUserModel>(
      create: (_) => AddUserModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? "ユーザーを編集" : "ユーザーを追加"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AddUserModel>(
            builder: (context, model, child) {
              return Column(
                children: [
                  TextField(
                    controller: textEditingController,
                    onChanged: (text) {
                      model.userName = text;
                    },
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? "更新する" : "追加する"),
                    onPressed: () async {
                      if (isUpdate) {
                        await updateUser(model, context);
                      } else {
                        await addUser(model, context);
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future addUser(model, context) async {
    try {
      await model.addUserToFirebase();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("保存しました"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future updateUser(AddUserModel model, BuildContext context) async {
    try {
      await model.updateUserToFirebase(user);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("保存しました"),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(e.toString()),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
