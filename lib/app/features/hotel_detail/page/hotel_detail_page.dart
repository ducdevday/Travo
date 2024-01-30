part of hotel_detail;

class HotelDetailPage extends StatefulWidget {
  static const String routeName = '/hotel_detail';
  final HotelModel hotel;

  const HotelDetailPage({Key? key, required this.hotel}) : super(key: key);

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  late final HotelDetailBloc _bloc;

  @override
  void initState() {
    _bloc = HotelDetailBloc(roomRepository: context.read<RoomRepository>())
      ..add(HotelDetailLoad(hotel: widget.hotel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: Scaffold(
          body: BlocBuilder<HotelDetailBloc, HotelDetailState>(
            builder: (context, state) {
              if (state is HotelDetailLoadSuccess) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: state.hotel.image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const MySkeletonRectangle(
                            width: double.infinity, height:  double.infinity),
                        errorWidget: (_, __, ___) => Container(
                            color: AppColor.unLikedColor,
                            child: const Icon(
                              Icons.error_outline_rounded,
                              color: Colors.red,
                              size: AppDimen.largeSize,
                            )),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return ImageFullScreen(imgPath: state.hotel.image!);
                        }));
                      },
                    ),
                    const HotelDetailHeader(),
                    DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      maxChildSize: 0.8,
                      minChildSize: 0.2,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return Container(
                          padding: const EdgeInsets.only(
                              left: AppDimen.screenPadding,
                              right: AppDimen.screenPadding,
                              bottom: AppDimen.screenPadding),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(AppDimen.mediumPadding),
                              topRight: Radius.circular(AppDimen.mediumPadding),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                    top: AppDimen.screenPadding),
                                child: Container(
                                  height: 5,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: AppDimen.mediumPadding,
                              ),
                              Expanded(
                                child: ListView(
                                  controller: scrollController,
                                  padding: EdgeInsets.zero,
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                            Text(
                                              state.hotel.name!,
                                              style: AppStyle.largeTitleStyle,
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${StringFormatUtil.formatMoney(state.hotel.price)}',
                                              style: AppStyle.mediumHeaderStyle,
                                            ),
                                            Text(
                                              ' /night',
                                              style: AppStyle
                                                  .smallTextBlackStyle
                                                  .copyWith(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                AppPath.icLocation),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              state.hotel.location!,
                                              style:
                                                  AppStyle.normalTextBlackStyle,
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        const DottedLine(
                                          direction: Axis.horizontal,
                                          dashLength: 8.0,
                                          dashColor: AppColor.dottedColor,
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    AppPath.icStar),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  state.hotel.rating.toString(),
                                                  style: AppStyle
                                                      .normalTextBlackStyle,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  "(${state.hotel.totalReview})",
                                                  style: AppStyle
                                                      .normalTextBlackStyle
                                                      .copyWith(
                                                          color: AppColor
                                                              .textGreyColor),
                                                )
                                              ],
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MyDeveloping()));
                                              },
                                              child: Text(
                                                'See All',
                                                style: AppStyle
                                                    .normalTextBlackStyle
                                                    .copyWith(
                                                        color: AppColor
                                                            .primaryColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        const DottedLine(
                                          direction: Axis.horizontal,
                                          dashLength: 8.0,
                                          dashColor: AppColor.dottedColor,
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        const Text(
                                          'Infomation',
                                          style: AppStyle.mediumTextBlackStyle,
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        Text(
                                          state.hotel.information!,
                                          style: AppStyle.normalTextBlackStyle,
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        Wrap(
                                          spacing: 30,
                                          children: [
                                            ...state.services.map((e) =>
                                                ServiceItem(serviceId: e)),
                                            MoreItem(hotelId: widget.hotel.id!)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        const Text(
                                          'Location',
                                          style: AppStyle.mediumTextBlackStyle,
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        Text(
                                          state.hotel.locationDescription!,
                                        ),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        Image.asset(AppPath.imgMap),
                                        const SizedBox(
                                          height: AppDimen.spacing,
                                        ),
                                        MyPrimaryButton(
                                            width: double.infinity,
                                            text: 'Select Room',
                                            callback: () {
                                              Navigator.of(context).pushNamed(
                                                  RoomsPage.routeName,
                                                  arguments: state.hotel.id);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ));
  }
}
