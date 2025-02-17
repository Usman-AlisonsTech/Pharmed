class SentOtpResponse {
    SentOtpResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final bool? data;
    final String? message;

    SentOtpResponse copyWith({
        bool? success,
        bool? data,
        String? message,
    }) {
        return SentOtpResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory SentOtpResponse.fromJson(Map<String, dynamic> json){ 
        return SentOtpResponse(
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
