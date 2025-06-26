class LoginTestOtpResponse {
    LoginTestOtpResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    LoginTestOtpResponse copyWith({
        bool? success,
        Data? data,
        String? message,
    }) {
        return LoginTestOtpResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory LoginTestOtpResponse.fromJson(Map<String, dynamic> json){ 
        return LoginTestOtpResponse(
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
        required this.token,
        required this.firstName,
        required this.lastName,
        required this.userType,
        required this.permissions,
        required this.email,
        required this.status,
        required this.phone,
        required this.roleId,
        required this.userId,
        required this.roleName,
    });

    final String? token;
    final dynamic firstName;
    final dynamic lastName;
    final String? userType;
    final List<dynamic> permissions;
    final String? email;
    final int? status;
    final dynamic phone;
    final String? roleId;
    final int? userId;
    final String? roleName;

    Data copyWith({
        String? token,
        dynamic? firstName,
        dynamic? lastName,
        String? userType,
        List<dynamic>? permissions,
        String? email,
        int? status,
        dynamic? phone,
        String? roleId,
        int? userId,
        String? roleName,
    }) {
        return Data(
            token: token ?? this.token,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            userType: userType ?? this.userType,
            permissions: permissions ?? this.permissions,
            email: email ?? this.email,
            status: status ?? this.status,
            phone: phone ?? this.phone,
            roleId: roleId ?? this.roleId,
            userId: userId ?? this.userId,
            roleName: roleName ?? this.roleName,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            token: json["token"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            userType: json["user_type"],
            permissions: json["permissions"] == null ? [] : List<dynamic>.from(json["permissions"]!.map((x) => x)),
            email: json["email"],
            status: json["status"],
            phone: json["phone"],
            roleId: json["role_id"],
            userId: json["user_id"],
            roleName: json["role_name"],
        );
    }

    Map<String, dynamic> toJson() => {
        "token": token,
        "first_name": firstName,
        "last_name": lastName,
        "user_type": userType,
        "permissions": permissions.map((x) => x).toList(),
        "email": email,
        "status": status,
        "phone": phone,
        "role_id": roleId,
        "user_id": userId,
        "role_name": roleName,
    };

}
