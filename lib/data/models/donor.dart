import 'package:blood_donation_app/data/models/blood_type.dart';

class Donor {
  final int? id;
  final String? uuid;
  final int? userId;
  final int? bloodTypeId;
  final String? nik;
  final String? gender;
  final String? rhesus;
  final String? birthDate;
  final int? age;
  final String? jobTitle;
  final String? address;
  final BloodType? bloodType;

  Donor({
    this.id,
    this.uuid,
    this.userId,
    this.bloodTypeId,
    this.nik,
    this.gender,
    this.rhesus,
    this.birthDate,
    this.age,
    this.jobTitle,
    this.address,
    this.bloodType,
  });

  factory Donor.fromJson(Map<String, dynamic> json) => Donor(
        id: json['id'],
        uuid: json['uuid'],
        userId: json['user_id'],
        bloodTypeId: json['blood_type_id'],
        nik: json['nik'],
        gender: json['gender'],
        rhesus: json['rhesus'],
        birthDate: json['birth_date'],
        age: json['age'],
        jobTitle: json['job_title'],
        address: json['address'],
        bloodType: BloodType.fromJson(json['blood_type']),
      );

  Donor copyWith({
    int? bloodTypeId,
    String? nik,
    String? gender,
    String? rhesus,
    String? birthDate,
    String? jobTitle,
    String? address,
    BloodType? bloodType,
  }) =>
      Donor(
        id: id,
        uuid: uuid,
        userId: userId,
        bloodTypeId: bloodTypeId ?? this.bloodTypeId,
        nik: nik ?? this.nik,
        gender: gender ?? this.gender,
        rhesus: rhesus ?? this.rhesus,
        age: age,
        jobTitle: jobTitle ?? this.jobTitle,
        address: address ?? this.address,
        bloodType: bloodType ?? this.bloodType,
      );
}
