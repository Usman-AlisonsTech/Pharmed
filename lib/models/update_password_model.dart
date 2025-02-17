class UpdatePasswordResponse {
    UpdatePasswordResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    UpdatePasswordResponse copyWith({
        bool? success,
        Data? data,
        String? message,
    }) {
        return UpdatePasswordResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory UpdatePasswordResponse.fromJson(Map<String, dynamic> json){ 
        return UpdatePasswordResponse(
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
    };

}

class Data {
    Data({
        required this.id,
        required this.username,
        required this.name,
        required this.email,
        required this.userType,
        required this.verificationCode,
        required this.emailVerifiedAt,
        required this.userImage,
        required this.otp,
        required this.phone,
        required this.createdAt,
        required this.updatedAt,
        required this.status,
        required this.patientId,
        required this.doctorId,
        required this.preferredLang,
    });

    final int? id;
    final String? username;
    final String? name;
    final String? email;
    final String? userType;
    final String? verificationCode;
    final dynamic emailVerifiedAt;
    final dynamic userImage;
    final dynamic otp;
    final String? phone;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? status;
    final int? patientId;
    final int? doctorId;
    final dynamic preferredLang;

    Data copyWith({
        int? id,
        String? username,
        String? name,
        String? email,
        String? userType,
        String? verificationCode,
        dynamic? emailVerifiedAt,
        dynamic? userImage,
        dynamic? otp,
        String? phone,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? status,
        int? patientId,
        int? doctorId,
        dynamic? preferredLang,
    }) {
        return Data(
            id: id ?? this.id,
            username: username ?? this.username,
            name: name ?? this.name,
            email: email ?? this.email,
            userType: userType ?? this.userType,
            verificationCode: verificationCode ?? this.verificationCode,
            emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
            userImage: userImage ?? this.userImage,
            otp: otp ?? this.otp,
            phone: phone ?? this.phone,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            status: status ?? this.status,
            patientId: patientId ?? this.patientId,
            doctorId: doctorId ?? this.doctorId,
            preferredLang: preferredLang ?? this.preferredLang,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            username: json["username"],
            name: json["name"],
            email: json["email"],
            userType: json["user_type"],
            verificationCode: json["verification_code"],
            emailVerifiedAt: json["email_verified_at"],
            userImage: json["user_image"],
            otp: json["otp"],
            phone: json["phone"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            status: json["status"],
            patientId: json["patient_id"],
            doctorId: json["doctor_id"],
            preferredLang: json["preferred_lang"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "name": name,
        "email": email,
        "user_type": userType,
        "verification_code": verificationCode,
        "email_verified_at": emailVerifiedAt,
        "user_image": userImage,
        "otp": otp,
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "patient_id": patientId,
        "doctor_id": doctorId,
        "preferred_lang": preferredLang,
    };

}
