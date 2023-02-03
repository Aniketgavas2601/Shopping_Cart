import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signUp(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDv0buwtZf9UkM4r_kIF16vXWHfeqE_5Bs';
    final response = await http.post(Uri.parse(url),
        body: json.encode(
            {
              'email': email,
              'password': password,
              'returnSecureToken': true
            }
            )
    );
    print(json.decode(response.body));
  }
}