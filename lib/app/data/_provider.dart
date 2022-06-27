import 'package:get/get.dart';

class Provider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://lp.abpjobsite.com/api/v1/';
  
  }
}
