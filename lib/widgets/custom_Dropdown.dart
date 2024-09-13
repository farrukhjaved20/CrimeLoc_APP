import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:flutter/material.dart';

class CustomDropdownTextFormField extends StatelessWidget {
  final Map<String, String> options;
  final String? selectedValue;
  final Function(String) onChanged;
  final String labelTitle; // Added label title parameter
  final String hintTitle; // Added label title parameter

  const CustomDropdownTextFormField({
    super.key,
    required this.options,
    this.selectedValue,
    required this.onChanged,
    required this.labelTitle,
    required this.hintTitle, // Initialize the label title
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: DropdownButtonFormField<String>(
          value: selectedValue,
          isExpanded: true,
          iconSize: 24,
          icon: Icon(
            Icons.arrow_downward,
            color: AppColors.kappRedColor,
          ),
          items: options.keys.map((String option) {
            return DropdownMenuItem<String>(
              value: options[option],
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500, // Font weight of 500
                ),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              onChanged(value);
            }
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: AppColors.kappBlueColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: AppColors.kappBlueColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: AppColors.kappBlueColor),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelTitle,
            hintText: hintTitle,
            hintStyle: StyleText.getRegularStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.kappBlueColor,
            ),
          )),
    );
  }
}
