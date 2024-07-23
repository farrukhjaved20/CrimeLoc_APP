import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddIssue extends StatefulWidget {
  const AddIssue({super.key});

  @override
  State<AddIssue> createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  String? selectedValue;
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Karachi", child: Text("Karachi")),
      const DropdownMenuItem(value: "Lahore", child: Text("Lahore")),
      const DropdownMenuItem(value: "Faisalabad", child: Text("Faisalabad")),
      const DropdownMenuItem(value: "Islamabad", child: Text("Islamabad")),
    ];
    return menuItems;
  }

  String? areavalue;
  List<DropdownMenuItem<String>> get areadropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Karachi-Malir", child: Text("Karachi-Malir")),
      const DropdownMenuItem(
          value: "Lahore-District", child: Text("Lahore-District")),
      const DropdownMenuItem(
          value: "Faisalabad-District", child: Text("Faisalabad-District")),
      const DropdownMenuItem(
          value: "Islamabad-District", child: Text("Islamabad-District")),
    ];
    return menuItems;
  }

  String? crimeType;
  List<DropdownMenuItem<String>> get crimeTypeItems {
    List<DropdownMenuItem<String>> crimeType = [
      const DropdownMenuItem(
          value: "Mobile snatching", child: Text("Mobile snatching")),
      const DropdownMenuItem(value: "Kidnapping", child: Text("Kidnapping")),
      const DropdownMenuItem(
          value: "Vehicle Theft", child: Text("Vehicle Theft")),
      const DropdownMenuItem(value: "Burglary", child: Text("Burglary")),
    ];
    return crimeType;
  }

  DateTime? selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        setState(() {
          selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.whitecolor),
        backgroundColor: AppColors.bluecolor,
        centerTitle: true,
        title: Text(
          'Add A Crime Sence',
          style: StyleText.getBoldStyle(
            fontSize: height * 0.03,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DropdownButtonFormField(
                  focusColor: AppColors.bluecolor,
                  iconSize: 24,
                  icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                  iconEnabledColor: AppColors.bluecolor,
                  elevation: 0,
                  decoration: InputDecoration(
                    hintText: 'Select City',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.bluecolor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.bluecolor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          strokeAlign: 2, color: AppColors.bluecolor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                  value: selectedValue,
                  hint: const Text('Select City'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: DropdownButtonFormField(
                focusColor: AppColors.bluecolor,
                iconSize: 24,
                icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                iconEnabledColor: AppColors.bluecolor,
                decoration: InputDecoration(
                  hintText: 'Select Your Area',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.bluecolor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.bluecolor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        strokeAlign: 2, color: AppColors.bluecolor, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                dropdownColor: Colors.white,
                hint: const Text('Select Your Area'),
                value: areavalue,
                onChanged: (String? newValue) {
                  setState(() {
                    areavalue = newValue!;
                  });
                },
                items: areadropdownItems,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: DropdownButtonFormField(
                  focusColor: AppColors.bluecolor,
                  iconSize: 24,
                  icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                  iconEnabledColor: AppColors.bluecolor,
                  elevation: 0,
                  decoration: InputDecoration(
                    hintText: 'Select Crime Type',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.bluecolor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.bluecolor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          strokeAlign: 2, color: AppColors.bluecolor, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  dropdownColor: Colors.white,
                  value: crimeType,
                  hint: const Text('Select Crime Type'),
                  onChanged: (String? newValue) {
                    setState(() {
                      crimeType = newValue!;
                    });
                  },
                  items: crimeTypeItems),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => _selectDateTime(context),
              child: AbsorbPointer(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: selectedDateTime == null
                          ? 'Select Date and Time'
                          : DateFormat('d MMMM yyyy hh:mm a')
                              .format(selectedDateTime!),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 2, color: AppColors.bluecolor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 2, color: AppColors.bluecolor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(width: 2, color: AppColors.bluecolor),
                      ),
                      suffixIcon: Icon(Icons.calendar_today,
                          color: AppColors.bluecolor),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Add A Description',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.bluecolor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.bluecolor),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(width: 2, color: AppColors.bluecolor),
                  ),
                ),
                minLines: 10,
                maxLines: 10,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bluecolor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: StyleText.getRegularStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: height * 0.024,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
