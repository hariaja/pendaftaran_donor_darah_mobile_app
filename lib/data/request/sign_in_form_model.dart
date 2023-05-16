class SignInForm {
  final String? email;
  final String? password;

  SignInForm({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
