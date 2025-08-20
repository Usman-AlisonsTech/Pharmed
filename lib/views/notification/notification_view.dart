import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmed_app/views/theme_controller.dart';
import 'package:pharmed_app/widgets/common_button.dart';
import 'package:table_calendar/table_calendar.dart';
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
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();

  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    controller
        .fetchNotifications(DateFormat('yyyy-MM-dd').format(selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: ScreenConstants.screenhorizontalPadding,
              right: ScreenConstants.screenhorizontalPadding,
              top: screenHeight * 0.04,
            ),
            child: Column(
              children: [
                TableCalendar(
                  calendarFormat: CalendarFormat.month,
                  firstDay: DateTime(2015),
                  lastDay: DateTime(2040),
                  focusedDay: focusedDate,
                  currentDay: selectedDate,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // headerVisible: false,
                  daysOfWeekHeight: 20,
                  rowHeight: 60,
                  calendarStyle: CalendarStyle(
                    cellMargin: const EdgeInsets.all(2),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: ColorConstants.themecolor, width: 2),
                    ),
                    todayTextStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: ColorConstants.themecolor,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    defaultDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    weekendDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    outsideDecoration:
                        const BoxDecoration(shape: BoxShape.circle),
                  ),
                  selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDate = selected;
                      focusedDate = focused;
                    });
                    controller.fetchNotifications(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                    );
                  },
                ),
      
                SizedBox(height: screenHeight * 0.05),
                /// Notifications List
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
                      String formattedTime =
                          DateFormat('h:mm a').format(notification.schedule);
      
                      controller.fetchMedicineTranslations(
                          [notification.medicalHistory.medicine]);
                      controller.fetchFrequencyTranslations(
                          [notification.medicalHistory.frequency]);
                      controller.fetchDosageTranslations(
                          [notification.medicalHistory.dosage]);
                      controller.fetchNoteTranslations(
                          [notification.medicalHistory.reason]);
      
                      String translatedName = controller.translatedMedicines[
                              notification.medicalHistory.medicine] ??
                          notification.medicalHistory.medicine ??
                          '';
                      String translatedFrequency = controller.translatedFrequency[
                              notification.medicalHistory.frequency] ??
                          notification.medicalHistory.frequency ??
                          '';
                      String translatedDosage = controller.translatedDosage[
                              notification.medicalHistory.dosage] ??
                          notification.medicalHistory.dosage ??
                          '';
                      String translatedNote = controller.translatedNote[
                              notification.medicalHistory.reason] ??
                          notification.medicalHistory.reason ??
                          '';
      
                      return NotificationContainer(
                        title: translatedName,
                        frequency: translatedFrequency,
                        time: formattedTime,
                        dosage: translatedDosage,
                        note: translatedNote,
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
