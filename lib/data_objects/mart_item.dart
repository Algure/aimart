import 'dart:convert';

class MartItem{
  String? id;
  String? name;
  String? description;
  String? price;
  String? meta;
  String? picUrl;

  MartItem.fromMap(map){
    id = map['id'].toString();
    name = map['name'].toString();
    description = map['description'].toString();
    price = map['price'].toString();
    picUrl = map['picUrl'].toString();
  }

  @override
  bool operator ==(Object other) {

    if(other.runtimeType != MartItem ) return false;

    return  other is MartItem && other.id == id;
  }

  @override
  int get hashCode {
    return int.parse(id??'0');
  }
}