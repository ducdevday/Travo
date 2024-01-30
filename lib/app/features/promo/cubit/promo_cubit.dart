part of promo;

class PromoCubit extends Cubit<PromoState> {
  final PromoRepository promoRepository;
  PromoCubit({required this.promoRepository}) : super(PromoInitial());

  void checkPromo(String code) async{
    emit(PromoCheckInProcess());
    try{
      final promo = await promoRepository.getPromoById(code);
      await Future.delayed(Duration(seconds: 1));
      emit(PromoCheckHaveResult(promo: promo));
    }
    catch(e){
      print(e);
      emit(PromoCheckFailure());
    }
  }
}
