import 'package:my_project/data/dataprovider/service/service_dataprovider.dart';
import 'package:my_project/data/model/service_model.dart';

import 'service_repository_base.dart';

class ServiceRepository extends ServiceRepositoryBase {
  final ServiceDataProvider serviceDataProvider;

  ServiceRepository({
    required this.serviceDataProvider,
  });

  @override
  Future<List<ServiceModel>> getAllServices() async{
    final data = await serviceDataProvider.getAllServices();
    final services = data.map((e) => ServiceModel.fromJson(e)).toList();
    return services;
  }

  @override
  Future<ServiceModel> getServiceById(String id) async{
    final data = await serviceDataProvider.getServiceById(id);
    final service = ServiceModel.fromJson(data);
    return service;
  }
}
