import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/bottombar/bottom_bar.dart';
import 'package:pharmed_app/views/home/home_controller.dart';
import 'package:pharmed_app/views/home/widgets/medicine_container.dart';
import 'package:pharmed_app/widgets/custom_appbar.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/nav_item.dart';

class HomeView extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final HomeController controller = Get.put(HomeController());

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchPopularMedications(isLoadMore: true);
      }
    });

    controller.loadUserName();

    return WillPopScope(
      onWillPop: () async {
      bool shouldExit = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Exit Application"),
          content: Text("Are you sure you want to exit the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Close"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("OK"),
            ),
          ],
        ),
      );
      return shouldExit;
    },
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            scaffoldKey.currentState?.closeDrawer();
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                  right: screenWidth * 0.05),
                              child: Icon(
                                Icons.arrow_back,
                                size: 22,
                              ))),
                      CustomText(
                        text: 'setting'.tr,
                        weight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              buildDrawerItem(
                screenWidth,
                screenHeight,
                context
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: ScreenConstants.screenhorizontalPadding,
            right: ScreenConstants.screenhorizontalPadding,
            top: screenHeight * 0.055,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppbar(scaffoldKey: scaffoldKey),
              SizedBox(height: screenHeight * 0.04),
              Obx(
                () => Text(
                    controller.translatedText.value,
                    style: TextStyle(
                      color: ColorConstants.themecolor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
              ),
              SizedBox(height: 5),
              CustomText(
                text: 'welcome_to_dashboard'.tr,
                weight: FontWeight.w900,
                fontSize: 30,
              ),
              SizedBox(height: screenHeight * 0.035),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffF4E735),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: CustomText(
                      text: 'popular'.tr,
                      weight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => BottomNavigation(
                            initialIndex: 2,
                          ));
                    },
                    child: Row(
                      children: [
                        CustomText(
                          text: 'medical_history'.tr,
                          fontSize: 13,
                          color: ColorConstants.themecolor,
                          weight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorConstants.themecolor,
                        ),
                        SizedBox(width: 2),
                        Icon(
                          Icons.arrow_forward,
                          color: ColorConstants.themecolor,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.025),
              Obx(() {
                if (controller.isLoading.value) {
                  return Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.15),
                      child: Center(child: CircularProgressIndicator()));
                } else if (controller.medications.isEmpty) {
                  return Center(
                    child: CustomText(text: 'No Medication Found!'),
                  );
                }
                return Expanded(
                  child: Obx(() {
                    return GridView.builder(
                      controller: scrollController,
                      physics: AlwaysScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: controller.medications.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){},
                          child: MedicineContainer(
                            data: controller.medications[index],
                          ),
                        );
                      },
                    );
                  }),
                );
              }),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
