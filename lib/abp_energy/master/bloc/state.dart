import 'package:face_id_plus/abp_energy/hse/models/counter_hazard.dart';
import 'package:face_id_plus/abp_energy/hse/models/hazard_user.dart';
import 'package:face_id_plus/abp_energy/master/model/berita.dart';
import 'package:face_id_plus/abp_energy/master/model/user_profile.dart';

class StateBloc {}

class Init extends StateBloc {}

class Loading extends StateBloc {}

class Loaded extends StateBloc {
  List<dynamic> data;
  Loaded(this.data);
}

class LoadedProfile extends StateBloc {
  UserProfileModel data;
  LoadedProfile(this.data);
}

class LoadedCounterHazard extends StateBloc {
  CounterHazard data;
  LoadedCounterHazard(this.data);
}

class LoadedUserHazard extends StateBloc {
  HazardUser data;
  LoadedUserHazard(this.data);
}

class LoadedBerita extends StateBloc {
  BeritaModel data;
  LoadedBerita(this.data);
}

class UserHazardPaging extends StateBloc {}

class Error extends StateBloc {
  String errMsg;
  Error(this.errMsg);
}
