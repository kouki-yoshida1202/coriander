import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String kboyText = "KBOY";

  void changeKboyText() {
    kboyText = "kboyさんいい";
    notifyListeners();
  }
}
