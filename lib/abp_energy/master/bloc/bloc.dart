import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/repository/repository_sqlite.dart';
import 'package:face_id_plus/abp_energy/utils/constants.dart';

class PerusahaanBloc extends Cubit<StateBloc> {
  ReporsitoryPerusahaan repository;
  PerusahaanBloc(this.repository) : super(Init());
  void loadPerusahaan() async {
    emit(Loading());
    try {
      var data = await repository.getAll(table: Constants.perusahaanTb);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class LokasiBloc extends Cubit<StateBloc> {
  ReporsitoryLokasi repository;
  LokasiBloc(this.repository) : super(Init());
  void loadLokasi() async {
    emit(Loading());
    try {
      var data = await repository.getAll(table: Constants.lokasiTb);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class KemungkinanBloc extends Cubit<StateBloc> {
  ReporsitoryKemungkinan repository;
  KemungkinanBloc(this.repository) : super(Init());
  void loadKemungkinan() async {
    emit(Loading());
    try {
      var data = await repository.getAll(table: Constants.kemungkinanTb);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class KeparahanBloc extends Cubit<StateBloc> {
  RepositoryKeparahan repository;
  KeparahanBloc(this.repository) : super(Init());
  void loadKeparahan() async {
    emit(Loading());
    try {
      var data = await repository.getAll(table: Constants.keparahanTb);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class DetKeparahanBloc extends Cubit<StateBloc> {
  RepositoryDetKeparahan repository;
  DetKeparahanBloc(this.repository) : super(Init());
  void loadKeparahan(idKep) async {
    emit(Loading());
    try {
      var data = await repository.getById(
          table: Constants.detKeparahanTb, idKep: idKep);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class PengendalianBloc extends Cubit<StateBloc> {
  RepositoryPengendalian repository;
  PengendalianBloc(this.repository) : super(Init());
  void loadPengendalian() async {
    emit(Loading());
    try {
      var data = await repository.getAll(table: Constants.pengendalianTb);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class UsersBloc extends Cubit<StateBloc> {
  RepositoryUsers repository;
  UsersBloc(this.repository) : super(Init());
  void loadUsers({String? cariNama}) async {
    emit(Loading());
    try {
      var data = (cariNama != null)
          ? await repository.cariNama(table: Constants.usersTb, nama: cariNama)
          : await repository.getAll(table: Constants.usersTb);
      emit(Loaded(data));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class ProfileBloc extends Cubit<StateBloc> {
  UsersRepository repository;
  ProfileBloc(this.repository) : super(Init());
  void loadProfile(username) async {
    emit(Loading());
    try {
      var data = await repository.fetchUserProfile(username);
      emit(LoadedProfile(data!));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class BeritaBloc extends Cubit<StateBloc> {
  BeritaRepository repository;
  BeritaBloc(this.repository) : super(Init());
  void loadBerita(page) async {
    emit(Loading());
    try {
      var data = await repository.getBuletin(page);
      emit(LoadedBerita(data!));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
