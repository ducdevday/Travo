import 'package:my_project/data/dataprovider/promo/promo_dataprovider.dart';
import 'package:my_project/data/model/promo_model.dart';
import 'package:my_project/data/repositories/promo/promo_repository_base.dart';

class PromoRepository extends PromoRepositoryBase {
  final PromoDataProvider promoDataProvider;

  PromoRepository({
    required this.promoDataProvider,
  });

  @override
  Future<PromoModel> getPromoById(String id) async {
    final data = await promoDataProvider.getPromoById(id);
    final service = PromoModel.fromJson(data);
    return service;
  }
}
