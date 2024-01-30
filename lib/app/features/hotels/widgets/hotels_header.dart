part of hotels;

class HotelsHeader extends StatelessWidget {
  final int size;

  const HotelsHeader({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppPath.imgAppBar,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(
              height: AppDimen.headerMargin,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimen.screenPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded, size: 20),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                  Text(
                    "Hotels",
                    style: AppStyle.largeHeaderStyle,
                  ),
                  IconButton(
                    onPressed: () {
                      buildShowFilterBottomSheet(context, size);
                    },
                    icon: SvgPicture.asset(
                      AppPath.icFilter,
                      width: 20,
                      height: 20,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

Future<void> buildShowFilterBottomSheet(BuildContext context, int size) {
  return showModalBottomSheet<void>(
    backgroundColor: Colors.black.withOpacity(0.75),
    isScrollControlled: true,
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: context.read<HotelsBloc>(),
        child: BlocBuilder<HotelsBloc, HotelsState>(
          builder: (context, state) {
            if (state is HotelsLoadSuccess) {
              return HotelFilterBottomSheet(
                size: size,
                budgetFrom: state.budgetFrom,
                budgetTo: state.budgetTo,
                maxRating: state.maxRating,
                sortType: state.sortType,
                  propertyTypes: state.propertyTypes
              );
            } else {
              return SizedBox();
            }
          },
        ),
      );
    },
  );
}
