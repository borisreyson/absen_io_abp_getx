import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  XFile? _foto;
  var imagePicker = ImagePicker();

  Future getImageGallery() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _foto = imageFile;
    });
  }

  Future getImageCamera() async {
    var imageFile = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _foto = imageFile;
    });
  }


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
        "Profile",
        style: TextStyle(color: Colors.black),
      ),
      ),

    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 500,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                       elevation: 8,
                       shape: CircleBorder(),
                       child: Padding(
                         padding: const EdgeInsets.only(right: 110, left: 110),
                         child: Container(
                           width: 60,
                           height: 179,
                           child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                  showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Pilih Foto"),
                                    actions: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 210),
                                            child: TextButton(onPressed: (){
                                                    getImageCamera();
                                                    Navigator.of(context).pop();
                                            }, child: Text("Kamera",
                                            style: TextStyle(color: Colors.blue, fontSize: 16))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 222),
                                            child: TextButton(onPressed: (){
                                                    getImageGallery();
                                                    Navigator.of(context).pop();
                                            }, child: Text("Galeri", 
                                            style: TextStyle(color: Colors.blue, fontSize: 16))),
                                          ),
                                        ],
                                      ),
                                      
                                    ],
                                  );
                                });  
                              }, child: Icon(Icons.add_a_photo, size: 50),
                            ),
                          ),
                        ),
                       ),
                     ),
                ),

                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Hendra", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    ListTile(
                      leading: Icon(Icons.format_list_numbered),
                      title: Text("220202323", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    ListTile(
                      leading: Icon(Icons.business),
                      title: Text("HCGA", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),

                    ListTile(
                      leading: Icon(Icons.business_center_rounded),
                      title: Text("IT Staff", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),  
    );
  }
}