part of checkout;

class CardItem extends StatelessWidget {
  final CardModel card;
  final CheckoutType type;

  const CardItem({Key? key, required this.card, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      color: AppColor.secondaryColor,
      padding: AppDimen.spacing,
      child: Row(children: [
        getCardIcon(CardUtil.getCardTypeFrmNumber(card.number)),
        SizedBox(width: AppDimen.spacing,),
        Text(CardUtil.getCardTypeFrmNumber(card.number).toJson(), style: AppStyle.mediumTextBlackStyle,),
        Spacer(),
        TextButton(onPressed: (){
          if(type == CheckoutType.hotel) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<CheckoutBloc>(),
                child: AddCardPage(card: card, type: CheckoutType.hotel,),
              )));
          }
          else{
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<CheckoutFlightBloc>(),
                  child: AddCardPage(card: card, type: CheckoutType.flight,),
                )));
          }
        }, child: Text("Change", style: AppStyle.normalTextBlackStyle.copyWith(color: AppColor.primaryColor),))
      ],),
    );
  }
}


Widget getCardIcon(CardType? cardType) {
  String imgPath = "";
  Icon icon = const Icon(
    Icons.warning,
    size: AppDimen.smallSize,
    color: Color(0xFFB8B5C3),
  );
  switch (cardType) {
    case CardType.Master:
      imgPath = AppPath.imgMasterCard;
      break;
    case CardType.Visa:
      imgPath = AppPath.imgVisa;
      break;
    case CardType.Verve:
      imgPath = AppPath.imgVerve;
      break;
    case CardType.AmericanExpress:
      imgPath = AppPath.imgAmericanExpress;
      break;
    case CardType.Discover:
      imgPath = AppPath.imgDiscover;
      break;
    case CardType.DinersClub:
      imgPath = AppPath.imgDinnerClubs;
      break;
    case CardType.Jcb:
      imgPath = AppPath.imgJcb;
      break;
    case CardType.Others:
      icon = const Icon(
        Icons.credit_card,
        size: 24.0,
        color: Color(0xFFB8B5C3),
      );
      break;
    default:
      icon = const Icon(
        Icons.warning,
        size: 24.0,
        color: Color(0xFFB8B5C3),
      );
      break;
  }
  Widget widget;
  if (imgPath.isNotEmpty) {
    widget = Image.asset(
      imgPath,
      width: AppDimen.largeSize,
      fit: BoxFit.cover,
    );
  } else {
    widget = icon;
  }
  return widget;
}
