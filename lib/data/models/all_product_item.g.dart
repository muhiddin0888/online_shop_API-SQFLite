// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllProductItem _$AllProductItemFromJson(Map<String, dynamic> json) =>
    AllProductItem(
      id: json['id'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      name: json['name'] as String? ?? '',
      categoryId: json['idcategory_id'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
    );

Map<String, dynamic> _$AllProductItemToJson(AllProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idcategory_id': instance.categoryId,
      'price': instance.price,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };
