import 'dart:convert';

import 'package:blood_donation_app/data/request/sign_up_form_model.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Check email
  Future<bool> checkEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/users/register/check-email',
        ),
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['is_email_exist'];
      } else {
        return jsonDecode(response.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Check Nik
  Future<bool> checkNik(String nik) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/users/register/check-nik',
        ),
        body: {
          'nik': nik,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['is_nik_exist'];
      } else {
        return jsonDecode(response.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Check Phone
  Future<bool> checkPhone(String phone) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/users/register/check-phone',
        ),
        body: {
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['is_phone_exist'];
      } else {
        return jsonDecode(response.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Register User
  Future<dynamic> registerUsers(SignUpForm data) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$baseUrl/users/register/store',
        ),
        headers: {
          'Accept': 'application/json',
        },
        body: data.toJson(),
      );

      print(response.body);

      if (response.statusCode == 200) {
        final message = jsonDecode(response.body)['message'];
        toastSuccess(message);
        return message;
      } else {
        return jsonDecode(response.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
