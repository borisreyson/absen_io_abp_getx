import 'package:flutter/material.dart';

class AddDepartemen extends StatefulWidget {
  const AddDepartemen({ Key? key }) : super(key: key);

  @override
  State<AddDepartemen> createState() => _AddDepartemenState();
}

class _AddDepartemenState extends State<AddDepartemen> {
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
        "Tambah Departemen",
        style: TextStyle(color: Colors.black),
      ),
      ),

    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,  
                labelText: "ID Departemen",                      
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,  
                labelText: "Departemen",
                hintText: "Masukkan nama departemen"                      
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 19, right: 19, top: 5),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  onPressed: (){
            
                  }, child: const Text("Simpan",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),), 
                ),
              ),
            ),
          )
        ],
      ),
    ),  
    );
  }
}