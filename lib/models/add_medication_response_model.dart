class AddMedication {
    AddMedication({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final bool? data;
    final String? message;

    factory AddMedication.fromJson(Map<String, dynamic> json){ 
        return AddMedication(
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
