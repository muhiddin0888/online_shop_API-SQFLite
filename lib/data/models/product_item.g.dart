// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) => ProductItem(
      id: json['id'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      name: json['name'] as String? ?? '',
      categoryId: json['idcategory_id'] as int? ?? 0,
      price: json['price'] as int? ?? 0,
    );

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idcategory_id': instance.categoryId,
      'price': instance.price,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };
