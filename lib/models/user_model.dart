class UserModel {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final int credits;
  final String? profileImage;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    this.credits = 0,
    this.profileImage,
  });
}
