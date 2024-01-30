part of rooms;

class ServiceItem extends StatelessWidget {
  final String serviceId;

  const ServiceItem({Key? key, required this.serviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildServiceImage(serviceId),
        SizedBox(
          height: 8,
        ),
        buildServiceTitle(serviceId)
      ],
    );
  }

  Text buildServiceTitle(String serviceId) {
    final String title;
    switch (serviceId) {
      case "24_HOURS_FRONT_DESK":
        title = "24-hour\nFront Desk";
      case "CURRENCY_EXCHANGE":
        title = "Currency\nExchange";
      case "FREE_BREAKFAST":
        title = "Free\nBreakfast";
      case "FREE_WIFI":
        title = "Free\nWifi";
      case "NON_REFUNDABLE":
        title = "Non-\nRefundable";
      case "NON_SMOKING":
        title = "Non-\nSmoking";
      case "RESTAURENT":
        title = "Restaurant";
      default:
        title = "Restaurant";
    }
    return Text(
      title,
      textAlign: TextAlign.center,
      style: AppStyle.smallTextBlackStyle.copyWith(fontSize: 10),
    );
  }

  SvgPicture buildServiceImage(String serviceId) {
    final String assetPath;
    switch (serviceId) {
      case "24_HOURS_FRONT_DESK":
        assetPath = AppPath.ic24HourFontDesk;
      case "CURRENCY_EXCHANGE":
        assetPath = AppPath.icCurrencyExchange;
      case "FREE_BREAKFAST":
        assetPath = AppPath.icFreeBreakfast;
      case "FREE_WIFI":
        assetPath = AppPath.icFreeWifi;
      case "NON_REFUNDABLE":
        assetPath = AppPath.icNonRefundable;
      case "NON_SMOKING":
        assetPath = AppPath.icNonSmoking;
      case "RESTAURENT":
        assetPath = AppPath.icRestaurant;
      default:
        assetPath = AppPath.icRestaurant;
    }
    return SvgPicture.asset(
      assetPath,
      width: AppDimen.mediumSize,
      height: AppDimen.mediumSize,
    );
  }
}
