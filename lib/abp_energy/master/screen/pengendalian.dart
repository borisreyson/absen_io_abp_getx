import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/master/model/detail_pengendalian_model.dart';
import 'package:face_id_plus/abp_energy/master/model/pengendalian.dart';
import 'package:face_id_plus/abp_energy/repository/repository_sqlite.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class PengendalianScreen extends StatefulWidget {
  const PengendalianScreen({Key? key}) : super(key: key);

  @override
  State<PengendalianScreen> createState() => _PengendalianState();
}

class _PengendalianState extends State<PengendalianScreen> {
  late PengendalianBloc _bloc;
  List<List<DetHirarki>?>? _detHirarki;
  List<int>? _idHirarki;
  late RepositoryDetPengendalian _repository;
  @override
  void initState() {
    _repository = RepositoryDetPengendalian();
    _detHirarki = [];
    _idHirarki = [];
    _bloc = PengendalianBloc(RepositoryPengendalian());
    _bloc.loadPengendalian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PengendalianBloc>(create: (context) => _bloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hirarki Pengendalian"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<PengendalianBloc, StateBloc>(
          listener: (context, state) async {
            if (state is Loaded) {
              if (state.data.isNotEmpty) {
                var pengendalian = state.data;
                for (Hirarki e in pengendalian) {
                  _idHirarki!.add(e.idHirarki!);
                }
                await loadPegendalian(_idHirarki);
              }
            }
          },
          child: BlocBuilder<PengendalianBloc, StateBloc>(
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

  loadPegendalian(List<int>? idHirarki) async {
    if (idHirarki!.isNotEmpty) {
      for (int id in idHirarki) {
        await _repository
            .getById(table: Constants.detPengendalianTb, idHirarki: id)
            .then((List<DetHirarki>? value) {
          if (value != null) {
            setState(() {
              _detHirarki!.add(value);
            });
          }
        });
      }
    }
  }

  Widget widgetCard(Hirarki e, int index) {
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
                  "${e.namaPengendalian}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.right,
                ),
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
                  children: (_detHirarki!.isNotEmpty)
                      ? _detHirarki![index]!
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
