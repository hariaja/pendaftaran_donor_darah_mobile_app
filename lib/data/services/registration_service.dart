import 'dart:convert';

import 'package:blood_donation_app/data/models/registration.dart';
import 'package:blood_donation_app/data/request/registration_store_form.dart';
import 'package:blood_donation_app/data/services/auth_service.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:http/http.dart' as http;

class RegistrationService {
  // Index
  Future<List<Registration>> getRegistrations() async {
    try {
      final accessToken = await AuthService().getToken();
      final response = await http.get(
        Uri.parse(
          '$baseUrl/users/registrations/index',
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<Registration> registrations = List<Registration>.from(
          jsonDecode(response.body)['data'].map(
            (registration) => Registration.fromJson(registration),
          ),
        ).toList();

        return registrations;
      }

      return throw jsonDecode(response.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  // Store
  Future<dynamic> registrationStore(RegistrationStoreForm data) async {
    try {
      final accessToken = await AuthService().getToken();
      final response = await http.post(
        Uri.parse(
          '$baseUrl/users/registrations/store',
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
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
}
