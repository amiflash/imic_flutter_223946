import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:view_and_layout_sample/services/networking/APIContants.dart';

/// Network Repo will do the networking for you
/// And will also take care of parsing
/// and exception handling
/// will simply return you data model or the exception message

class APIService {
 
  Future<Map<String, dynamic>> register(
    String userName, 
    String email,
   String password) async {
    var response = await http.post(
      Uri.parse("http://localhost:3002/data"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
     body: jsonEncode(<String, dynamic> {
        'user_name': userName,
        'email': email,
        'password': password
       
    }));


    return await json.decode(response.body);
  }

  Future<Map<String, dynamic>> updateUser(
    String userName, 
    String email, 
    String avatarURL) async {
    var response = await http.post(
      Uri.parse("http://localhost:3002/data"),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    },
     body: <String, dynamic> {
        'user_name': userName,
        'email': email,
        'avatar_url': avatarURL
       
    });

    return await json.decode(response.body);
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    var response = await http.get(
      Uri.parse("http://localhost:3002/data"));

    return await json.decode(response.body);
  }
}