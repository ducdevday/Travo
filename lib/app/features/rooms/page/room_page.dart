part of rooms;

class RoomsPage extends StatefulWidget {
  static const String routeName = '/rooms';

  final String hotelId;

  const RoomsPage({Key? key, required this.hotelId}) : super(key: key);

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final TooltipController _controller = TooltipController();

  @override
  Widget build(BuildContext context) {
    return OverlayTooltipScaffold(
      controller: _controller,
      tooltipAnimationCurve: Curves.linear,
      tooltipAnimationDuration: const Duration(milliseconds: 1000),
      startWhen: (initializedWidgetLength) async {
        await Future.delayed(const Duration(milliseconds: 1000));
        return true;
      },
      builder: (BuildContext context) => Scaffold(
        body: BlocProvider(
          create: (context) =>
              RoomsBloc(roomRepository: context.read<RoomRepository>())
                ..add(RoomsLoadAll(hotelId: widget.hotelId)),
          child: Stack(
            children: [
              RoomsHeader(),
              BlocBuilder<RoomsBloc, RoomsState>(
                builder: (context, state) {
                  if (state is RoomsLoadInProcess) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.only(
                                  left: AppDimen.screenPadding,
                                  right: AppDimen.screenPadding,
                                  bottom: 80),
                              itemBuilder: (context, index) =>
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child:
                                      const MySkeletonRectangle(width: 200, height: 300)),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: AppDimen.spacing,
                                  ),
                              itemCount: 8),
                        ),
                      ],
                    );
                  } else if (state is RoomsLoadSuccess) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Expanded(
                          child: ListView.separated(
                              padding: EdgeInsets.only(
                                  left: AppDimen.screenPadding,
                                  right: AppDimen.screenPadding,
                                  bottom: 80),
                              itemBuilder: (context, index) => RoomItemSelect(
                                  room: state.rooms[index],
                                  isFirstItem: index == 0 ? true : false),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: AppDimen.spacing,
                                  ),
                              itemCount: state.rooms.length),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
