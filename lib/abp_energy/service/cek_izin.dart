import 'package:flutter/material.dart';

class CekIzin extends StatefulWidget {
  const CekIzin({ Key? key }) : super(key: key);

  @override
  State<CekIzin> createState() => _CekIzinState();
}

class _CekIzinState extends State<CekIzin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Perizinan")),
    );
  }
}