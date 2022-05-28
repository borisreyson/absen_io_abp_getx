import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/state.dart';
import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';
import 'package:face_id_plus/abp_energy/hse/repository/repository.dart';
import 'package:face_id_plus/abp_energy/master/bloc/state.dart';
import 'package:face_id_plus/abp_energy/service/service.dart';

class GambarBloc extends Cubit<GambarState> {
  GambarBloc() : super(InitGambar());

  tampilGambar({String? url}) {
    emit(LoadingGambar());
    try {
      if (url != null) {
        emit(
          LoadedGambar(urlImg: url),
        );
      }
    } catch (e) {
      emit(ErrorGambar(e.toString()));
    }
  }
}

class ImgPerbaikanBloc extends Cubit<GambarState> {
  ImgPerbaikanBloc() : super(InitGambar());

  tampilGambar(String _url) {
    emit(LoadingGambar());
    try {
      emit(LoadedGambar(urlImg: _url));
    } catch (e) {
      emit(ErrorGambar(e.toString()));
    }
  }
}

class PjImgBloc extends Cubit<GambarState> {
  PjImgBloc() : super(InitGambar());

  tampilGambar(String _url) {
    emit(LoadingGambar());
    try {
      emit(LoadedGambar(urlImg: _url));
    } catch (e) {
      emit(ErrorGambar(e.toString()));
    }
  }
}

class ResikoSebelumBloc extends Cubit<ResikoState> {
  ResikoSebelumBloc() : super(ResikoInit());
  getResiko(Kemungkinan _km, Keparahan _kp, MetrikResiko _resiko) {
    emit(ResikoLoading());
    try {
      emit(ResikoLoaded(_km, _kp, _resiko));
    } catch (e) {
      emit(ResikoError(e.toString()));
    }
  }
}

class ResikoSesudahBloc extends Cubit<ResikoState> {
  ResikoSesudahBloc() : super(ResikoInit());
  getResiko(Kemungkinan _km, Keparahan _kp, MetrikResiko _resiko) {
    emit(ResikoLoading());
    try {
      emit(ResikoLoaded(_km, _kp, _resiko));
    } catch (e) {
      emit(ResikoError(e.toString()));
    }
  }
}

class MetrikBloc extends Cubit<MetrikState> {
  final MetrikService _service;
  MetrikBloc(this._service) : super(MetrikInit());
  getResiko(int nilai) async {
    emit(MetrikLoading());
    try {
      var _resiko = await _service.getBy(nilai: nilai);
      emit(MetrikLoaded(_resiko));
    } catch (e) {
      emit(MetrikError(e.toString()));
    }
  }
}

class MetrikSesudahBloc extends Cubit<MetrikState> {
  final MetrikService _service;
  MetrikSesudahBloc(this._service) : super(MetrikInit());
  getResiko(int nilai) async {
    emit(MetrikLoading());
    try {
      var _resiko = await _service.getBy(nilai: nilai);
      emit(MetrikLoaded(_resiko));
    } catch (e) {
      emit(MetrikError(e.toString()));
    }
  }
}

class CounterHazardBloc extends Cubit<StateBloc> {
  final HazardRepository repository;
  CounterHazardBloc(this.repository) : super((Init()));
  loadCounter(username, nik) async {
    emit(Loading());
    try {
      var counter = await repository.counterHazard(username, nik);
      emit(LoadedCounterHazard(counter!));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}

class HazardUserBloc extends Cubit<StateBloc> {
  final HazardRepository repository;
  HazardUserBloc(this.repository) : super((Init()));
  loadHazardUser(
      {String? username,
      int? disetujui,
      int? halaman,
      bool? pertama,
      bool? kedua,
      bool? paging,
      String? dari,
      String? sampai}) async {
    emit(Loading());
    try {
      var counter = await repository.getHazardUser(
          username, disetujui, paging, dari, sampai);
      emit(LoadedUserHazard(counter!));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  loadHazardKeSaya(
      {String? nik,
      int? disetujui,
      int? halaman,
      bool? pertama,
      bool? kedua,
      bool? paging,
      String? dari,
      String? sampai}) async {
    emit(Loading());
    try {
      var counter = await repository.getHazardKeSaya(
          nik, disetujui, paging, dari, sampai);
      emit(LoadedUserHazard(counter!));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
