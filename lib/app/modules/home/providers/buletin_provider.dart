import 'dart:convert';

import 'package:get/get.dart';

import '../buletin_model.dart';

class BuletinProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Buletin.fromJson(map);
      if (map is List) {
        return map.map((item) => Buletin.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'https://lp.abpjobsite.com/api/v1/message/info';
  }

  Future<Buletin?> getBuletin(int id) async {
    final response = await get('buletin/$id');
    return response.body;
  }

  Future<Buletin?> getBuletinPage(int page) async {
    final response =
        await get('https://lp.abpjobsite.com/api/v1/message/info?page=$page');
    // print("response ${json.encode(response.body)}");
    return Buletin.fromJson((response.body));
  }

  Future<Response<Buletin>> postBuletin(Buletin buletin) async =>
      await post('buletin', buletin);
  Future<Response> deleteBuletin(int id) async => await delete('buletin/$id');
}
