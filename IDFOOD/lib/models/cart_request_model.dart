// To parse this JSON data, do
//
//     final cartRequestModel = cartRequestModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CartRequestModel cartRequestModelFromJson(String str) => CartRequestModel.fromJson(json.decode(str));

String cartRequestModelToJson(CartRequestModel data) => json.encode(data.toJson());

class CartRequestModel {
  final String productId;
  final List<String> additives;
  final int quantity;
  final double totalPrice;

  CartRequestModel({
    required this.productId,
    required this.additives,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartRequestModel.fromJson(Map<String, dynamic> json) => CartRequestModel(
    productId: json["productId"],
    additives: List<String>.from(json["additives"].map((x) => x)),
    quantity: json["quantity"],
    totalPrice: json["totalPrice"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "additives": List<dynamic>.from(additives.map((x) => x)),
    "quantity": quantity,
    "totalPrice": totalPrice,
  };
}
