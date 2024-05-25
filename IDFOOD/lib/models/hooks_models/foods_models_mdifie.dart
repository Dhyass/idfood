// To parse this JSON data, do
//
//     final foodsModel = foodsModelFromJson(jsonString);

import 'dart:convert';

List<FoodsModelMod> foodsModelModFromJson(String str) => List<FoodsModelMod>.from(json.decode(str).map((x) => FoodsModelMod.fromJson(x)));

String foodsModelModToJson(List<FoodsModelMod> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodsModelMod {
  String id;
  String title;
  String time;
  List<String> foodTags;
  String category;
  List<String> foodType;
  String code;
  bool isVailabele;
  String restaurant;
  int rating;
  String ratingCount;
  String description;
  double price;
  Map<String, dynamic> additives; // Changer le type de List à Map
  Map<String, dynamic> imageUrl; // Changer le type de List à Map

  FoodsModelMod({
    required this.id,
    required this.title,
    required this.time,
    required this.foodTags,
    required this.category,
    required this.foodType,
    required this.code,
    required this.isVailabele,
    required this.restaurant,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.price,
    required this.additives,
    required this.imageUrl,
  });

  factory FoodsModelMod.fromJson(Map<String, dynamic> json) => FoodsModelMod(
    id: json["_id"],
    title: json["title"],
    time: json["time"],
    foodTags: List<String>.from(json["foodTags"].map((x) => x)),
    category: json["category"],
    foodType: List<String>.from(json["foodType"].map((x) => x)),
    code: json["code"],
    isVailabele: json["isVailabele"],
    restaurant: json["restaurant"],
    rating: json["rating"],
    ratingCount: json["ratingCount"],
    description: json["description"],
    price: json["price"]?.toDouble(),
    additives: json["additives"], // Utiliser directement la valeur JSON sans mappage
    imageUrl: json["imageUrl"], // Utiliser directement la valeur JSON sans mappage
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "time": time,
    "foodTags": List<dynamic>.from(foodTags.map((x) => x)),
    "category": category,
    "foodType": List<dynamic>.from(foodType.map((x) => x)),
    "code": code,
    "isVailabele": isVailabele,
    "restaurant": restaurant,
    "rating": rating,
    "ratingCount": ratingCount,
    "description": description,
    "price": price,
    "additives": additives, // Utiliser directement la valeur JSON sans mappage
    "imageUrl": imageUrl, // Utiliser directement la valeur JSON sans mappage
  };
}


class Additive {
  int id;
  String title;
  String price;

  Additive({
    required this.id,
    required this.title,
    required this.price,
  });

  factory Additive.fromJson(Map<String, dynamic> json) => Additive(
    id: json["id"],
    title: json["title"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
  };
}
