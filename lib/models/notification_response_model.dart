class NotificationResponse {
  bool success;
  List<Datum> data;
  String message;

  NotificationResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      success: json['success'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
      message: json['message'],
    );
  }
}

class Datum {
  int id;
  DateTime schedule;
  int medicalHistoryId;
  int patientUserId;
  DateTime createdAt;
  DateTime updatedAt;
  MedicalHistory medicalHistory;

  Datum({
    required this.id,
    required this.schedule,
    required this.medicalHistoryId,
    required this.patientUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.medicalHistory,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      schedule: DateTime.parse(json['schedule']),
      medicalHistoryId: json['medical_history_id'],
      patientUserId: json['patient_user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      medicalHistory: MedicalHistory.fromJson(json['medical_history']),
    );
  }
}

class MedicalHistory {
  int id;
  String medicine;
  String physicianName;
  DateTime startDate;
  DateTime endDate;
  String dosage;
  String frequency;
  String reason;
  int patientUserId;
  DateTime createdAt;
  DateTime updatedAt;

  MedicalHistory({
    required this.id,
    required this.medicine,
    required this.physicianName,
    required this.startDate,
    required this.endDate,
    required this.dosage,
    required this.frequency,
    required this.reason,
    required this.patientUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicalHistory.fromJson(Map<String, dynamic> json) {
    return MedicalHistory(
      id: json['id'],
      medicine: json['medicine'],
      physicianName: json['physician_name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      dosage: json['dosage'],
      frequency: json['frequency'],
      reason: json['reason'],
      patientUserId: json['patient_user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
