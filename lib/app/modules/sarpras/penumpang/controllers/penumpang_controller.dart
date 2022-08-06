import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/users_model.dart';
import '../../../../data/repository/repository_sqlite.dart';
import '../../../../data/utils/constants.dart';

class PenumpangController extends GetxController {
  final repository = RepositoryUsers();
  Widget? searchBar = const Text("Penumpang");
  final cari = false.obs;
  final cariFocus = FocusNode();
  final data = <UsersList>[].obs;
  final cariController = TextEditingController();
  final dipilih = <UsersList>[].obs;

  @override
  void onInit() async {
    await repository.getAll(table: Constants.usersTb).then((value) {
      data.addAll(value);
    });
    super.onInit();
  }

  @override
  void onClose() {}
  cariUser(String? search) async {
    data.clear();
    if (cari.value) {
      if (search != null) {
        await repository
            .cariNama(table: Constants.usersTb, nama: search)
            .then((value) {
          data.addAll(value);
        });
      } else {
        await repository.getAll(table: Constants.usersTb).then((value) {
          data.addAll(value);
        });
      }
    } else {
      await repository.getAll(table: Constants.usersTb).then((value) {
        data.addAll(value);
      });
    }
  }
}
