import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_shop/Objects/address.dart';
import 'package:furniture_shop/Objects/customer.dart';
import 'package:furniture_shop/data/data_source/customer_data_service.dart';

class CustomerFirestoreService implements CustomerDataService {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('Customers');
  @override
  Future<void> addUser(Customer customer) {
    return customers
        .doc(customer.cid)
        .set(customer.toJson())
        .then((value) => debugPrint('Added a User with ID: ${customer.cid}'))
        .catchError((error) => debugPrint('Failed to add a User: $error'));
  }

  @override

  ///DO NOT USE WHEN USER REQUEST TO DELETE. To delete a user set flag isDeleted to true
  Future<void> deleteUser(String customerID) {
    return customers
        .doc(customerID)
        .delete()
        .then((value) => debugPrint('Deleted a user with ID: $customerID'))
        .catchError((error) => debugPrint('Failed to delete a user: $error'));
  }

  @override
  Future<Customer> getUser(String customerID) async {
    Customer? user;
    await customers.doc(customerID).get().then((querySnapshot) {
      debugPrint('Get user $customerID successfully');
      user = Customer.fromJson(querySnapshot.data() as Map<String, dynamic>);
    });
    return Future.value(user);
  }

  @override
  Future<void> updateUser(
    String customerID, {
    List<String>? role,
    String? name,
    String? email,
    String? phone,
    String? profileimage,
    List<String>? following,
    List<Address>? shippingAddresses,
    bool? isDeleted,
  }) {
    final updates = {
      if (role != null) 'role': role,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (profileimage != null) 'profileimage': profileimage,
      if (following != null) 'following': following,
      if (shippingAddresses != null)
        'shippingAddress': shippingAddresses.map((e) => e.toJson()),
      if (isDeleted != null) 'isDeleted': isDeleted,
    };
    if (updates.isNotEmpty) {
      return customers
          .doc(customerID)
          .update(updates)
          .then((value) => debugPrint('Updated a user: $customerID'))
          .catchError((error) => debugPrint('Failed to update a user: $error'));
    } else {
      debugPrint('Nothing to update');
      return Future.value(null);
    }
  }
}
