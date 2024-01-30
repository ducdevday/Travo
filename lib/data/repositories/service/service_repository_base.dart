import 'package:my_project/data/model/service_model.dart';

abstract class ServiceRepositoryBase{
  Future<List<ServiceModel>> getAllServices();
  Future<ServiceModel> getServiceById(String id);
}