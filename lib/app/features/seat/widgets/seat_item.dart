part of seat;

class SeatItem extends StatefulWidget {
  final SeatType type;
  final int rowIndex;
  final int seatIndex;
  final bool isOccupied;

  const SeatItem({
    super.key,
    required this.type,
    required this.rowIndex,
    required this.seatIndex,
    required this.isOccupied,
  });

  @override
  State<SeatItem> createState() => _SeatItemState();
}

class _SeatItemState extends State<SeatItem> {
  late String character;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    character = SeatPlaceModel.getChosenSeatCharacter(widget.seatIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isOccupied == true) {
      return Container(
        height: 42,
        width: 26,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: AppColor.secondaryColor),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              character,
              style: AppStyle.normalTextBlackStyle
                  .copyWith(color: AppColor.textGreyColor),
            )),
      );
    } else {
      return BlocConsumer<SeatBloc, SeatState>(
        listener: (context, state) {
          if (state is SeatLoadChosenSuccess) {
            if (widget.type == state.chosenSeatType &&
                widget.rowIndex == state.chosenRowIndex &&
                widget.seatIndex == state.chosenSeatIndex) {
              isSelected = true;
            } else {
              isSelected = false;
            }
          }
        },
        buildWhen: (preState, state) {
          bool isReload = false;
          if (state is SeatLoadChosenSuccess) {
            if (state.chosenSeatType != null &&
                state.chosenRowIndex != null &&
                state.chosenSeatIndex != null) {
              if (state.chosenSeatType == widget.type &&
                  state.chosenRowIndex == widget.rowIndex &&
                  state.chosenSeatIndex == widget.seatIndex) {
                isReload = true;
              }
            }
          }
          if (preState is SeatLoadChosenSuccess) {
            if (preState.chosenSeatType != null &&
                preState.chosenRowIndex != null &&
                preState.chosenSeatIndex != null) {
              if (preState.chosenSeatType == widget.type &&
                  preState.chosenRowIndex == widget.rowIndex &&
                  preState.chosenSeatIndex == widget.seatIndex) {
                isReload = true;
              }
            }
          }
          return isReload;
        },
        builder: (context, state) {
          print("SeatItem Build");
          return InkWell(
            onTap: () {
              context.read<SeatBloc>().add(SeatChoosePressed(
                  chosenSeatType: widget.type,
                  chosenRowIndex: widget.rowIndex,
                  chosenSeatIndex: widget.seatIndex));
            },
            child: Container(
              height: 42,
              width: 26,
              decoration: isSelected == false
                  ? BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  border: Border.all(
                    color: AppColor.secondaryColor,
                  ))
                  : const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: AppColor.selectedSeatColor),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    character,
                    style: isSelected == false
                        ? AppStyle.normalTextBlackStyle
                        : AppStyle.normalTextWhiteStyle,
                  )),
            ),
          );
        },
      );
    }
  }
}