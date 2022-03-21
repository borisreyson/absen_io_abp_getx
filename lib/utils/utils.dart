import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
class Utils{
  Route createRoute(Function() nameClass) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nameClass(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  Future<bool> pingServer()async{
    try{
      var uri = Uri.parse("https://google.co.id");
      http.Response api = await http.get(uri).timeout(Duration(seconds: 5));
      print("pingGoogle ${api.statusCode}");
      if(api.statusCode<200 || api.statusCode>299){
        return false;
      }
      return true;
    }on TimeoutException catch(e){
      print("pingGoogle ${e}");
      return false;
    }on SocketException catch(e){
      print("pingGoogle ${e}");
      return false;
    }on Error catch(e){
      print("pingGoogle ${e}");
      return false;
    }
  }

  Future<bool> pingServerLokal()async{
    try{
      var uri = Uri.parse("http://10.10.3.13");
      http.Response api = await http.get(uri).timeout(Duration(seconds: 5));
      print("pingLokal ${api.statusCode}");
      if(api.statusCode<200 || api.statusCode>299){
        return false;
      }
      return true;
    }on TimeoutException catch(e){
      print("pingLokal ${e}");
      return false;
    }on SocketException catch(e){
      print("pingLokal ${e}");
      return false;
    }on Error catch(e){
      print("pingLokal ${e}");
      return false;
    }
  }
  Future<bool> pingServerOnline()async{
    try{
      var uri = Uri.parse("https://abpjobsite.com");
      http.Response api = await http.get(uri).timeout(Duration(seconds: 5));
      print("pingStatus ${api.statusCode}");
      if(api.statusCode<200 || api.statusCode>299){
        return false;
      }
      return true;
    }on TimeoutException catch(e){
      print("pingStatus ${e}");
      return false;
    }on SocketException catch(e){
      print("pingStatus ${e}");
      return false;
    }on Error catch(e){
      print("pingStatus ${e}");
      return false;
    }
  }
}