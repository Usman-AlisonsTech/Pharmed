class ProfileDetailResponse {
    ProfileDetailResponse({
        required this.data,
    });

    final Data? data;

    ProfileDetailResponse copyWith({
        Data? data,
    }) {
        return ProfileDetailResponse(
            data: data ?? this.data,
        );
    }

    factory ProfileDetailResponse.fromJson(Map<String, dynamic> json){ 
        return ProfileDetailResponse(
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
        required this.id,
        required this.identifier,
        required this.active,
        required this.name,
        required this.gender,
        required this.birthDate,
        required this.deceasedDateTime,
        required this.telecom,
        required this.address,
        required this.maritalStatus,
        required this.communication,
        required this.extension,
    });

    final String? resourceType;
    final String? id;
    final List<Identifier> identifier;
    final bool? active;
    final List<Name> name;
    final String? gender;
    final DateTime? birthDate;
    final dynamic deceasedDateTime;
    final List<Telecom> telecom;
    final List<MaritalStatus> address;
    final MaritalStatus? maritalStatus;
    final List<Communication> communication;
    final List<Extension> extension;

    Data copyWith({
        String? resourceType,
        String? id,
        List<Identifier>? identifier,
        bool? active,
        List<Name>? name,
        String? gender,
        DateTime? birthDate,
        dynamic? deceasedDateTime,
        List<Telecom>? telecom,
        List<MaritalStatus>? address,
        MaritalStatus? maritalStatus,
        List<Communication>? communication,
        List<Extension>? extension,
    }) {
        return Data(
            resourceType: resourceType ?? this.resourceType,
            id: id ?? this.id,
            identifier: identifier ?? this.identifier,
            active: active ?? this.active,
            name: name ?? this.name,
            gender: gender ?? this.gender,
            birthDate: birthDate ?? this.birthDate,
            deceasedDateTime: deceasedDateTime ?? this.deceasedDateTime,
            telecom: telecom ?? this.telecom,
            address: address ?? this.address,
            maritalStatus: maritalStatus ?? this.maritalStatus,
            communication: communication ?? this.communication,
            extension: extension ?? this.extension,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            resourceType: json["resourceType"],
            id: json["id"],
            identifier: json["identifier"] == null ? [] : List<Identifier>.from(json["identifier"]!.map((x) => Identifier.fromJson(x))),
            active: json["active"],
            name: json["name"] == null ? [] : List<Name>.from(json["name"]!.map((x) => Name.fromJson(x))),
            gender: json["gender"],
            birthDate: DateTime.tryParse(json["birthDate"] ?? ""),
            deceasedDateTime: json["deceasedDateTime"],
            telecom: json["telecom"] == null ? [] : List<Telecom>.from(json["telecom"]!.map((x) => Telecom.fromJson(x))),
            address: json["address"] == null ? [] : List<MaritalStatus>.from(json["address"]!.map((x) => MaritalStatus.fromJson(x))),
            maritalStatus: json["maritalStatus"] == null ? null : MaritalStatus.fromJson(json["maritalStatus"]),
            communication: json["communication"] == null ? [] : List<Communication>.from(json["communication"]!.map((x) => Communication.fromJson(x))),
            extension: json["extension"] == null ? [] : List<Extension>.from(json["extension"]!.map((x) => Extension.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "resourceType": resourceType,
        "id": id,
        "identifier": identifier.map((x) => x?.toJson()).toList(),
        "active": active,
        "name": name.map((x) => x?.toJson()).toList(),
        "gender": gender,
        "birthDate": birthDate?.toIso8601String(),
        "deceasedDateTime": deceasedDateTime,
        "telecom": telecom.map((x) => x?.toJson()).toList(),
        "address": address.map((x) => x?.toJson()).toList(),
        "maritalStatus": maritalStatus?.toJson(),
        "communication": communication.map((x) => x?.toJson()).toList(),
        "extension": extension.map((x) => x?.toJson()).toList(),
    };

}

class MaritalStatus {
    MaritalStatus({
        required this.text,
    });

    final String? text;

    MaritalStatus copyWith({
        String? text,
    }) {
        return MaritalStatus(
            text: text ?? this.text,
        );
    }

    factory MaritalStatus.fromJson(Map<String, dynamic> json){ 
        return MaritalStatus(
            text: json["text"],
        );
    }

    Map<String, dynamic> toJson() => {
        "text": text,
    };

}

class Communication {
    Communication({
        required this.language,
    });

    final MaritalStatus? language;

    Communication copyWith({
        MaritalStatus? language,
    }) {
        return Communication(
            language: language ?? this.language,
        );
    }

    factory Communication.fromJson(Map<String, dynamic> json){ 
        return Communication(
            language: json["language"] == null ? null : MaritalStatus.fromJson(json["language"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "language": language?.toJson(),
    };

}

class Extension {
    Extension({
        required this.url,
        required this.valueString,
    });

    final String? url;
    final String? valueString;

    Extension copyWith({
        String? url,
        String? valueString,
    }) {
        return Extension(
            url: url ?? this.url,
            valueString: valueString ?? this.valueString,
        );
    }

    factory Extension.fromJson(Map<String, dynamic> json){ 
        return Extension(
            url: json["url"],
            valueString: json["valueString"],
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
        "valueString": valueString,
    };

}

class Identifier {
    Identifier({
        required this.use,
        required this.value,
    });

    final String? use;
    final String? value;

    Identifier copyWith({
        String? use,
        String? value,
    }) {
        return Identifier(
            use: use ?? this.use,
            value: value ?? this.value,
        );
    }

    factory Identifier.fromJson(Map<String, dynamic> json){ 
        return Identifier(
            use: json["use"],
            value: json["value"],
        );
    }

    Map<String, dynamic> toJson() => {
        "use": use,
        "value": value,
    };

}

class Name {
    Name({
        required this.use,
        required this.text,
    });

    final String? use;
    final String? text;

    Name copyWith({
        String? use,
        String? text,
    }) {
        return Name(
            use: use ?? this.use,
            text: text ?? this.text,
        );
    }

    factory Name.fromJson(Map<String, dynamic> json){ 
        return Name(
            use: json["use"],
            text: json["text"],
        );
    }

    Map<String, dynamic> toJson() => {
        "use": use,
        "text": text,
    };

}

class Telecom {
    Telecom({
        required this.system,
        required this.value,
        required this.use,
    });

    final String? system;
    final String? value;
    final String? use;

    Telecom copyWith({
        String? system,
        String? value,
        String? use,
    }) {
        return Telecom(
            system: system ?? this.system,
            value: value ?? this.value,
            use: use ?? this.use,
        );
    }

    factory Telecom.fromJson(Map<String, dynamic> json){ 
        return Telecom(
            system: json["system"],
            value: json["value"],
            use: json["use"],
        );
    }

    Map<String, dynamic> toJson() => {
        "system": system,
        "value": value,
        "use": use,
    };

}
