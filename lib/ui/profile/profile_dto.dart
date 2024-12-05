class UpdateUserDto {
  String name;
  bool madeCane;
  int? madeCaneYear;
  String dateOfBirth;

  UpdateUserDto({
    required this.name,
    required this.madeCane,
    this.madeCaneYear,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'madeCane': madeCane,
      'madeCaneYear': madeCaneYear,
      'dateOfBirth': dateOfBirth,
    };
  }
}
