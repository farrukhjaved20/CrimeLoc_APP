import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:flutter/material.dart';

class SearchBarr extends StatefulWidget {
  const SearchBarr({super.key});

  @override
  _SearchBarrState createState() => _SearchBarrState();
}

class _SearchBarrState extends State<SearchBarr> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: StyleText.getRegularStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.textcolor,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bluecolor, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bluecolor)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.bluecolor)),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.bluecolor,
          ),
        ),
      ),
    );
  }
}
