import 'package:face_id_plus/abp_energy/hse/models/all_hazard_model.dart';

abstract class AllHazardState {}

class InitialAllHazard extends AllHazardState {}

class AllHazardLoading extends AllHazardState {}

class AllHazardPaging extends AllHazardState {}

class AllHazardError extends AllHazardState {
  final String errMSG;
  AllHazardError(this.errMSG);
}

class AllHazardLoaded extends AllHazardState {
  final AllHazard allHazard;
  AllHazardLoaded(this.allHazard);
}
