class GetThreadResponse {
    GetThreadResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    factory GetThreadResponse.fromJson(Map<String, dynamic> json){ 
        return GetThreadResponse(
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

    final int? currentPage;
    final List<Datum> data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link> links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            currentPage: json["current_page"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            firstPageUrl: json["first_page_url"],
            from: json["from"],
            lastPage: json["last_page"],
            lastPageUrl: json["last_page_url"],
            links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
            nextPageUrl: json["next_page_url"],
            path: json["path"],
            perPage: json["per_page"],
            prevPageUrl: json["prev_page_url"],
            to: json["to"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data.map((x) => x?.toJson()).toList(),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links.map((x) => x?.toJson()).toList(),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };

}

class Datum {
    Datum({
        required this.id,
        required this.medicine,
        required this.comments,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    final int? id;
    final String? medicine;
    final String? comments;
    final int? userId;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final User? user;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            medicine: json["medicine"],
            comments: json["comments"],
            userId: json["user_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "medicine": medicine,
        "comments": comments,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
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
    final String? phone;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? status;
    final int? patientId;
    final dynamic doctorId;
    final dynamic preferredLang;

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

class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    final String? url;
    final String? label;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json){ 
        return Link(
            url: json["url"],
            label: json["label"],
            active: json["active"],
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };

}
