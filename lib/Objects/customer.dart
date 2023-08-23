import 'package:furniture_shop/Constants/enums.dart';

class Customer {
  final String id;
  final List<Role> role; // Can have multiple role?
  String name;
  String emailAddress;
  String phoneNumber;
  String? avatar;

  Customer(
      {required this.id,
      required this.role,
      required this.name,
      this.emailAddress = '',
      this.phoneNumber = '',
      this.avatar});

  //TODO: toJSON function
}
