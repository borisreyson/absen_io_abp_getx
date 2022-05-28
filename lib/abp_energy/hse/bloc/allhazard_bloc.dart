import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:face_id_plus/abp_energy/hse/bloc/allhazard_state.dart';
import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';

class AllHazardBloc extends Cubit<AllHazardState> {
  final AllHazardApi _allHazardApi;

  AllHazardBloc(this._allHazardApi) : super(InitialAllHazard());

  void loadListHazard(
      {int? disetujui,
      int? halaman,
      bool? pertama,
      bool? kedua,
      bool? paging,
      String? dari,
      String? sampai}) async {
    if (pertama!) {
      emit(InitialAllHazard());
    }
    if (kedua!) {
      emit(AllHazardLoading());
    }
    if (paging!) {
      emit(AllHazardPaging());
    }
    try {
      AllHazard? _allHazard = await _allHazardApi.getAllHazard(
          disetujui!, halaman!, dari!, sampai!);
      emit(AllHazardLoaded(_allHazard!));
    } catch (e) {
      emit(AllHazardError(e.toString()));
    }
  }
}
