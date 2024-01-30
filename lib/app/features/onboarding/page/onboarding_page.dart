part of onboarding;

class OnBoardingPage extends StatefulWidget {
  static const String routeName = '/onBoarding';

  OnBoardingPage({super.key});

  final List<Onboarding> contents = [
    Onboarding(
        title: 'Book a flight',
        image: AppPath.onBoarding1,
        discription:
            "Found a flight that matches your destination and schedule? Book it instantly."),
    Onboarding(
        title: 'Find a hotel room',
        image: AppPath.onBoarding2,
        discription:
            "Select the day, book your room. We give you the best price."),
    Onboarding(
        title: 'Enjoy your trip',
        image: AppPath.onBoarding3,
        discription:
            "Easy discovering new places and share these between your friends and travel together."),
  ];

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.contents.length,
              onPageChanged: (int index) {},
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(AppDimen.screenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          widget.contents[i].image,
                          height: 375,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: AppDimen.spacing * 2),
                      Text(
                        widget.contents[i].title,
                        style: AppStyle.mediumHeaderStyle
                            .copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: AppDimen.spacing * 2),
                      Text(
                        widget.contents[i].discription,
                        style: AppStyle.normalTextParagraphStyle
                            .copyWith(color: Colors.black, height: 1.75),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingCubit(),
            child: BlocBuilder<OnboardingCubit, int>(
              builder: (context, currentIndex) {
                return Padding(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.contents.length,
                            (index) => buildDot(index, currentIndex, context),
                          ),
                        ),
                      ),
                      GradientButton(
                        width: 125,
                        borderRadius: 24,
                        text: currentIndex == widget.contents.length - 1
                            ? "Get Started"
                            : "Next",
                        onPressed: () {
                          if (currentIndex == widget.contents.length - 1) {
                            SharedService.setIsFirstTime(false);
                            Navigator.of(context)
                                .pushReplacementNamed(LoginPage.routeName);
                          }
                          else{
                            context.read<OnboardingCubit>().changePage(currentIndex + 1);
                          }
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn,
                          );
                        },
                        textStyle: AppStyle.mediumTextWhiteStyle,
                        gradientColors: const [
                          AppColor.linearFromColor,
                          AppColor.linearToColor
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, int currentIndex, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index
            ? AppColor.activeColor
            : AppColor.nonactiveColor,
      ),
    );
  }
}

class Onboarding {
  String image;
  String title;
  String discription;

  Onboarding(
      {required this.image, required this.title, required this.discription});
}
