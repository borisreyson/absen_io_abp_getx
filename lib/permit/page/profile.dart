import 'package:face_id_plus/permit/form/ubah_profile.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        idCard(context),
        profileData(),
        buttonOption(),
      ],
    );
  }

  Widget buttonOption() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: InkWell(
                      onTap: () {
                        Constants().goTo(() => const UbahProfile(), context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.edit_note_rounded,
                              color: Color(0xFF7F3236),
                            ),
                            Text(
                              "Ubah Data",
                              style: TextStyle(color: Color(0xFF7F3236)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Expanded(
                child: Card(
                  color: Colors.white,
                  elevation: 10,
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(
                              Icons.exit_to_app,
                              color: Color(0xFF7F3236),
                            ),
                            Text(
                              "Keluar",
                              style: TextStyle(color: Color(0xFF7F3236)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget profileData() {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(20),
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: const [
              ListTile(
                textColor: Color(0xFF7F3236),
                title: Text("Nama"),
                trailing: Text("Boris"),
              ),
              ListTile(
                textColor: Color(0xFF7F3236),
                title: Text("Umur"),
                trailing: Text("27 Tahun"),
              ),
              ListTile(
                textColor: Color(0xFF7F3236),
                title: Text("Jabatan"),
                trailing: Text("IT"),
              ),
              ListTile(
                textColor: Color(0xFF7F3236),
                title: Text("Perusahaan"),
                trailing: Text("PT Alamjaya Bara Pratama"),
              ),
            ],
          )),
    );
  }

  Widget idCard(context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Icon(
                Icons.person_outline_rounded,
                size: 60,
                color: Color(0xFF7F3236),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
