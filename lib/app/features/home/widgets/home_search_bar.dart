part of home;

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key}) : super(key: key);

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool isFocusedSearchBar = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        context.read<HomeBloc>().add(HomeSearchBarPressed());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        switch (state) {
          case HomeLoadInProcess():
            isFocusedSearchBar = false;
            break;
          case HomeSearchInitial():
            isFocusedSearchBar = true;
            break;
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBackButton(context),
            TextField(
              textInputAction: TextInputAction.search,
              style: AppStyle.normalTextBlackStyle,
              controller: _controller,
              focusNode: _focusNode,
              onSubmitted: (value) {
                context
                    .read<HomeBloc>()
                    .add(HomeSearchPlaceByName(name: value));
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: CloseButton(
                  controller: _controller,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: isFocusedSearchBar
                          ? AppColor.headingColor
                          : Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColor.headingColor),
                ),
                hintText: "Search your destination",
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildBackButton(BuildContext context) {
    return isFocusedSearchBar
        ? InkWell(
            onTap: () {
              _controller.text = "";
              context.read<HomeBloc>().add(HomeSearchClear());
              context.read<HomeBloc>().add(HomeGetPlaces());
              _focusNode.unfocus();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: AppDimen.spacing),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: AppColor.textBlackColor,
                  ),
                  SizedBox(
                    width: AppDimen.spacing,
                  ),
                  Text(
                    "Back",
                    style: AppStyle.normalTextBlackStyle,
                  )
                ],
              ),
            ))
        : SizedBox();
  }
}

class CloseButton extends StatefulWidget {
  final TextEditingController controller;

  const CloseButton({Key? key, required this.controller}) : super(key: key);

  @override
  State<CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends State<CloseButton> {
  late TextEditingController _controller;
  bool isEmpty = true;

  void handleSearchChange(String value) {
    setState(() {
      isEmpty = value.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;

    _controller.addListener(() {
      handleSearchChange(_controller.text);
      if (_controller.text.isEmpty) {
        context.read<HomeBloc>().add(HomeSearchClear());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? const SizedBox()
        : IconButton(
            icon: const FaIcon(FontAwesomeIcons.solidCircleXmark),
            onPressed: () {
              _controller.text = "";
              context.read<HomeBloc>().add(HomeSearchClear());
            },
            iconSize: 16,
            color: AppColor.nonactiveColor,
          );
  }
}
