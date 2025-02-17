class PatientProfileResponse {
    PatientProfileResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    factory PatientProfileResponse.fromJson(Map<String, dynamic> json){ 
        return PatientProfileResponse(
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
        required this.name,
        required this.dob,
        required this.gender,
        required this.nationality,
        required this.weight,
        required this.lang,
        required this.term,
        required this.userId,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final String? name;
    final String? dob;
    final String? gender;
    final String? nationality;
    final String? weight;
    final String? lang;
    final dynamic term;
    final int? userId;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            name: json["name"],
            dob: json["dob"],
            gender: json["gender"],
            nationality: json["nationality"],
            weight: json["weight"],
            lang: json["lang"],
            term: json["term"],
            userId: json["user_id"],
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            id: json["id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob,
        "gender": gender,
        "nationality": nationality,
        "weight": weight,
        "lang": lang,
        "term": term,
        "user_id": userId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };

}
