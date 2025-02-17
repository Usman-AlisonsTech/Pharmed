class SuggestionResponse {
    SuggestionResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<Datum> data;
    final String? message;

    factory SuggestionResponse.fromJson(Map<String, dynamic> json){ 
        return SuggestionResponse(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.map((x) => x?.toJson()).toList(),
        "message": message,
    };

}

class Datum {
    Datum({
        required this.id,
        required this.genericName,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? genericName;
    final dynamic createdAt;
    final dynamic updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            genericName: json["generic_name"],
            createdAt: json["created_at"],
            updatedAt: json["updated_at"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "generic_name": genericName,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };

}
