
import 'dart:math';
import '../models/distance_time.dart';

class Distance{
  DistanceTime calculateDistanceTimePrice(double lat1, double lon1, double lat2,
      double lon2 , double speedKmPerHr, double pricePerKm){
    // convert latitude and longitude from degrees to radians
    var rLat1 = _toRadians(lat1);
    var rLon1 = _toRadians(lon1);
    var rLat2 = _toRadians(lat2);
    var rLon2 = _toRadians(lon2);

    // Haversine formula
    var dLat = rLat2 - rLat1;
    var dLon = rLon2- rLon1;
    var a= pow(sin(dLat/2), 2) + cos(rLat1)*cos(rLat2)*pow(sin(dLon/2), 2);
    var c = 2*atan2(sqrt(a), sqrt(1-a));

    // Radius of the Earth in kilometers
    const double earthRadiusKm = 6371.0;
    var distance=(earthRadiusKm*2)*c;

    // calculate the time
    var time = distance/speedKmPerHr;

    // calculate the price
   var  price = distance*pricePerKm;

   return DistanceTime(price: price, distance: distance, time: time);
  }
  // Helper function to convert degrees to radians
double _toRadians(double degree){
    return degree*pi/180;
}
}