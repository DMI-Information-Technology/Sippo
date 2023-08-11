import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';

class MySearchDelegate extends SearchDelegate {
  List<String?>? suggestions = [];
  final void Function(String) onSelectedSearch;
  final String? hintText;

  // final Widget? pageTitle;
  final String? pageTitle;
  final TextStyle? textFieldStyle;
  final Widget Function(BuildContext, int, String) buildResultSearch;

  MySearchDelegate({
    this.suggestions,
    this.hintText,
    this.pageTitle,
    this.textFieldStyle,
    required this.onSelectedSearch,
    required this.buildResultSearch,
  }) : super(
          searchFieldLabel: hintText,
          searchFieldStyle: textFieldStyle,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        labelStyle: TextStyle(fontSize: height / 64),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.trim().isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear_rounded)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    List<String?> filteredSuggestions = suggestions != null
        ? suggestions!.where(
            (resultSearch) {
              final result = resultSearch?.toLowerCase();
              final input = query.toLowerCase();
              return result != null && result.contains(input);
            },
          ).toList()
        : [];
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: height / 16, horizontal: width / 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pageTitle != null) ...[
            Text(
              pageTitle ?? "",
              style: dmsbold.copyWith(
                fontSize: height / 48,
                color: Jobstopcolor.primarycolor,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height / 100,
            )
          ],
          Expanded(
            child: ListView.builder(
                itemCount: filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = filteredSuggestions[index] ?? "";
                  return InkWell(
                    child: buildResultSearch(context, index, suggestion),
                    onTap: () {
                      query = suggestion;
                      onSelectedSearch(query);
                      close(context, null);
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String?> filteredSuggestions = suggestions != null
        ? suggestions!.where(
            (resultSearch) {
              final result = resultSearch?.toLowerCase();
              final input = query.toLowerCase();
              return result != null && result.contains(input);
            },
          ).toList()
        : [];
    return ListView.builder(
        itemCount: filteredSuggestions.length,
        itemBuilder: (context, index) {
          final suggestion = filteredSuggestions[index] ?? "";
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              if (query == suggestion) {
                showResults(context);
                return;
              }
              query = suggestion;
              // onSelectedSearch(query);
              // close(context, null);
            },
          );
        });
  }
}

class CustomSearchDelegate<T> extends SearchDelegate {
  List<T?>? suggestions = [];
  final void Function(T?) onSelectedSearch;
  final String? hintText;
  final String? pageTitle;
  final TextStyle? textFieldStyle;
  final bool Function(String, T?) onSelectedSuggestions;
  final String Function(T?) selectedSuggestion;
  final String Function(T?) buildSuggestionsText;
  final Widget Function(BuildContext, int, T?) buildResultSearch;
  final List<T?> Function(String, List<T?> list) onFilteredSuggestions;
  final double spaceBetween;

  CustomSearchDelegate({
    this.suggestions,
    this.hintText,
    this.pageTitle,
    this.textFieldStyle,
    required this.onSelectedSearch,
    required this.onSelectedSuggestions,
    required this.buildResultSearch,
    required this.selectedSuggestion,
    required this.buildSuggestionsText,
    required this.onFilteredSuggestions,
    this.spaceBetween = 0,
  }) : super(
          searchFieldLabel: hintText,
          searchFieldStyle: textFieldStyle,
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        labelStyle: TextStyle(fontSize: height / 64),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.trim().isEmpty)
              close(context, null);
            else
              query = '';
          },
          icon: Icon(Icons.clear_rounded)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    List<T?> filteredSuggestions =
        suggestions != null ? onFilteredSuggestions(query, suggestions!) : [];
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: height / 16, horizontal: width / 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (pageTitle != null) ...[
              Text(
                pageTitle ?? "",
                style: dmsbold.copyWith(
                  fontSize: height / 48,
                  color: Jobstopcolor.primarycolor,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: height / 100,
              )
            ],
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    SizedBox(height: spaceBetween),
                itemCount: filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = filteredSuggestions[index];
                  return InkWell(
                    child: buildResultSearch(context, index, suggestion),
                    onTap: () {
                      onSelectedSearch(suggestion);
                      close(context, null);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<T?> filteredSuggestions =
        suggestions != null ? onFilteredSuggestions(query, suggestions!) : [];
    return ListView.builder(
        itemCount: filteredSuggestions.length,
        itemBuilder: (context, index) {
          final suggestion = filteredSuggestions[index];
          return ListTile(
            title: Text(buildSuggestionsText(suggestion)),
            onTap: () {
              if (onSelectedSuggestions(query, suggestion)) {
                showResults(context);
                return;
              }
              query = selectedSuggestion(suggestion);
            },
          );
        });
  }
}
