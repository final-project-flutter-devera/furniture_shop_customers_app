import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/Objects/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
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
  Future<User> getUser(String userID);
}
