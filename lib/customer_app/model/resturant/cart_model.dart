import 'package:json_annotation/json_annotation.dart';
import 'package:food_delivery_app/customer_app/model/resturant/cart_list_model.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel{
  List<CartListModel> data;
  CartModel({this.data});
  factory CartModel.fromJson(Map<String, dynamic> json) =>
   _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}