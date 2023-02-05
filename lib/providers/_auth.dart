import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_appl/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  //doubt

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    print('1111111111111111111111111111111111');
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDv0buwtZf9UkM4r_kIF16vXWHfeqE_5Bs';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      log('inside catch block');
      log(error.toString());
      rethrow;
    }
    //print('22222222222222222222222222222222');
    //print(json.decode(response.body.toString()));
  }

  Future<void> signUp(String email, String password) async {
    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDv0buwtZf9UkM4r_kIF16vXWHfeqE_5Bs';
    // final response = await http.post(Uri.parse(url),
    //     body: json.encode(
    //         {
    //           'email': email,
    //           'password': password,
    //           'returnSecureToken': true
    //         }
    //         )
    // );
    // print(json.decode(response.body));
    await _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    // const url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDv0buwtZf9UkM4r_kIF16vXWHfeqE_5Bs';
    // final response = await http.post(Uri.parse(url),
    //     body: json.encode(
    //         {
    //           'email': email,
    //           'password': password,
    //           'returnSecureToken': true
    //         }
    //     )
    // );
    // print(json.decode(response.body));
    await _authenticate(email, password, 'signInWithPassword');
  }
}
