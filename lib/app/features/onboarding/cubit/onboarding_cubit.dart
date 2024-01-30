part of onboarding;

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void changePage(int page){
    emit(page);
  }


}
