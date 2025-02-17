class AddThreadResponse {
    AddThreadResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final bool? data;
    final String? message;

    AddThreadResponse copyWith({
        bool? success,
        bool? data,
        String? message,
    }) {
        return AddThreadResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory AddThreadResponse.fromJson(Map<String, dynamic> json){ 
        return AddThreadResponse(
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
