class TermsAndConditionModel {
    TermsAndConditionModel({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    factory TermsAndConditionModel.fromJson(Map<String, dynamic> json){ 
        return TermsAndConditionModel(
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

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            content: json["content"],
        );
    }

    Map<String, dynamic> toJson() => {
        "content": content,
    };

}
