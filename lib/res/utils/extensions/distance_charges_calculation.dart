// import 'package:pethub_service_provider/utils/logger/app_logger.dart';

extension DistanceChargesCalculation on int {
  int getTravelCharges(String distanceType, String currency) {
    if (this >= 1 && this <= 10) {
      return 40;
    }

    if (this >= 10 && this <= 25) {
      return 50;
    }

    if (this > 25 && this <= 40) {
      return 60;
    }

    if (this > 40 && this <= 60) {
      return 70;
    }

    if (this > 60) {
      int additionalDistance = this - 60;
      int additionalCharges = additionalDistance * 4;
      // AppLogger.logMessage("-=> $additionalDistance ,, $additionalCharges");
      return 70 + additionalCharges;
    }
    return 0;
  }

  String getTravelChargesHint(String distanceType, String currency) {
    if (this >= 1 && this <= 10) {
      return "1-10 $distanceType: $currency 40";
    }

    if (this >= 10 && this <= 25) {
      return "10-25 $distanceType: $currency 50";
    }

    if (this > 25 && this <= 40) {
      return "25-40 $distanceType: $currency 60";
    }

    if (this > 40 && this <= 60) {
      return "40-60 $distanceType: $currency 70";
    }

    if (this > 60) {
      return "above 60 additional: $currency 4 per $distanceType";
    }
    return "ex: 1-10 $distanceType: $currency 40";
  }
}
