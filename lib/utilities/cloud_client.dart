import 'dart:convert';

import 'package:aimart/data_objects/mart_item.dart';
import 'package:aimart/utilities/constants.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CloudClient{
  CloudClient._privateConstructor();

  static final CloudClient _instance = CloudClient._privateConstructor();

  factory CloudClient() {
    return _instance;
  }

  Future<List<MartItem>> searchForItem(String searchText) async {
    var headers = {
      'api-key': APIKEY
    };
    var request = Request('GET', Uri.parse(SEARCH_DOMAIN+'/docs?api-version=2020-06-30-Preview&search=$searchText'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    String result = await response.stream.bytesToString();
    print ('MartItem: ${response.statusCode},  result: $result,');

    if (response.statusCode >= 400) {
      throw Exception(result);
    }
    List<MartItem> martList = [];
    for(var data in jsonDecode(result)['value']){
      martList.add(MartItem.fromMap(data));
    }
    return martList;
  }

   describeImage(String imageUrl) async {

     var request = http.Request('GET',
        Uri.parse(FLASK_HOME+'analyse?url=$imageUrl'));

    print('FLASK_HOME: ' + FLASK_HOME);

    StreamedResponse response = await request.send();

    String result = await response.stream.bytesToString();
    print ('describeImage: ${response.statusCode},  result: $result,');

    if (response.statusCode >= 400) {
      throw Exception(result);
    }
    return jsonDecode(result);
  }

}