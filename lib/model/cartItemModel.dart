import 'package:flutter/material.dart';

class SharedData {
  List<CartItemModel> cartItemModel;

  SharedData({CartItemModel user}) {
    this.cartItemModel = cartItemModel;
  }

  SharedData.fromJson(Map<String, dynamic> json) {
    if (json['cartModel'] != null) {
      cartItemModel = new List<CartItemModel>();
      json['cartModel'].forEach((v) {
        cartItemModel.add(new CartItemModel.fromJson(v));
      });
    }
  }
}

class CartItemModel {
  int id;
  String name;
  String image;
  int amount;

  CartItemModel(
      {@required this.id,
      @required this.name,
      @required this.image,
      @required this.amount});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['image'] = this.image;
    return data;
  }
}
