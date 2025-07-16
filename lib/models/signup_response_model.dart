class SignUpResponse {
    SignUpResponse({
        required this.data,
    });

    final Data? data;

    SignUpResponse copyWith({
        Data? data,
    }) {
        return SignUpResponse(
            data: data ?? this.data,
        );
    }

    factory SignUpResponse.fromJson(Map<String, dynamic> json){ 
        return SignUpResponse(
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.resourceType,
        required this.issue,
    });

    final String? resourceType;
    final List<Issue> issue;

    Data copyWith({
        String? resourceType,
        List<Issue>? issue,
    }) {
        return Data(
            resourceType: resourceType ?? this.resourceType,
            issue: issue ?? this.issue,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            resourceType: json["resourceType"],
            issue: json["issue"] == null ? [] : List<Issue>.from(json["issue"]!.map((x) => Issue.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "resourceType": resourceType,
        "issue": issue.map((x) => x?.toJson()).toList(),
    };

}

class Issue {
    Issue({
        required this.severity,
        required this.code,
        required this.details,
        required this.diagnostics,
    });

    final String? severity;
    final String? code;
    final Details? details;
    final dynamic diagnostics;

    Issue copyWith({
        String? severity,
        String? code,
        Details? details,
        dynamic? diagnostics,
    }) {
        return Issue(
            severity: severity ?? this.severity,
            code: code ?? this.code,
            details: details ?? this.details,
            diagnostics: diagnostics ?? this.diagnostics,
        );
    }

    factory Issue.fromJson(Map<String, dynamic> json){ 
        return Issue(
            severity: json["severity"],
            code: json["code"],
            details: json["details"] == null ? null : Details.fromJson(json["details"]),
            diagnostics: json["diagnostics"],
        );
    }

    Map<String, dynamic> toJson() => {
        "severity": severity,
        "code": code,
        "details": details?.toJson(),
        "diagnostics": diagnostics,
    };

}

class Details {
    Details({
        required this.text,
    });

    final String? text;

    Details copyWith({
        String? text,
    }) {
        return Details(
            text: text ?? this.text,
        );
    }

    factory Details.fromJson(Map<String, dynamic> json){ 
        return Details(
            text: json["text"],
        );
    }

    Map<String, dynamic> toJson() => {
        "text": text,
    };

}
