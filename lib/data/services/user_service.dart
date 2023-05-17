import 'dart:convert';

import 'package:blood_donation_app/data/models/user.dart';
import 'package:blood_donation_app/data/services/auth_service.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:http/http.dart' as http;

class UserService {
  Future<User> getUserLogin() async {
    try {
      final token = await AuthService().getToken();

      final response = await http.get(
        Uri.parse(
          '$baseUrl/users/home',
        ),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body)['user']);
        return user;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
