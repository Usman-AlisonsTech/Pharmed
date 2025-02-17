class SignUpResponse {
    SignUpResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<dynamic> data;
    final String? message;

    SignUpResponse copyWith({
        bool? success,
        List<dynamic>? data,
        String? message,
    }) {
        return SignUpResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory SignUpResponse.fromJson(Map<String, dynamic> json){ 
        return SignUpResponse(
            success: json["success"],
            data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.map((x) => x).toList(),
        "message": message,
    };

}
