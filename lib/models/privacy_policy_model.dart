class PrivacyPolicyResponse {
    PrivacyPolicyResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    PrivacyPolicyResponse copyWith({
        bool? success,
        Data? data,
        String? message,
    }) {
        return PrivacyPolicyResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory PrivacyPolicyResponse.fromJson(Map<String, dynamic> json){ 
        return PrivacyPolicyResponse(
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
        required this.content,
    });

    final String? content;

    Data copyWith({
        String? content,
    }) {
        return Data(
            content: content ?? this.content,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            content: json["content"],
        );
    }

    Map<String, dynamic> toJson() => {
        "content": content,
    };

}
