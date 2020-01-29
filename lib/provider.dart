import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/cartItemModel.dart';
import 'dart:convert';

class Logic with ChangeNotifier {
  SharedData sharedData;
  bool _isEmpty;

  List<CartItemModel> _cartList = [];

  List<CartItemModel> get cartList {
    return [..._cartList];
  }

  //---------------------Add to SharedPreferences-------------------------------
  Future<void> addItemToCart(CartItemModel newItem) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartItems')) {
      final userData = json.encode(
        {
          'data': _cartList,
        },
      );
      prefs.setString('cartItems', userData);
    }
    final responseData =
        json.decode(prefs.getString('cartItems')) as Map<String, dynamic>;
    final List<CartItemModel> loadedItems = [];
    responseData['data'].forEach((itemData) {
      loadedItems.add(CartItemModel(
        id: itemData['id'],
        name: itemData['name'],
        image: itemData['image'],
        amount: itemData['amount'],
      ));
    });
    _cartList = loadedItems;
    int index = _cartList.indexWhere((i) => i.id == newItem.id);
    index != -1
        ? _cartList[index].amount += 1
        : _cartList.add(
            CartItemModel(
              id: newItem.id,
              image: newItem.image,
              amount: newItem.amount,
              name: newItem.name,
            ),
          );
    final userData = json.encode(
      {
        'data': _cartList,
      },
    );
    prefs.setString('cartItems', userData);
    notifyListeners();
  }

  //---------------------Fetch data from SharedPreferences----------------------
  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartItems')) {
      return null;
    }
    final responseData =
        json.decode(prefs.getString('cartItems')) as Map<String, dynamic>;
    final List<CartItemModel> loadedItems = [];
    responseData['data'].forEach((itemData) {
      loadedItems.add(CartItemModel(
        id: itemData['id'],
        name: itemData['name'],
        image: itemData['image'],
        amount: itemData['amount'],
      ));
    });
    _cartList = loadedItems;
    notifyListeners();
    return _cartList;
  }

  //--------------------------Remove amount from cart---------------------------
  Future<void> removeAmount(int id) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartItems')) {
      return null;
    }
    final responseData =
        json.decode(prefs.getString('cartItems')) as Map<String, dynamic>;
    final List<CartItemModel> loadedItems = [];
    responseData['data'].forEach((itemData) {
      loadedItems.add(CartItemModel(
        id: itemData['id'],
        name: itemData['name'],
        image: itemData['image'],
        amount: itemData['amount'],
      ));
    });
    _cartList = loadedItems;
    int index = _cartList.indexWhere((item) => item.id == id);
    _cartList[index].amount > 1
        ? _cartList[index].amount = _cartList[index].amount - 1
        : _cartList.removeAt(index);
    final userData = json.encode(
      {
        'data': _cartList,
      },
    );
    prefs.setString('cartItems', userData);
    notifyListeners();
  }

  //--------------------------Remove item from cart-----------------------------
  Future<void> removeItem(int i) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('cartItems')) {
      return null;
    }
    final responseData =
        json.decode(prefs.getString('cartItems')) as Map<String, dynamic>;
    final List<CartItemModel> loadedItems = [];
    responseData['data'].forEach((itemData) {
      loadedItems.add(CartItemModel(
        id: itemData['id'],
        name: itemData['name'],
        image: itemData['image'],
        amount: itemData['amount'],
      ));
    });
    _cartList = loadedItems;
    _cartList.removeAt(i);
    final userData = json.encode(
      {
        'data': _cartList,
      },
    );
    prefs.setString('cartItems', userData);
    notifyListeners();
  }

  //-------------------------------Empty cart-----------------------------------
  Future<void> emptyCart() async {
    _cartList = [];
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

//  void initPref() async {
//    SharedPreferences.getInstance().then((x) {
//      pref = x;
//      print(pref.get('cartItems'));
//      if (pref.get('cartItems') == null) {
//        pref.setStringList('cartItems', []);
//        print('if');
//      }
//      notifyListeners();
//    });
//  }

//  void emptyCart() async {
//    cartList.clear();
//    SharedPreferences.getInstance().then((x) {
//      pref = x;
//      pref.setStringList('cartItems', []);
//      print(':::::::::::::' + pref.getStringList('cartItems').toString());
//      notifyListeners();
//    });
//  }
}
