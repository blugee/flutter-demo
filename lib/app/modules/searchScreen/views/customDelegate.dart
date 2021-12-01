import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:mocci/app/data/constants.dart';

class CustomDelegate extends SearchDelegate<String> {
  CustomDelegate({
    @required String hintText,
  }) : super(
          searchFieldLabel: hintText,
          searchFieldStyle: TextStyle(fontSize: 16),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );
  List<String> data = nouns.take(100).toList();

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => BackButton(
        color: kColors.DARK_BLUE,
      );
  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    var listToShow;
    if (query.isNotEmpty)
      listToShow =
          data.where((e) => e.contains(query) && e.startsWith(query)).toList();
    else
      listToShow = data;

    return ListView.builder(
      itemCount: listToShow.length,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (_, i) {
        var noun = listToShow[i];
        return ListTile(
          title: Text(noun),
          onTap: () => close(context, noun),
        );
      },
    );
  }
}
