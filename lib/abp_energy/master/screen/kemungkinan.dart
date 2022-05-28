import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/repository/repository_sqlite.dart';

class KemungkinanScreen extends StatefulWidget {
  const KemungkinanScreen({Key? key}) : super(key: key);

  @override
  State<KemungkinanScreen> createState() => _KemungkinanState();
}

class _KemungkinanState extends State<KemungkinanScreen> {
  late KemungkinanBloc kemungkinanBloc;
  @override
  void initState() {
    kemungkinanBloc = KemungkinanBloc(ReporsitoryKemungkinan());
    kemungkinanBloc.loadKemungkinan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KemungkinanBloc>(
      create: (context) => kemungkinanBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kemungkinan Resiko"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<KemungkinanBloc, StateBloc>(
          builder: (context, state) {
            if (state is Loading) {
            } else if (state is Loaded) {
              return ListView(
                children: state.data.map((e) => widgetCard(e)).toList(),
              );
            } else if (state is Error) {
              return ListView(
                children: [Text(state.errMsg)],
              );
            }
            return ListView();
          },
        ),
      ),
    );
  }

  Widget widgetCard(Kemungkinan e) {
    double lebar = MediaQuery.of(context).size.width / 5;

    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, e);
        },
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "${e.kemungkinan}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Nilai Resiko : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: lebar),
                    child: Text(
                      "${e.nilai}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Keterangan",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 1,
                minLeadingWidth: 1,
                leading: const Text("-"),
                title: Text(
                  e.keterangan!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
