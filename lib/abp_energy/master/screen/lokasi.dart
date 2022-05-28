import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/master/model/lokasi_model.dart';
import 'package:face_id_plus/abp_energy/repository/repository_sqlite.dart';

class LokasiScreen extends StatefulWidget {
  const LokasiScreen({Key? key}) : super(key: key);

  @override
  State<LokasiScreen> createState() => _LokasiState();
}

class _LokasiState extends State<LokasiScreen> {
  late LokasiBloc lokasiBloc;
  @override
  void initState() {
    lokasiBloc = LokasiBloc(ReporsitoryLokasi());
    lokasiBloc.loadLokasi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LokasiBloc>(
      create: (context) => lokasiBloc,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocBuilder<LokasiBloc, StateBloc>(
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

  Widget widgetCard(Lokasi e) => Card(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.pop(context, e);
          },
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(children: [Text("${e.lokasi}")]),
          ),
        ),
      );
}
