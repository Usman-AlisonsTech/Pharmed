class SignUpErrorResponse {
    SignUpErrorResponse({
        required this.success,
        required this.message,
        required this.errors,
    });

    final bool? success;
    final String? message;
    final Errors? errors;

    factory SignUpErrorResponse.fromJson(Map<String, dynamic> json){ 
        return SignUpErrorResponse(
            success: json["success"],
            message: json["message"],
            errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "errors": errors?.toJson(),
    };

}

class Errors {
    Errors({
        required this.email,
    });

    final List<String> email;

    factory Errors.fromJson(Map<String, dynamic> json){ 
        return Errors(
            email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email.map((x) => x).toList(),
    };

}
