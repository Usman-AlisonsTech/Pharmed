class GetMedicationResponse {
  bool success;
  Data data;
  String message;

  GetMedicationResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory GetMedicationResponse.fromJson(Map<String, dynamic> json) {
    return GetMedicationResponse(
      success: json['success'],
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class Data {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      currentPage: json['current_page'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: List<Link>.from(json['links'].map((x) => Link.fromJson(x))),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': List<dynamic>.from(links.map((x) => x.toJson())),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

class Datum {
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
  String imageUrl;
  PatientUser patientUser;
  List<MedicalSchedule> medicalSchedule;

  Datum({
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
    required this.imageUrl,
    required this.patientUser,
    required this.medicalSchedule,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
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
      imageUrl: json['image_url'],
      patientUser: PatientUser.fromJson(json['patient_user']),
      medicalSchedule: List<MedicalSchedule>.from(
        json['medical_schedule'].map((x) => MedicalSchedule.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicine': medicine,
      'physician_name': physicianName,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'dosage': dosage,
      'frequency': frequency,
      'reason': reason,
      'patient_user_id': patientUserId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'image_url': imageUrl,
      'patient_user': patientUser.toJson(),
      'medical_schedule': List<dynamic>.from(medicalSchedule.map((x) => x.toJson())),
    };
  }
}

class MedicalSchedule {
  int id;
  DateTime schedule;
  int medicalHistoryId;
  int patientUserId;
  DateTime createdAt;
  DateTime updatedAt;

  MedicalSchedule({
    required this.id,
    required this.schedule,
    required this.medicalHistoryId,
    required this.patientUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MedicalSchedule.fromJson(Map<String, dynamic> json) {
    return MedicalSchedule(
      id: json['id'],
      schedule: DateTime.parse(json['schedule']),
      medicalHistoryId: json['medical_history_id'],
      patientUserId: json['patient_user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schedule': schedule.toIso8601String(),
      'medical_history_id': medicalHistoryId,
      'patient_user_id': patientUserId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class PatientUser {
  int id;
  String? username;  // Add this field
  String? name;
  String email;
  String? userType;
  String? phone;
  DateTime createdAt;
  DateTime updatedAt;

  PatientUser({
    required this.id,
    this.username,  // Make it nullable
    this.name,
    required this.email,
    this.userType,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatientUser.fromJson(Map<String, dynamic> json) {
    return PatientUser(
      id: json['id'],
      username: json['username'],  // Map the field
      name: json['name'],
      email: json['email'],
      userType: json['user_type'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,  // Include in serialization
      'name': name,
      'email': email,
      'user_type': userType,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}


class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}
