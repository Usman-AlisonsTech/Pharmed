class ConfirmPasswordResponse {
    ConfirmPasswordResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final bool? data;
    final String? message;

    ConfirmPasswordResponse copyWith({
        bool? success,
        bool? data,
        String? message,
    }) {
        return ConfirmPasswordResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory ConfirmPasswordResponse.fromJson(Map<String, dynamic> json){ 
        return ConfirmPasswordResponse(
            success: json["success"],
            data: json["data"],
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
    };

}
