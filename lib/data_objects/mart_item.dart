class MartItem{
  String? name;
  String? description;
  String? price;
  String? meta;
  String? picUrl;

  MartItem.fromMap(map){
    name = map['name'].toString();
    description = map['description'].toString();
    price = map['price'].toString();
    picUrl = map['picUrl'].toString();
  }
}