import 'package:crime_heat/screens/homepage/components_bottomnav/Profile/change_name.dart';
import 'package:crime_heat/screens/homepage/components_bottomnav/Profile/view_history_crimes.dart';
import 'package:crime_heat/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:crime_heat/services/authenticationController.dart';
import 'package:crime_heat/constant/constant.dart';
import 'package:crime_heat/constant/fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;

    return GetBuilder<AuthenticationController>(
      initState: (state) => Get.find<AuthenticationController>().getData(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.kappBlueColor,
            centerTitle: true,
            title: Text(
              'Profile',
              style: StyleText.getBoldStyle(
                fontSize: height * 0.024,
                color: AppColors.whitecolor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              controller.user.value.profileUrl != null
                                  ? NetworkImage(
                                      controller.user.value.profileUrl ?? "")
                                  : const NetworkImage(
                                      'https://img.freepik.com/free-psd/3d-illustration-human-avatar-profile_23-2150671142.jpg?size=338&ext=jpg&ga=GA1.1.2008272138.1722556800&semt=ais_hybrid',
                                    ),
                        ),
                      ),
                      Obx(
                        () {
                          return controller.isUploading.value
                              ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: controller.uploadProgress.value /
                                            100,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox
                                  .shrink(); // No progress indicator
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,
                              color: controller.isUploading.value
                                  ? Colors.grey
                                  : Colors.white),
                          onPressed: controller.isUploading.value
                              ? null
                              : () {
                                  controller.pickImage();
                                },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ChangeNamePage());
                  },
                  child: Obx(
                    () {
                      return ListTile(
                        subtitle: Text(controller.user.value.name ?? "No Name"),
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
                            color: AppColors.kappRedColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Obx(
                  () {
                    return ListTile(
                      subtitle: Text(controller.user.value.email ?? "No Email"),
                      title: Text(
                        'Email',
                        style: StyleText.getBoldStyle(
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textcolor,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                    title: Text(
                      'Your History',
                      style: StyleText.getBoldStyle(
                        fontSize: height * 0.022,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textcolor,
                      ),
                    ),
                    trailing: SizedBox(
                      height: 50,
                      width: 100,
                      child: AppButton(
                        text: 'View',
                        showLoader: false,
                        onPressed: () {
                          Get.to(() => const CrimeHistoryScreen());
                        },
                      ),
                    )),
                const SizedBox(height: 30),
                // ListTile(
                //     title: Text(
                //       'Trending Crimes',
                //       style: StyleText.getBoldStyle(
                //         fontSize: height * 0.022,
                //         fontWeight: FontWeight.w400,
                //         color: AppColors.textcolor,
                //       ),
                //     ),
                //     trailing: SizedBox(
                //       height: 50,
                //       width: 100,
                //       child: AppButton(
                //         text: 'View',
                //         showLoader: false,
                //         onPressed: () {
                //           Get.to(() => const CrimeTrendsScreen());
                //         },
                //       ),
                //     )),
              ],
            ),
          ),
        );
      },
    );
  }
}
