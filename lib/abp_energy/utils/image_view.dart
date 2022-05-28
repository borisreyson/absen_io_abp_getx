import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/state.dart';

class ImageView extends StatefulWidget {
  final String image;
  const ImageView({Key? key, required this.image}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  late GambarBloc _gambarBloc;

  @override
  void initState() {
    _gambarBloc = GambarBloc();
    _gambarBloc.tampilGambar(url: widget.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GambarBloc>(
      create: (context) => _gambarBloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blue,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            _loadImage(),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _loadImage() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<GambarBloc, GambarState>(
        builder: (context, state) {
          if (state is ErrorGambar) {
            return const Card(
                margin:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
                elevation: 10,
                child: Center(
                  child: Text("Gagal Memuat Gambar"),
                ));
          } else if (state is LoadedGambar) {
            return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(10),
                elevation: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: state.urlImg,
                    fit: BoxFit.fitWidth,
                    placeholder: (contex, url) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ));
          }
          return const Card(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
              elevation: 10,
              child: Icon(Icons.people));
        },
      ),
    );
  }
}
