class SignUpForm {
  final String? name;
  final String? nik;
  final String? gender;
  final String? bloodTypeId;
  final String? rhesus;
  final String? birthDate;
  final String? jobTitle;
  final String? phone;
  final String? email;
  final String? password;
  final String? passwordConfirmation;
  final String? address;

  SignUpForm({
    this.name,
    this.nik,
    this.gender,
    this.bloodTypeId,
    this.rhesus,
    this.birthDate,
    this.jobTitle,
    this.phone,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nik': nik,
      'gender': gender,
      'blood_type_id': bloodTypeId,
      'rhesus': rhesus,
      'birth_date': birthDate,
      'job_title': jobTitle,
      'phone': phone,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'address': address,
    };
  }

  SignUpForm copyWith({
    String? name,
    String? nik,
    String? gender,
    String? bloodTypeId,
    String? rhesus,
    String? birthDate,
    String? jobTitle,
    String? phone,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? address,
  }) =>
      SignUpForm(
        name: name ?? this.name,
        nik: nik ?? this.nik,
        gender: gender ?? this.gender,
        bloodTypeId: bloodTypeId ?? this.bloodTypeId,
        rhesus: rhesus ?? this.rhesus,
        birthDate: birthDate ?? this.birthDate,
        jobTitle: jobTitle ?? this.jobTitle,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        address: address ?? this.address,
      );
}
