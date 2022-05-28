import 'package:carousel_slider/carousel_slider.dart';
import 'package:face_id_plus/permit/form/permohonan_baru.dart';
import 'package:face_id_plus/permit/form/permohonan_perubahan.dart';
import 'package:face_id_plus/permit/output/image_view.dart';
import 'package:face_id_plus/permit/output/list_permohonan.dart';
import 'package:flutter/material.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _listCard = [
    "assets/images/mine_permit.psd",
    "assets/images/SIMPER_ABP.psd"
  ];

  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        idCard(context),
        menuPermohonan(context),
      ],
    );
  }

  Widget menuPermohonan(context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
      children: [
        InkWell(
          onTap: () {
            Constants().goTo(() => const FormPermohonanBaru(), context);
          },
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_card_rounded,
                    color: Color(0xFF7C6B9C),
                    size: 40,
                  ),
                ),
              ),
              const Text(
                "Baru",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Constants().goTo(() => const FormPermohonanPerubahan(), context);
          },
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit_rounded,
                    color: Color(0xFF7C6B9C),
                    size: 40,
                  ),
                ),
              ),
              const Text(
                "Rubah",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Constants().goTo(() => const ListPermohonan(), context);
          },
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.list_alt_rounded,
                    color: Color(0xFF7C6B9C),
                    size: 40,
                  ),
                ),
              ),
              const Text(
                "Permohonan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget idCard(context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3.2,
            child: CarouselSlider.builder(
              options: CarouselOptions(
                  aspectRatio: 2,
                  enlargeCenterPage: true,
                  height: MediaQuery.of(context).size.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentPos = index;
                    });
                  }),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 15, top: 5),
                  elevation: 10,
                  child: InkWell(
                    onTap: () {
                      Constants().goTo(
                          () => ImageView(image: _listCard[index]), context);
                    },
                    child: Image(
                      image: AssetImage(_listCard[index]),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              itemCount: _listCard.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _listCard.map((url) {
              int index = _listCard.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentPos == index
                      ? const Color(0xFFD8C7FF)
                      : const Color(0xFF7C6B9C),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
