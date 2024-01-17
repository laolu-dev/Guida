abstract class GeoLocationStates {}

class AppLoading extends GeoLocationStates {}

class AppError extends GeoLocationStates {
  final Object? error;

  AppError({this.error});
}

class AppValue<E> extends GeoLocationStates {
  final E? value;

  AppValue({this.value});
}


