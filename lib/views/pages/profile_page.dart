import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bluecolor,
        centerTitle: true,
        title: Text(
          'Profile',
          style: StyleText.getBoldStyle(
            fontSize: height * 0.03,
            color: AppColors.whitecolor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'Name',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'Phone Number',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                color: AppColors.textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'Email',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                fontWeight: FontWeight.w400,
                color: AppColors.textcolor,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
          ListTile(
            title: Text(
              'Password',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.022,
                fontWeight: FontWeight.w400,
                color: AppColors.textcolor,
              ),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.bluecolor,
                )),
          ),
        ],
      ),
    );
  }
}
