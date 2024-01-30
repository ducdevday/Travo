part of promo;

@immutable
abstract class PromoState {}

class PromoInitial extends PromoState {}

class PromoCheckInProcess extends PromoState{}

class PromoCheckHaveResult extends PromoState{
  final PromoModel promo;

  PromoCheckHaveResult({
    required this.promo,
  });

}
class PromoCheckFailure extends PromoState{

}