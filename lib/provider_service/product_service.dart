import 'package:prent/model/product_model.dart';
import 'package:prent/model/category_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Category with ChangeNotifier {
  SubCatModel subCat;
  ProductModel productModel;

  Future<void> fetchData() async {
    const url = 'http://p-prent.com/api/fmeb';
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        subCat = SubCatModel.fromJson(responseData);
        notifyListeners();
        return subCat;
      }
    } catch (error) {
      throw error;
    }
  }

  //-------------------------------------------------------------------------//

  Future<void> fetchProductData(int id) async {
    String url = 'http://p-prent.com/api/category/' + id.toString() + '/models';
    try {
      var response = await http.get(url);
      var responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('success' + responseData.toString());
        productModel = ProductModel.fromJson(responseData);
        notifyListeners();
        return productModel;
      }
    } catch (error) {
      throw error;
    }
  }
}
