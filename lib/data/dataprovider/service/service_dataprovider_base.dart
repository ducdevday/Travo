abstract class ServiceDataProviderBase{
  Future<List<Map<String, dynamic>>> getAllServices();
  Future<Map<String, dynamic>> getServiceById(String id);
}