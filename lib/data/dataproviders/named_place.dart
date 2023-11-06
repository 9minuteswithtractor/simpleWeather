import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:the_counter_app/data/dataproviders/goelocator.dart';
import 'package:the_counter_app/data/models/location/location_model.dart';

class NamedPlace {
  late double latitude;
  late double longitude;
  late String location;
  Future getLocationsName() async {
    // String value = AppCubitStates.initial().location;

    LocationPermission permissionStatus = await Geolocator.requestPermission();

    if (permissionStatus == LocationPermission.denied) {
      print('The user denied permission to access their location.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude;
    longitude = position.longitude;

    // String usersLocationLatLong = 'lat: $latitude,  long: $longitude';

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);

    Placemark place = placemark[0];

    final serializedLocation = place.toJson();
    final deserilizedLocation =
        LocationModelFreezed.fromJson(serializedLocation);

    final county = deserilizedLocation.administrativeArea;
    final region = deserilizedLocation.locality;
    final country = deserilizedLocation.country;

    final namedUserLocation = '$county, $region, $country';

    return namedUserLocation;
  }
}
