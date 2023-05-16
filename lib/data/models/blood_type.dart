class BloodType {
  final int? id;
  final String? uuid;
  final String? type;

  BloodType({
    this.id,
    this.uuid,
    this.type,
  });

  factory BloodType.fromJson(Map<String, dynamic> json) => BloodType(
        id: json['id'],
        uuid: json['uuid'],
        type: json['type'],
      );
}
