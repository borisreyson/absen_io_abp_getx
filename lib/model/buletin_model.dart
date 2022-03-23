import 'dart:convert';
import 'dart:math';
import 'package:flutter/src/widgets/basic.dart';
import 'package:http/http.dart' as http;

class ApiBuletin {
  List <ListBuletin>? info;

  ApiBuletin({required this.info});

    factory ApiBuletin.fromJson(Map<String, dynamic> object){
      return ApiBuletin(
        info: (object["message_info"] as List).map((b) => ListBuletin.fromJson(b)).toList()
      );   
    }

  static Future<ApiBuletin> getBuletin() async {
    var url = Uri.parse("https://lp.abpjobsite.com/api/message/info");
    var apiWeb = await http.get(url);
    var objekJson = json.decode(apiWeb.body); 
    return ApiBuletin.fromJson(objekJson);  
  }
}

class ListBuletin {
  int? id_info;
  String? judul;
  String? pesan;
  String? tgl;
  int? status;

  ListBuletin({
    this.id_info,
    this.judul,
    this.pesan,
    this.tgl,
    this.status
    });

  factory ListBuletin.fromJson(Map<String, dynamic> objek) {
    return ListBuletin(
      id_info: objek["id_info"],
      judul: objek["judul"],
      pesan: objek["pesan"],
      tgl: objek["tgl"],
      status: objek["status"],
    );
  }
}
