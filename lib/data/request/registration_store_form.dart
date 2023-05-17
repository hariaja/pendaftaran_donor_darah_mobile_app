class RegistrationStoreForm {
  final String? lastDonor;
  final String? urgency;
  final String? ramadan;

  RegistrationStoreForm({
    this.lastDonor,
    this.urgency,
    this.ramadan,
  });

  Map<String, dynamic> toJson() {
    return {
      'last_donor': lastDonor,
      'urgency': urgency,
      'ramadan': ramadan,
    };
  }
}
