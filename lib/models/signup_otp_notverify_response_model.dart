class SignUpNotVerifyResponse {
    SignUpNotVerifyResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool? success;
    final String? message;
    final String? data;

    SignUpNotVerifyResponse copyWith({
        bool? success,
        String? message,
        String? data,
    }) {
        return SignUpNotVerifyResponse(
            success: success ?? this.success,
            message: message ?? this.message,
            data: data ?? this.data,
        );
    }

    factory SignUpNotVerifyResponse.fromJson(Map<String, dynamic> json){ 
        return SignUpNotVerifyResponse(
            success: json["success"],
            message: json["message"],
            data: json["data"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
    };

}
