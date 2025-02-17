import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pharmed_app/views/connect_phar/connect_phar_controller.dart';
import 'package:pharmed_app/widgets/custom_text.dart';
import 'package:pharmed_app/widgets/custom_textfield.dart';

class ConnectPharView extends StatefulWidget {
  final String medicineName;
  ConnectPharView({super.key, required this.medicineName});

  @override
  _ConnectPharViewState createState() => _ConnectPharViewState();
}

class _ConnectPharViewState extends State<ConnectPharView> {
  final controller = Get.put(ConnectPharController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.getUserId();
    controller.getThreadData(widget.medicineName);

     controller.timer = Timer.periodic(Duration(minutes: 1), (_) {
      controller.currentPage.value = 1;
      controller.threadDataList.clear();
      controller.getThreadData(widget.medicineName);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Fetch new messages when scrolling to the bottom
        controller.loadNewMessages(widget.medicineName);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'connect_pharm'.tr,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
          textAlign: TextAlign.center,
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        if (controller.threadDataList.isEmpty && controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: controller.threadDataList.length + 1,
              itemBuilder: (context, index) {
                if (index == controller.threadDataList.length) {
                  return controller.hasMoreData.value ? SizedBox() : SizedBox();
                }

                var message =
                    controller.threadDataList[index]; // No need to reverse
                bool isUserMessage = message.user?.id == controller.id.value;

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color:
                          isUserMessage ? Color(0XFF006FFD) : Color(0xffF8F9FE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: message.user?.username.toString() ??
                              'No user data',
                          fontSize: 14,
                          weight: FontWeight.w700,
                          color: isUserMessage
                              ? Color(0xffB4DBFF)
                              : Color(0xff71727A),
                        ),
                        SizedBox(height: 3),
                        CustomText(
                          text: message.comments ?? 'No comments',
                          fontSize: 14,
                          weight: FontWeight.w400,
                          color: isUserMessage ? Colors.white : Colors.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),

            /// Message Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.messageController,
                      hintText: 'type_message'.tr+'...',
                      borderRadius: 25,
                      borderColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  GestureDetector(
                    onTap: () {
                      controller.addThreadData(widget.medicineName,
                          controller.messageController.text);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
