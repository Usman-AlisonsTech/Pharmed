class UpdateMedicationResponse {
    UpdateMedicationResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final bool? data;
    final String? message;

    factory UpdateMedicationResponse.fromJson(Map<String, dynamic> json){ 
        return UpdateMedicationResponse(
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
