import 'package:my_project/data/model/flight_model.dart';

abstract class FlightDataProviderBase{
  Future<List<Map<String, dynamic>>> getAllFlights(String fromPlace, String toPlace, DateTime departureDate);
  Future<Map<String, dynamic>?> getFlightById(String id);

}