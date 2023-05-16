import 'package:blood_donation_app/data/models/donor.dart';

class User {
  final int? id;
  final String? uuid;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? emailVerifiedAt;
  final String? avatar;
  final String? accessToken;
  final String? refreshToken;
  final Donor? donor;

  User({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.emailVerifiedAt,
    this.avatar,
    this.accessToken,
    this.refreshToken,
    this.donor,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        uuid: json['uuid'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        emailVerifiedAt: json['email_verified_at'],
        avatar: json['avatar'],
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        donor: Donor.fromJson(json['donor']),
      );

  User copyWith({
    int? id,
    String? uuid,
    String? name,
    String? email,
    String? password,
    String? phone,
    String? emailVerifiedAt,
    String? avatar,
    Donor? donor,
  }) =>
      User(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        avatar: avatar ?? this.avatar,
        accessToken: accessToken,
        refreshToken: refreshToken,
        donor: donor ?? this.donor,
      );
}
