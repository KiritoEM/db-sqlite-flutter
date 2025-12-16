import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearchBar extends StatefulWidget {
  final Function(String value) onSearch;
  String placeholderText;

  CustomSearchBar({
    super.key,
    required this.onSearch,
    required this.placeholderText,
  });

  @override
  State<CustomSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<CustomSearchBar> {
  final controller = TextEditingController();
  Timer? _debounce;

  void _printLatestValue() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(controller.text);
    });
  }

  @override
  void initState() {
    _debounce?.cancel();
    super.initState();
    controller.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        hintText: widget.placeholderText,
        prefixIcon: Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: Icon(Icons.close),
              )
            : null,
      ),
    );
  }
}
