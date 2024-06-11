import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../constants/Theme.dart';

import 'input.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String categoryOne;
  final String categoryTwo;
  final bool searchBar;
  final bool backButton;
  final bool transparent;
  final bool rightOptions;
  final List<String>? tags;
  final Function? getCurrentPage;
  final bool isOnSearch;
  final TextEditingController? searchController;
  final Function? searchOnChanged;
  final bool searchAutofocus;
  final bool noShadow;
  final Color bgColor;

  const Navbar(
      {super.key,
      this.title = "Home",
      this.categoryOne = "",
      this.categoryTwo = "",
      this.tags,
      this.transparent = false,
      this.rightOptions = true,
      this.getCurrentPage,
      this.searchController,
      this.isOnSearch = false,
      this.searchOnChanged,
      this.searchAutofocus = false,
      this.backButton = false,
      this.noShadow = false,
      this.bgColor = ArgonColors.white,
      this.searchBar = false});

  final double _preferredHeight = 180.0;

  @override
  _NavbarState createState() => _NavbarState();

  @override
  Size get preferredSize => Size.fromHeight(_preferredHeight);
}

class _NavbarState extends State<Navbar> {
  late String activeTag;

  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    if (widget.tags != null) {
      activeTag = widget.tags![0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool categories =
        widget.categoryOne.isNotEmpty && widget.categoryTwo.isNotEmpty;
    final bool tagsExist = widget.tags != null && widget.tags!.isNotEmpty;

    double calculateHeight() {
      double height = 102.0; // Base height without search bar or categories

      if (widget.searchBar) {
        height += 48.0; // Adjust for the search bar
      }
      if (categories) {
        height += 48.0; // Adjust for categories
      }
      if (tagsExist) {
        height += 40.0; // Adjust for tags
      }
      return height;
    }

    return Container(
      height: calculateHeight(),
      decoration: BoxDecoration(
        color: !widget.transparent ? widget.bgColor : Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: !widget.transparent && !widget.noShadow
                ? ArgonColors.initial
                : Colors.transparent,
            spreadRadius: -10,
            blurRadius: 12,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            !widget.backButton ? Icons.menu : Icons.arrow_back_ios,
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            size: 24.0,
                          ),
                          onPressed: () {
                            if (!widget.backButton) {
                              Scaffold.of(context).openDrawer();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: !widget.transparent
                                ? (widget.bgColor == ArgonColors.white
                                    ? ArgonColors.initial
                                    : ArgonColors.white)
                                : ArgonColors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                    if (widget.rightOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/chat');
                            },
                            child: IconButton(
                              icon: Icon(
                                Icons.smart_toy,
                                color: !widget.transparent
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                size: 22.0,
                              ),
                              onPressed: null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/notifications');
                            },
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_active,
                                color: !widget.transparent
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                size: 22.0,
                              ),
                              onPressed: null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/cart');
                            },
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_basket,
                                color: !widget.transparent
                                    ? (widget.bgColor == ArgonColors.white
                                        ? ArgonColors.initial
                                        : ArgonColors.white)
                                    : ArgonColors.white,
                                size: 22.0,
                              ),
                              onPressed: null,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                if (widget.searchBar)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    child: Input(
                      placeholder: "What are you looking for?",
                      controller: widget.searchController,
                      onChanged: widget.searchOnChanged,
                      autofocus: widget.searchAutofocus,
                      suffixIcon:
                          const Icon(Icons.zoom_in, color: ArgonColors.muted),
                      onTap: () {
                        Navigator.pushNamed(context, '/Products');
                      }, validator: (value) {  },
                    ),
                  ),
                const SizedBox(height: 10.0),
                if (categories)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/Products');
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.camera,
                                color: ArgonColors.initial, size: 22.0),
                            const SizedBox(width: 10),
                            Text(
                              widget.categoryOne,
                              style: const TextStyle(
                                color: ArgonColors.initial,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 30),
                      Container(
                        color: ArgonColors.initial,
                        height: 25,
                        width: 1,
                      ),
                      const SizedBox(width: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/cart');
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_cart,
                                color: ArgonColors.initial, size: 22.0),
                            const SizedBox(width: 10),
                            Text(
                              widget.categoryTwo,
                              style: const TextStyle(
                                color: ArgonColors.initial,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (tagsExist)
                  SizedBox(
                    height: 40,
                    child: ScrollablePositionedList.builder(
                      itemScrollController: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tags!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (activeTag != widget.tags![index]) {
                              setState(() => activeTag = widget.tags![index]);
                              _scrollController.scrollTo(
                                index: index == widget.tags!.length - 1 ? 1 : 0,
                                duration: const Duration(milliseconds: 420),
                                curve: Curves.easeIn,
                              );
                              widget.getCurrentPage!(activeTag);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 46 : 8, right: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 20),
                            decoration: BoxDecoration(
                              color: activeTag == widget.tags?[index]
                                  ? ArgonColors.primary
                                  : ArgonColors.secondary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: Center(
                              child: Text(
                                widget.tags![index],
                                style: TextStyle(
                                  color: activeTag == widget.tags?[index]
                                      ? ArgonColors.white
                                      : ArgonColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
