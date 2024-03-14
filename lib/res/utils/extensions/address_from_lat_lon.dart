import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

extension AddressFromLatLong on Position {
  Future<String?> getAddressFromCoordinates() async {
    String address = '';
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
          latitude, longitude);
      // 30.7115, 76.706);

    if (placeMarks.isNotEmpty) {
        Placemark placeMark = placeMarks[0];

        address = '${placeMark.subLocality} ${placeMark.subAdministrativeArea} '
            '${placeMark.street}, ${placeMark.locality} - '
            '${placeMark.postalCode}, ${placeMark.country}';
        // String address1 =
        //     '${placeMark.name}, ${placeMark.administrativeArea}, ${placeMark.country},'
        //         ' ${placeMark.isoCountryCode}, ${placeMark.locality}, ${placeMark.postalCode},'
        //         ' ${placeMark.street},  ${placeMark.subAdministrativeArea},  ${placeMark.subLocality},'
        //         ' ${placeMark.subThoroughfare},  ${placeMark.thoroughfare}';
        // debugPrint('Address:- $address1');
        debugPrint('Address:- $address');
        return address;
      } else {
        debugPrint('Address not found');
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
