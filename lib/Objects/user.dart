class User {
  final String id;
  final List<String> role; // Can have multiple role?
  String name;
  String? emailAddress;
  String phoneNumber;
  String? avatar;
  bool isDeleted;

  User({
    required this.id,
    required this.role,
    required this.name,
    this.emailAddress,
    this.phoneNumber = '',
    this.avatar,
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'isDeleted': isDeleted,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'] as String,
        role: json['role'] as List<String>,
        name: json['name'] as String,
        emailAddress: json['emailAddress'] as String?,
        phoneNumber: json['phoneNumber'] as String,
        avatar: json['avatar'] as String?,
        isDeleted: json['isDeleted'] as bool);
  }
}
