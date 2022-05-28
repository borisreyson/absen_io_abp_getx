import 'package:face_id_plus/abp_energy/hse/models/kemungkinan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/keparahan_model.dart';
import 'package:face_id_plus/abp_energy/hse/models/metrik_resiko_model.dart';

abstract class GambarState {}

class InitGambar extends GambarState {}

class LoadingGambar extends GambarState {}

class LoadedGambar extends GambarState {
  String urlImg;
  LoadedGambar({required this.urlImg});
}

class ErrorGambar extends GambarState {
  String errMsg;
  ErrorGambar(this.errMsg);
}

abstract class KemungkinanState {}

class KemungkinanInit extends KemungkinanState {}

class KemungkinanLoaded extends KemungkinanState {
  Kemungkinan kemungkinan;
  KemungkinanLoaded(this.kemungkinan);
}

class KemungkinanLoading extends KemungkinanState {}

class KemungkinanError extends KemungkinanState {
  String error;
  KemungkinanError(this.error);
}

abstract class KeparahanState {}

class KeparahanInit extends KeparahanState {}

class KeparahanLoaded extends KeparahanState {
  Keparahan keparahan;
  KeparahanLoaded(this.keparahan);
}

class KeparahanLoading extends KeparahanState {}

class KeparahanError extends KeparahanState {
  String error;
  KeparahanError(this.error);
}

abstract class ResikoState {}

class ResikoInit extends ResikoState {}

class ResikoLoaded extends ResikoState {
  Keparahan keparahan;
  Kemungkinan kemungkinan;
  MetrikResiko resiko;
  ResikoLoaded(this.kemungkinan, this.keparahan, this.resiko);
}

class ResikoTotal extends ResikoState {
  int nilaiTotal;
  ResikoTotal(this.nilaiTotal);
}

class ResikoLoading extends ResikoState {}

class ResikoError extends ResikoState {
  String error;
  ResikoError(this.error);
}

abstract class MetrikState {}

class MetrikInit extends MetrikState {}

class MetrikLoaded extends MetrikState {
  MetrikResiko resiko;
  MetrikLoaded(this.resiko);
}

class MetrikTotal extends MetrikState {
  int nilaiTotal;
  MetrikTotal(this.nilaiTotal);
}

class MetrikLoading extends MetrikState {}

class MetrikError extends MetrikState {
  String error;
  MetrikError(this.error);
}
