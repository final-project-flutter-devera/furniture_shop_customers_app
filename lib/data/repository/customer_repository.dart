import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/Objects/customer.dart';

abstract class CustomerRepository {
  Future<void> addUser(Customer user);
  Future<void> updateUser(
    String userID, {
    List<String>? role,
    String? name,
    String? emailAddres,
    String? phoneNumber,
    String? avatar,
    List<String>? following,
    List<Address>? shippingAddresses,
    List<String>? follower,
    bool? isDeleted,
  });
  Future<void> deleteUser(String userID);
  Future<Customer> getUser(String userID);
}
