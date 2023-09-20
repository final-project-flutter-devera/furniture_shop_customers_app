import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IDProvider with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String _customerID = '';
  String? documentId;

  String get getData {
    return _customerID;
  }

  setCustomerID(String user) async {
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString('customerID', user)
        .whenComplete(() => _customerID = user);
    notifyListeners();
  }

  clearCustomerID() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('customerID', '').whenComplete(() => _customerID = '');
    notifyListeners();
  }

  Future<String> getDocumentID_step1() {
    return _prefs.then((SharedPreferences prefs) {
      return prefs.getString('customerID') ?? '';
    });
  }

  getDocumentID() async {
    await getDocumentID_step1().then((value) => _customerID = value);
    notifyListeners();
  }
}
