import 'package:my_project/data/model/promo_model.dart';

abstract class PromoRepositoryBase{
  Future<PromoModel> getPromoById(String id);
}