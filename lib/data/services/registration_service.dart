import 'dart:convert';

import 'package:blood_donation_app/data/request/registration_store_form.dart';
import 'package:blood_donation_app/data/services/auth_service.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:http/http.dart' as http;

class RegistrationService {
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
