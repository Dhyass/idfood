// To parse this JSON data, do
//
//     final restaurantModel = restaurantModelFromJson(jsonString);

import 'dart:convert';

List<RestaurantModel> restaurantModelFromJson(String str) => List<RestaurantModel>.from(json.decode(str).map((x) => RestaurantModel.fromJson(x)));

String restaurantModelToJson(List<RestaurantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantModel {
  String id;
  String title;
  String time;
  String imageUrl;
  List<Food> foods;
  bool pickup;
  bool delivery;
  bool isAvailable;
  String owner;
  String code;
  String logoUrl;
  int rating;
  String ratingCount;
  String verification;
  String verificationMessage;
  Coords coords;

  RestaurantModel({
    required this.id,
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.foods,
    required this.pickup,
    required this.delivery,
    required this.isAvailable,
    required this.owner,
    required this.code,
    required this.logoUrl,
    required this.rating,
    required this.ratingCount,
    required this.verification,
    required this.verificationMessage,
    required this.coords,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    id: json["_id"],
    title: json["title"],
    time: json["time"],
    imageUrl: json["imageUrl"],
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    pickup: json["pickup"],
    delivery: json["delivery"],
    isAvailable: json["isAvailable"],
    owner: json["owner"],
    code: json["code"],
    logoUrl: json["logoUrl"],
    rating: json["rating"],
    ratingCount: json["ratingCount"],
    verification: json["verification"],
    verificationMessage: json["verificationMessage"],
    coords: Coords.fromJson(json["coords"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "time": time,
    "imageUrl": imageUrl,
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "pickup": pickup,
    "delivery": delivery,
    "isAvailable": isAvailable,
    "owner": owner,
    "code": code,
    "logoUrl": logoUrl,
    "rating": rating,
    "ratingCount": ratingCount,
    "verification": verification,
    "verificationMessage": verificationMessage,
    "coords": coords.toJson(),
  };
}

class Coords {
  String id;
  double latitude;
  double longitude;
  double latitudeDelta;
  double? longitudeDelta;
  String address;
  String title;

  Coords({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.latitudeDelta,
    this.longitudeDelta,
    required this.address,
    required this.title,
  });

  factory Coords.fromJson(Map<String, dynamic> json) => Coords(
    id: json["id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    latitudeDelta: json["latitudeDelta"]?.toDouble(),
    longitudeDelta: json["longitudeDelta"]?.toDouble(),
    address: json["address"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "latitude": latitude,
    "longitude": longitude,
    "latitudeDelta": latitudeDelta,
    "longitudeDelta": longitudeDelta,
    "address": address,
    "title": title,
  };
}

class Food {
  Food();

  factory Food.fromJson(Map<String, dynamic> json) => Food(
  );

  Map<String, dynamic> toJson() => {
  };
}
