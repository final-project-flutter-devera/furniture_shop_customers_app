import 'package:flutter/material.dart';
import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/Providers/Auth_reponse.dart';
import 'package:furniture_shop/data/repository/customer_repository.dart';
import 'package:furniture_shop/data/repository/customer_repository_implement.dart';

class CustomerProdivder extends ChangeNotifier {
  late CustomerRepository _userRepository;
  CustomerProdivder() {
    _userRepository = CustomerRepositoryImpl();
    _init();
  }
  _init() {
    notifyListeners();
  }

  String getID() {
    return AuthRepo.uid;
  }

  void addUser(Customer user) async {
    await _userRepository.addUser(user);
    notifyListeners();
  }

  Future<Customer> getCurrentUser() async {
    Customer user;
    user = await _userRepository.getUser(getID());
    notifyListeners();
    return user;
  }

  Future<Customer> getUser(String userID) async {
    Customer user;
    user = await _userRepository.getUser(userID);
    notifyListeners();
    return user;
  }

  ///Call updateUser instead
  // void followVendor(String buyerID, String vendorID) async {
  //   final buyerFuture = _userRepository.getUser(buyerID);
  //   final vendorFuture = _userRepository.getUser(vendorID);
  //   final buyer = await buyerFuture;
  //   final vendor = await vendorFuture;

  //   buyer.following.add(vendorID);
  //   vendor.follower.add(buyerID);
  //   await Future.wait([
  //     _userRepository.updateUser(buyerID, following: buyer.following),
  //     _userRepository.updateUser(vendorID, follower: vendor.follower),
  //   ]);
  //   notifyListeners();
  // }

  void updateUser(
      {List<String>? role,
      String? name,
      String? emailAddres,
      String? phoneNumber,
      String? avatar,
      List<String>? following,
      List<Address>? shippingAddress,
      List<String>? follower,
      bool? isDeleted}) {
    _userRepository.updateUser(getID(),
        role: role,
        name: name,
        emailAddres: emailAddres,
        phoneNumber: phoneNumber,
        avatar: avatar,
        follower: follower,
        following: following,
        shippingAddresses: shippingAddress,
        isDeleted: isDeleted);
  }
}
