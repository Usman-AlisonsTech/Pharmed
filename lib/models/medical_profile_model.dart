class MedicalProfileResponse {
    MedicalProfileResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    MedicalProfileResponse copyWith({
        bool? success,
        Data? data,
        String? message,
    }) {
        return MedicalProfileResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory MedicalProfileResponse.fromJson(Map<String, dynamic> json){ 
        return MedicalProfileResponse(
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
        required this.fullName,
        required this.institute,
        required this.status,
        required this.userId,
        required this.field,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.documents,
    });

    final int? id;
    final String? fullName;
    final String? institute;
    final int? status;
    final int? userId;
    final String? field;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final User? user;
    final List<Document> documents;

    Data copyWith({
        int? id,
        String? fullName,
        String? institute,
        int? status,
        int? userId,
        String? field,
        DateTime? createdAt,
        DateTime? updatedAt,
        User? user,
        List<Document>? documents,
    }) {
        return Data(
            id: id ?? this.id,
            fullName: fullName ?? this.fullName,
            institute: institute ?? this.institute,
            status: status ?? this.status,
            userId: userId ?? this.userId,
            field: field ?? this.field,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
            documents: documents ?? this.documents,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            fullName: json["full_name"],
            institute: json["institute"],
            status: json["status"],
            userId: json["user_id"],
            field: json["field"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "institute": institute,
        "status": status,
        "user_id": userId,
        "field": field,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "documents": documents.map((x) => x?.toJson()).toList(),
    };

}

class Document {
    Document({
        required this.id,
        required this.document,
        required this.documentType,
        required this.doctorId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final List<String> document;
    final String? documentType;
    final int? doctorId;
    final int? status;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Document copyWith({
        int? id,
        List<String>? document,
        String? documentType,
        int? doctorId,
        int? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) {
        return Document(
            id: id ?? this.id,
            document: document ?? this.document,
            documentType: documentType ?? this.documentType,
            doctorId: doctorId ?? this.doctorId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    factory Document.fromJson(Map<String, dynamic> json){ 
        return Document(
            id: json["id"],
            document: json["document"] == null ? [] : List<String>.from(json["document"]!.map((x) => x)),
            documentType: json["document_type"],
            doctorId: json["doctor_id"],
            status: json["status"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "document": document.map((x) => x).toList(),
        "document_type": documentType,
        "doctor_id": doctorId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}

class User {
    User({
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
    final dynamic verificationCode;
    final dynamic emailVerifiedAt;
    final dynamic userImage;
    final dynamic otp;
    final dynamic phone;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? status;
    final int? patientId;
    final int? doctorId;
    final dynamic preferredLang;

    User copyWith({
        int? id,
        String? username,
        String? name,
        String? email,
        String? userType,
        dynamic? verificationCode,
        dynamic? emailVerifiedAt,
        dynamic? userImage,
        dynamic? otp,
        dynamic? phone,
        DateTime? createdAt,
        DateTime? updatedAt,
        int? status,
        int? patientId,
        int? doctorId,
        dynamic? preferredLang,
    }) {
        return User(
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

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
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
