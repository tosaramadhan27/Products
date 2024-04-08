import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _idToken, userId;
  DateTime? _expiryDate;

  // temporary data, agar tidak langsung mengakses fungsi dari package flutter_login
  String? _tempidToken, tempuserId;
  DateTime? _tempexpiryDate;

  void tempData () {
    _idToken = _tempidToken;
    userId = tempuserId;
    _expiryDate = _tempexpiryDate;
    notifyListeners();
  }
  

  bool get isAuth {
    // return false or true
    return token != null;
  }

  String? get token {
    if (_idToken != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _expiryDate != null) {
      return _idToken;
    } else {
      return null;
    }
  }

  // signup
  Future<void> signup(email, password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDasmwGV0dfgHaRBuFUHptQp1Udwx7TPnM");

    try {
      var response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      // print(json.decode(response.body));
      // error handling
      var responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }
      // id token
      _tempidToken = responseData['idToken'];
      tempuserId = responseData['localId'];
      _tempexpiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
          notifyListeners();

    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(email, password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDasmwGV0dfgHaRBuFUHptQp1Udwx7TPnM");

    try {
      var response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true,
          }));
      // print(json.decode(response.body));
      // error handling
      var responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      // id token
      _tempidToken = responseData['idToken'];
      tempuserId = responseData['localId'];
      _tempexpiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
          notifyListeners();

    } catch (error) {
      rethrow;
    }
  }
  // logout
  void logout () {
    _idToken = null;
    userId = null;
    _expiryDate = null;
    notifyListeners();
  }
  
}
