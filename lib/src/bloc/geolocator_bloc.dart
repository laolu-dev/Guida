
import 'package:geolocator/geolocator.dart';
import 'package:guida/services/geolocator.dart';
import 'package:guida/src/bloc/events.dart';
import 'package:guida/src/bloc/state.dart';

// class GeolocatorBloc extends Bloc<GeolocatorEvents, GeoLocationStates> {
//   GeolocatorBloc() : super(AppValue()) {
//     on<FetchLocationEvent>(_fetchDeviceLocation);
//   }

//   final GeolocatorService _geolocatorService = GeolocatorService.instance;

//   Position? _position;
//   Position? get position => _position;

//   void _fetchDeviceLocation(event, Emitter<GeoLocationStates> emitter) async {
//     emitter(AppLoading());
//     try {
//       final position = await _geolocatorService.getCurrentLocation();
//       emitter(AppValue(value: position));
//     } catch (e) {
//       emitter(AppError(error: e));
//     }
//   }
// }

// class GeolocatorCubit extends Cubit<GeoLocationStates>{
//   GeolocatorCubit() : super(AppValue()) {

//   }

// }
