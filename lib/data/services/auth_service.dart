import 'dart:convert';

import 'package:blood_donation_app/data/models/user.dart';
import 'package:blood_donation_app/data/request/sign_in_form_model.dart';
import 'package:blood_donation_app/data/request/sign_up_form_model.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  // Login User
  Future<User> loginUsers(SignInForm data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/auth/login'),
        body: data.toJson(),
      );

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body)['user']);
        user = user.copyWith(password: data.password);
        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Logout User
  Future<void> logout() async {
    try {
      final token = await getToken();

      final response = await http.post(
        Uri.parse('$baseUrl/users/auth/logout'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await clearLocalStorage();
        final message = jsonDecode(response.body)['message'];
        toastSuccess(message);
        return message;
      } else {
        throw jsonDecode(response.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Save credential to local storage
  Future<void> storeCredentialToLocal(User user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'uuid', value: user.uuid);
      // await storage.write(key: 'donor_uuid', value: user.donor!.uuid);
      await storage.write(key: 'token', value: user.accessToken);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  // Read credential from storage
  Future<SignInForm> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      final SignInForm data = SignInForm(
        email: values['email'],
        password: values['password'],
      );

      return data;
    } catch (e) {
      rethrow;
    }
  }

  // Get token credential
  Future<String> getToken() async {
    String token = '';

    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      // token = 'Bearer $value';
      token = value;
    }

    return token;
  }

  // Clear data from storage if user logout
  Future<void> clearLocalStorage() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      rethrow;
    }
  }
}
