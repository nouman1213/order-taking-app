import 'package:flutter/material.dart';


// ignore: must_be_immutable
class MydropDownButton extends StatefulWidget {
  MydropDownButton(
      {super.key,
      required this.title,
      required this.value,
      required this.onChanged,
      required this.validator,
      required this.dropDownItems});

  String? title;
  void Function(Object?)? onChanged;
  String? Function(Object?)? validator;
  Object? value;
  List<DropdownMenuItem<String>> dropDownItems;

  @override
  State<MydropDownButton> createState() => _MydropDownButtonState();
}

class _MydropDownButtonState extends State<MydropDownButton> {
  List<DropdownMenuItem<Object>>? items;
  String? _searchText;

  List<DropdownMenuItem<String>> get _filteredItems {
    if (_searchText == null || _searchText!.isEmpty) {
      return widget.dropDownItems;
    }
    return widget.dropDownItems
        .where((item) => item.child
            .toString()
            .toLowerCase()
            .contains(_searchText!.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.title}',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              iconSize: 20,
              iconEnabledColor: Colors.black,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                iconColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                isDense: true,
                fillColor: Theme.of(context).colorScheme.primary,
              ),
              validator: widget.validator,
              dropdownColor: Theme.of(context).colorScheme.primary,
              focusColor: Theme.of(context).colorScheme.onPrimary,
              value: widget.value,
              onChanged: widget.onChanged,
              items: _filteredItems,
            ),
          ],
        ),
      ],
    );
  }
}
