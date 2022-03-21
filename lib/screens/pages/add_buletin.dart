import 'package:flutter/material.dart';

class AddBuletin extends StatefulWidget {
  const AddBuletin({ Key? key }) : super(key: key);

  @override
  State<AddBuletin> createState() => _AddBuletinState();
}

class _AddBuletinState extends State<AddBuletin> {

  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _judulBuletin = TextEditingController();
  final TextEditingController _kontenBuletin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scafoldKey,
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
        "Tambah Buletin",
        style: TextStyle(color: Colors.black),
      ),
      ),

      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: ListView(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                Container(
                padding: const EdgeInsets.only(left: 25, top: 20),
                  child: const Text("Judul", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
               )
               ),
                Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                       cursorColor: Theme.of(context).cursorColor,
                       decoration:const InputDecoration(
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Colors.blue,
                                width: 10,
                              )
                         ),
                         fillColor: Colors.green,
                         hintText: 'Masukkan Judul Buletin'
                       ),  
                      controller: _judulBuletin,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Judul Tidak Boleh Kosong";
                     }
                        return null;
                     }
                     ),
                    ),
              
                    Container(
                      padding: const EdgeInsets.only(left: 25),
                      child: const Text("Konten", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    ),
              
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        minLines: 20,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorColor: Theme.of(context).cursorColor,
                        decoration:const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 10,
                              )
                            ),
                            fillColor: Colors.white,
                            hintText: "Masukkan Isi Konten"
              
                       ),  
                      controller: _kontenBuletin,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Konten Tidak Boleh Kosong";
                     }
                        return null;
                     }
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
            )
        ]),
      ),
    );
  }
}