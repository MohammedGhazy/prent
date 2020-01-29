import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
class SubCatModel {
  List<Data> data;
  SharedPreferences pref;
  SubCatModel({this.data});

  SubCatModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int id;
  String name;
  String images;
  List<Models> models;

  Data({this.id, this.name, this.images, this.models});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'];
    if (json['models'] != null) {
      models = new List<Models>();
      json['models'].forEach((v) {
        models.add(new Models.fromJson(v));
      });
    }
  }
}

class Models {
  int id;
  String modelName;
  String description;
  String howToUse;
  String driver;
  String type;
  String size;
  int checkTimes;
  List<Features> features;
  List<myImages> images;

  Models(
      {this.id,
        this.modelName,
        this.description,
        this.howToUse,
        this.driver,
        this.type,
        this.size,
        this.checkTimes,
        this.features,
        this.images});

  Models.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelName = json['model_name'];
    description = json['description'];
    howToUse = json['how_to_use'];
    driver = json['driver'];
    type = json['type'];
    size = json['size'];
    checkTimes = json['checkTimes'];
    if (json['features'] != null) {
      features = new List<Features>();
      json['features'].forEach((v) {
        features.add(new Features.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = new List<myImages>();
      json['images'].forEach((v) {
        images.add(new myImages.fromJson(v));
      });
    }
  }
}

class Features {
  int id;
  String feature;

  Features({this.id, this.feature});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feature = json['feature'];
  }
}

class myImages {
  int id;
  String images;

  myImages({this.id, this.images});

  myImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
  }
}

