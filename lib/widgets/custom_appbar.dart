import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/views/search/search_screen/search_view.dart';

class CustomAppbar extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  CustomAppbar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // color: Colors.red,
          child: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            icon: SvgPicture.asset('assets/svg/side-bar.svg'),
          ),
        ),
        SizedBox(width: screenWidth * 0.07),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(SearchView());
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xffF9F9F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(0xffDADADA),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Color(0xffDADADA),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'search_medication'.tr,
                      style: TextStyle(
                          color: Color(0xffDADADA),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
