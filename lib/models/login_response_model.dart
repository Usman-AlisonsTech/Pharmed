class LoginResponse {
    LoginResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<dynamic> data;
    final String? message;

    LoginResponse copyWith({
        bool? success,
        List<dynamic>? data,
        String? message,
    }) {
        return LoginResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory LoginResponse.fromJson(Map<String, dynamic> json){ 
        return LoginResponse(
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
