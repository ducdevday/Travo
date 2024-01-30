import 'package:my_project/data/dataprovider/flight/flight_dataprovider.dart';
import 'package:my_project/data/model/flight_model.dart';
import 'package:my_project/data/repositories/flight/flight_repository_base.dart';

class FlightRepository extends FlightRepositoryBase {
  final FlightDataProvider flightDataProvider;

  FlightRepository({
    required this.flightDataProvider,
  });

  @override
  Future<List<FlightModel>> getAllFlights(
      String fromPlace, String toPlace, DateTime departureDate) async {
    final data = await flightDataProvider.getAllFlights(fromPlace, toPlace, departureDate);
    final List<FlightModel> flights =
        data.map((e) => FlightModel.fromJson(e)).toList();
    return flights;
  }
}
