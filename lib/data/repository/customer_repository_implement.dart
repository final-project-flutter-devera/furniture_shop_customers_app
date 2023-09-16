import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/data/data_source/remote/customer_firestore_service.dart';
import 'package:furniture_shop/data/repository/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerFirestoreService _userFirestoreService;

  CustomerRepositoryImpl({CustomerFirestoreService? userFirestoreService})
      : _userFirestoreService =
            userFirestoreService ?? CustomerFirestoreService();

  @override
  Future<void> addUser(Customer user) {
    return _userFirestoreService.addUser(user);
  }

  @override
  Future<void> deleteUser(String userID) {
    return _userFirestoreService.deleteUser(userID);
  }

  @override
  Future<Customer> getUser(String userID) {
    return _userFirestoreService.getUser(userID);
  }

  @override
  Future<void> updateUser(String userID,
      {List<String>? role,
      String? name,
      String? email,
      String? phone,
      String? profileimage,
      List<String>? following,
      List<Address>? shippingAddresses,
      bool? isDeleted}) {
    return _userFirestoreService.updateUser(userID,
        role: role,
        name: name,
        email: email,
        phone: phone,
        profileimage: profileimage,
        following: following,
        shippingAddresses: shippingAddresses,
        isDeleted: isDeleted);
  }
}
