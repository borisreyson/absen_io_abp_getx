import 'package:flutter/material.dart';

class DetailBuletin extends StatefulWidget {
  const DetailBuletin({ Key? key }) : super(key: key);

  @override
  State<DetailBuletin> createState() => _DetailBuletinState();
}

class _DetailBuletinState extends State<DetailBuletin> {

  String buletin = ("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
         elevation: 0,
         leading: InkWell(
         splashColor: const Color(0xff000000),
         child: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xff000000),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      ),
      title: const Text(
        "Judul Buletin",
        style: TextStyle(color: Colors.black),
      ),
      ),
      
      body: ListView(
        children: <Widget> [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(buletin, style: TextStyle(fontSize: 16)),
                      )
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      )
    );
  }
}