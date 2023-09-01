import 'package:flutter/material.dart';
import 'package:furniture_shop/Objects/user.dart';
import 'package:furniture_shop/Providers/Auth_reponse.dart';
import 'package:furniture_shop/data/repository/user_repository.dart';
import 'package:furniture_shop/data/repository/user_repository_implement.dart';

class UserProvider extends ChangeNotifier {
  late UserRepository _userRepository;
  UserProvider() {
    _userRepository = UserRepositoryImpl();
    _init();
  }
  late String selfID;
  _init() {
    selfID = AuthRepo.uid;
    notifyListeners();
  }

  void addUser(User user) async {
    await _userRepository.addUser(user);
    notifyListeners();
  }

  void getUser(String userID) async {
    await _userRepository.getUser(userID);
    notifyListeners();
  }

  void followVendor(String buyerID, String vendorID) async {
    final buyerFuture = _userRepository.getUser(buyerID);
    final vendorFuture = _userRepository.getUser(vendorID);
    final buyer = await buyerFuture;
    final vendor = await vendorFuture;
    buyer.following.add(vendorID);
    vendor.follower.add(buyerID);
    await Future.wait([
      _userRepository.updateUser(buyerID, following: buyer.following),
      _userRepository.updateUser(vendorID, follower: vendor.follower),
    ]);
    notifyListeners();
  }
}
