// Packages
import 'package:flutter/material.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

// Common
import '../common/colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimSearchBar(
      color: Colors.white10,
      textFieldColor: searchBgColor,
      textFieldIconColor: iconColor,
      searchIconColor: iconColor,
      suffixIcon: const Icon(
        Icons.close,
        color: iconColor,
      ),
      width: 400,
      style: const TextStyle(
        color: textColor,
      ),
      textController: searchController,
      onSuffixTap: () {
        setState(() {
          searchController.clear();
        });
      },
      onSubmitted: (val) {
        setState(() {
          searchController.clear();
        });
      },
    );
  }
}
