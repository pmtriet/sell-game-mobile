import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_order_model.freezed.dart';
part 'info_order_model.g.dart';

@freezed
class InfoOrderModel with _$InfoOrderModel {
  const factory InfoOrderModel({
    required int orderId,
    required String orderCode,
    required DateTime orderTime,
    required int totalPayment,
    required double discountCode,
    required int finalPrice,
    required String imagePath,  
    required String title,      
    required String gameName,   
    required String productId,  
    required int price,      
    required String heroes,     
    required String skins,      
    required String rank,       
  }) = _InfoOrderModel;

  factory InfoOrderModel.fromJson(Map<String, dynamic> json) => _$InfoOrderModelFromJson(json);
}
