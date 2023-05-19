import 'package:blood_donation_app/data/models/user.dart';

class Registration {
  final int? id;
  final String? uuid;
  final int? userId;
  final String? number;
  final String? lastDonor;
  final String? returnDonor;
  final String? urgency;
  final String? ramadan;
  final String? status;
  final String? message;
  final User? user;

  Registration({
    this.id,
    this.uuid,
    this.userId,
    this.number,
    this.lastDonor,
    this.returnDonor,
    this.urgency,
    this.ramadan,
    this.status,
    this.message,
    this.user,
  });

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json['id'],
        uuid: json['uuid'],
        userId: json['user_id'],
        number: json['number'],
        lastDonor: json['last_donor'],
        returnDonor: json['return_donor'],
        urgency: json['urgency'],
        ramadan: json['ramadan'],
        status: json['status'],
        message: json['message'],
        // user: User.fromJson(json['user']),
      );
}
