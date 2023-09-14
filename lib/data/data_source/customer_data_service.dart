import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/Objects/customer.dart';

abstract class CustomerDataService {
  Future<void> addUser(Customer user);
  Future<void> updateUser(
    String userID, {
    List<String>? role,
    String? name,
    String? emailAddres,
    String? phoneNumber,
    String? avatar,
    List<String>? following,
    List<String>? follower,
    List<Address>? shippingAddresses,
    bool? isDeleted,
  });
  Future<void> deleteUser(String userID);
  Future<Customer> getUser(String userID);
}
