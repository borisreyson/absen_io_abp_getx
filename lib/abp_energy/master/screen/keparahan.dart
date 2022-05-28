import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_keparahan_model.dart';
import 'package:face_id_plus/abp_energy/repository/repository_sqlite.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class KeparahanScreen extends StatefulWidget {
  const KeparahanScreen({Key? key}) : super(key: key);

  @override
  State<KeparahanScreen> createState() => _KeparahanState();
}

class _KeparahanState extends State<KeparahanScreen> {
  late KeparahanBloc keparahanBloc;
  List<List<DetKeparahan>?>? _detKeparahan;
  List<int>? idKeparahan;
  late RepositoryDetKeparahan _repository;
  @override
  void initState() {
    _repository = RepositoryDetKeparahan();
    _detKeparahan = [];
    idKeparahan = [];
    keparahanBloc = KeparahanBloc(RepositoryKeparahan());
    keparahanBloc.loadKeparahan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeparahanBloc>(create: (context) => keparahanBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Keparahan Resiko"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<KeparahanBloc, StateBloc>(
          listener: (context, state) async {
            if (state is Loaded) {
              var kep = state.data;
              for (Keparahan e in kep) {
                idKeparahan!.add(e.idKeparahan!);
              }
              await loadDetKeparahan(idKeparahan);
            }
          },
          child: BlocBuilder<KeparahanBloc, StateBloc>(
            builder: (context, state) {
              if (state is Loading) {
              } else if (state is Loaded) {
                var data = state.data;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return widgetCard(data[index], index);
                  },
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
      ),
    );
  }

  loadDetKeparahan(idKeparahan) async {
    if (idKeparahan!.isNotEmpty) {
      for (int id in idKeparahan!) {
        var res = await _repository.getById(
            table: Constants.detKeparahanTb, idKep: id);
        setState(() {
          _detKeparahan!.add(res);
        });
      }
    }
  }

  Widget widgetCard(Keparahan e, int index) {
    double lebar = MediaQuery.of(context).size.width / 5;
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.pop(context, e);
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "${e.keparahan}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.right,
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
              Container(
                color: Colors.black,
                height: 1,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Keterangan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (_detKeparahan!.isNotEmpty && index >= 0)
                      ? _detKeparahan![index]!
                          .map(
                            (e) => ListTile(
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
                          )
                          .toList()
                      : [
                          const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
