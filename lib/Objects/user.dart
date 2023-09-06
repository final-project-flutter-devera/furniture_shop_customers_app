import 'package:furniture_shop/Objects/address.dart';

class User {
  final String id;
  final List<String> role; // Can have multiple role?
  String name;
  String? emailAddress;
  String phoneNumber;
  String? avatar;
  List<String> following = [];
  List<String> follower = [];
  List<Address> shippingAddresses;
  bool isDeleted;

  User(
      {required this.id,
      required this.role,
      required this.name,
      this.emailAddress,
      this.phoneNumber = '',
      this.avatar,
      this.isDeleted = false,
      this.following = const [],
      this.follower = const [],
      this.shippingAddresses = const []});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'emailAddress': emailAddress,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'following': following,
      'follower': follower,
      'isDeleted': isDeleted,
      //TODO: TO JSON FOR SHIPPING ADDRESS
      'shippingAddresses': shippingAddresses.map(
        (e) => e.toJson(),
      )
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
      follower: json['follower'] as List<String>,
      following: json['following'] as List<String>,
      isDeleted: json['isDeleted'] as bool,
      shippingAddresses: (json['shippingAddresses'] as List<dynamic>)
          .map((e) => Address.fromJson(e))
          .toList(),
    );
  }
}
