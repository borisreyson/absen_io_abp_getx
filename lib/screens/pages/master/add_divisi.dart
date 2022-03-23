import 'package:flutter/material.dart';

class AddDivisi extends StatefulWidget {
  const AddDivisi({ Key? key }) : super(key: key);

  @override
  State<AddDivisi> createState() => _AddDivisiState();
}

class _AddDivisiState extends State<AddDivisi> {
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

    body: Container(
      child: Padding(
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
                  labelText: "ID Divisi",                      
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
                  labelText: "Divisi",
                  hintText: "Masukkan nama divisi"                      
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
              
                    }, child: Text("Simpan",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),), 
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),  
    );
  }
}