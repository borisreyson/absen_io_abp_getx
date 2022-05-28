
abstract class TglState {}

class TglInitial extends TglState {}

class TglLoading extends TglState {
  bool isLoading;
  TglLoading(this.isLoading);
}

class TglLoaded extends TglState {
  final DateTime tglStr;
  TglLoaded(this.tglStr);
}

class TglError extends TglState {
  final String errMSG;
  TglError(this.errMSG);
}
