import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';
import 'package:pharmed_app/service/notification_service.dart';
import 'package:pharmed_app/utils/constants.dart';
import 'package:pharmed_app/views/notification/notification_controller.dart';
import 'package:pharmed_app/views/notification/widgets/notification_container.dart';
import 'package:pharmed_app/widgets/custom_text.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  var selectedDate = DateTime.now();
  TimeOfDay? selectedTime;
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (picked != null) {
        setState(() {
          selectedTime = picked;
        });
      }
    }

    void _scheduleNotification() {
      if (selectedTime != null) {
        DateTime now = DateTime.now();
        DateTime scheduledDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          selectedTime!.hour,
          selectedTime!.minute,
        );

        Duration delay = scheduledDateTime.difference(now);

        if (delay.isNegative) {
          // If selected time is in the past, schedule it for the next day
          scheduledDateTime = scheduledDateTime.add(const Duration(days: 1));
          delay = scheduledDateTime.difference(now);
        }

        Future.delayed(delay, () {
          NotiService().showNotification(
            title: "Scheduled Notification",
            body: "This is your reminder!",
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Notification scheduled at ${DateFormat.jm().format(scheduledDateTime)}"),
          ),
        );
      }
    }

    controller
        .fetchNotifications(DateFormat('yyyy-MM-dd').format(selectedDate));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenConstants.screenhorizontalPadding,
              right: ScreenConstants.screenhorizontalPadding,
              top: screenHeight * 0.04,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('dd').format(selectedDate),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontFamily: 'Poppins'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE').format(selectedDate),
                              style: const TextStyle(
                                  color: Color(0xff1204AA),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat('MMMM').format(selectedDate),
                                  style: const TextStyle(
                                      color: Color(0xff1204AA),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  DateFormat('yyyy').format(selectedDate),
                                  style: const TextStyle(
                                      color: Color(0xff1204AA),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    if (controller.getFormattedDate(selectedDate).isNotEmpty)
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xffe8e9f4),
                          ),
                          padding: const EdgeInsets.all(10),
                          width: 83,
                          height: 44,
                          child: Center(
                            child: CustomText(
                              text: controller.getFormattedDate(selectedDate),
                              weight: FontWeight.w600,
                              color: const Color(0xff1722BF),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                HorizontalWeekCalendar(
                  minDate: DateTime(2015, 12, 31),
                  maxDate: DateTime(2030, 1, 31),
                  initialDate: DateTime.now(),
                  onDateChange: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                    controller.fetchNotifications(
                        DateFormat('yyyy-MM-dd').format(selectedDate));
                  },
                  showTopNavbar: false,
                  monthFormat: "MMMM yyyy",
                  weekStartFrom: WeekStartFrom.Monday,
                  borderRadius: BorderRadius.circular(7),
                  activeBackgroundColor: ColorConstants.themecolor,
                  activeTextColor: Colors.white,
                  inactiveBackgroundColor: Colors.white,
                  inactiveTextColor: Colors.black,
                  disabledTextColor: Colors.black,
                  disabledBackgroundColor: Colors.white,
                  activeNavigatorColor: Colors.deepPurple,
                  inactiveNavigatorColor: Colors.grey,
                  monthColor: Colors.deepPurple,
                ),
                SizedBox(height: screenHeight * 0.05),
                Row(
                  children: [
                    CustomText(
                      text: 'time'.tr,
                      fontSize: 14,
                      color: Color(0xffBCC1CD),
                      weight: FontWeight.w500,
                    ),
                    SizedBox(width: screenWidth * 0.18),
                    CustomText(
                      text: 'medication'.tr,
                      fontSize: 14,
                      color: Color(0xffBCC1CD),
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.notifications.isEmpty) {
                    return const Center(
                        child: CustomText(text: "No notifications available"));
                  }

                  return Column(
                    children: controller.notifications.map((notification) {
                      // Format the DateTime object
                      String formattedTime =
                          DateFormat('h:mm a').format(notification.schedule);

                      controller.fetchMedicineTranslations(
                          [notification.medicalHistory.medicine]);
                      controller.fetchFrequencyTranslations(
                          [notification.medicalHistory.frequency]);

                      String translatedName = controller.translatedMedicines[
                              notification.medicalHistory.medicine] ??
                          notification.medicalHistory.medicine ??
                          '';
                      String translatedFrequency =
                          controller.translatedFrequency[
                                  notification.medicalHistory.frequency] ??
                              notification.medicalHistory.frequency ??
                              '';

                      return NotificationContainer(
                        title: translatedName,
                        subtitle: translatedFrequency,
                        time: formattedTime,
                      );
                    }).toList(),
                  );
                }),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
