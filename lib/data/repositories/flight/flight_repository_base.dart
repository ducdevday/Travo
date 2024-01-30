import 'package:my_project/data/model/flight_model.dart';

abstract class FlightRepositoryBase {
  Future<List<FlightModel>> getAllFlights(String fromPlace, String toPlace, DateTime departureDate);
}
