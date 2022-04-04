import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function onSearch;

  const SearchBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();

    void _onSearch(String val) {
      onSearch(val);
    }

    return Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          suffix: GestureDetector(
            onTap: () => _onSearch(_controller.text),
            child: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 20,
            ),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 99, 86, 86))),
        ),
        onSubmitted: (val) => _onSearch(val),
      ),
    );
  }
}
