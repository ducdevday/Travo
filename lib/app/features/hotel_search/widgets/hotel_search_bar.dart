part of hotel_search;

class HotelSearchBar extends StatefulWidget {
  const HotelSearchBar({Key? key}) : super(key: key);

  @override
  State<HotelSearchBar> createState() => _HotelSearchBarState();
}

class _HotelSearchBarState extends State<HotelSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      style: AppStyle.normalTextBlackStyle,
      controller: _controller,
      onSubmitted: (value) {
        context.read<HotelSearchCubit>().doSearch(value);
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
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: "Enter hotel's name",
      ),
    );
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
              context.read<HotelSearchCubit>().doSearch("");
            },
            iconSize: 16,
            color: AppColor.nonactiveColor,
          );
  }
}
