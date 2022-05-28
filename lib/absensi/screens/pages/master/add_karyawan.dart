import 'package:flutter/material.dart';

class FormKaryawan extends StatefulWidget {
  const FormKaryawan({ Key? key }) : super(key: key);

  @override
  State<FormKaryawan> createState() => _FormKaryawanState();
}

class _FormKaryawanState extends State<FormKaryawan> {

  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String? _departemen;
  String? _divisi;
  String? _perusahaan;

  List <String> itemDepartemen = [
    '--Pilih Departemen--',
    'HCGA',
    'HSE',
  ];

  List <String> itemDivisi = [
    '--Pilih Jabatan--',
    'IT',
    'Admin',
    'GL'
  ];

  List <String> itemPerusahaan = [
    '--Pilih Perusahaan--',
    'MTK',
    'PT.ABP',
    'MNK'
  ];

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
        "Tambah Karyawan",
        style: TextStyle(color: Colors.black),
      ),
      ),

    body: Form( key: _formKey,
    autovalidateMode: AutovalidateMode.always,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Column(
              children: <Widget> [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,  
                    labelText: "NIK",
                    hintText: "Masukkan NIK Karyawan"                       
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
                    labelText: "Nama",
                    hintText: "Masukkan Nama Karyawan"                       
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: _departemen, style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "Departemen",
                      floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                      items: itemDepartemen.map<DropdownMenuItem<String>> ((String a){
                          return DropdownMenuItem<String> (
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        hint: const Text("--Pilih Departemen--"),
                        onChanged: (String? b){
                          setState(() {
                            _departemen = b; 
                          });
                        
                        }),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: _divisi, style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "Divisi",
                      floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                      items: itemDivisi.map<DropdownMenuItem<String>> ((String a){
                          return DropdownMenuItem<String> (
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        hint: const Text("--Pilih Divisi--"),
                        onChanged: (String? b){
                          setState(() {
                            _divisi = b; 
                          });
                        
                        }),
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
                    labelText: "Jabatan",
                    hintText: "Masukkan Jabatan Karyawan"                       
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      value: _perusahaan, style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      labelText: "Perusahaan",
                      floatingLabelBehavior: FloatingLabelBehavior.always
                      ),
                      items: itemPerusahaan.map<DropdownMenuItem<String>> ((String a){
                          return DropdownMenuItem<String> (
                            value: a,
                            child: Text(a),
                          );
                        }).toList(),
                        hint: const Text("--Pilih Perusahaan--"),
                        onChanged: (String? b){
                          setState(() {
                            _perusahaan = b; 
                          });
                        
                        }),
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
          )
        ],
      )
      ),  
    );
  }
}