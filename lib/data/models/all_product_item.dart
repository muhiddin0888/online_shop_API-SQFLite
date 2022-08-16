import 'package:json_annotation/json_annotation.dart';

//TODO bu satrni commentdan chiqarish esdan chiqmasin!
part 'all_product_item.g.dart';

// "id": 1,
// "category_id": 1,
// "name": "Macbook",
// "price": 1200,
// "image_url": "https://e7.pngegg.com/pngimages/765/477/png-clipart-macbook-macbook.png"

@JsonSerializable()
class AllProductItem {
  //TODO 3 AllProductItem klasini yozib .g file generate qilinsin!
  @JsonKey(defaultValue: 0, name: 'id')
  int id;

  @JsonKey(defaultValue: 0, name: 'idcategory_id')
  int categoryId;

  @JsonKey(defaultValue: 0, name: 'price')
  int price;

  @JsonKey(defaultValue: '', name: 'name')
  String name;

  @JsonKey(defaultValue: '', name: 'image_url')
  String imageUrl;

  AllProductItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.categoryId,
    required this.price,
  });

  factory AllProductItem.fromJson(Map<String, dynamic> json) =>
      _$AllProductItemFromJson(json);

  Map<String, dynamic> toJson() => _$AllProductItemToJson(this);

  @override
  String toString() => '''
      lat:$name,
      lon:$imageUrl,
  ''';
}
