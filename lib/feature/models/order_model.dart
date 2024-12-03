import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../managers/orders_cubit/orders_cubit.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "isActive")
  final bool? isActive;
  @JsonKey(name: "price")
  final String? price;
  @JsonKey(name: "company")
  final String? company;
  @JsonKey(name: "picture")
  final String? picture;
  @JsonKey(name: "buyer")
  final String? buyer;
  @JsonKey(name: "tags")
  final List<String>? tags;
  @JsonKey(name: "status", fromJson: fromStringStatus)
  final OrderStatus? status;
  @JsonKey(name: "registered")
  final DateTime? registered;

  OrderModel({
    this.id,
    this.isActive,
    this.price,
    this.company,
    this.picture,
    this.buyer,
    this.tags,
    this.status,
    this.registered,
  });

  static OrderStatus fromStringStatus(String value) {
    return OrderStatus.values.firstWhere(
      (element) => element.value == value,
      orElse: () => OrderStatus.delivered,
    );
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return _$OrderModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrderModelToJson(this);
  }

  factory OrderModel.fromString(String jsonString) {
    return OrderModel.fromJson(jsonDecode(jsonString));
  }
}
