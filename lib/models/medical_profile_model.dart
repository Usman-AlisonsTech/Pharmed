class MedicalProfileResponse {
    MedicalProfileResponse({
        required this.resourceType,
        required this.type,
        required this.entry,
    });

    final String? resourceType;
    final String? type;
    final List<Entry> entry;

    MedicalProfileResponse copyWith({
        String? resourceType,
        String? type,
        List<Entry>? entry,
    }) {
        return MedicalProfileResponse(
            resourceType: resourceType ?? this.resourceType,
            type: type ?? this.type,
            entry: entry ?? this.entry,
        );
    }

    factory MedicalProfileResponse.fromJson(Map<String, dynamic> json){ 
        return MedicalProfileResponse(
            resourceType: json["resourceType"],
            type: json["type"],
            entry: json["entry"] == null ? [] : List<Entry>.from(json["entry"]!.map((x) => Entry.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "resourceType": resourceType,
        "type": type,
        "entry": entry.map((x) => x?.toJson()).toList(),
    };

}

class Entry {
    Entry({
        required this.resource,
    });

    final Resource? resource;

    Entry copyWith({
        Resource? resource,
    }) {
        return Entry(
            resource: resource ?? this.resource,
        );
    }

    factory Entry.fromJson(Map<String, dynamic> json){ 
        return Entry(
            resource: json["resource"] == null ? null : Resource.fromJson(json["resource"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "resource": resource?.toJson(),
    };

}

class Resource {
    Resource({
        required this.resourceType,
        required this.id,
        required this.identifier,
        required this.active,
        required this.name,
        required this.gender,
        required this.telecom,
        required this.qualification,
        required this.extension,
    });

    final String? resourceType;
    final String? id;
    final List<Identifier> identifier;
    final bool? active;
    final List<Name> name;
    final String? gender;
    final List<Telecom> telecom;
    final List<Qualification> qualification;
    final List<ResourceExtension> extension;

    Resource copyWith({
        String? resourceType,
        String? id,
        List<Identifier>? identifier,
        bool? active,
        List<Name>? name,
        String? gender,
        List<Telecom>? telecom,
        List<Qualification>? qualification,
        List<ResourceExtension>? extension,
    }) {
        return Resource(
            resourceType: resourceType ?? this.resourceType,
            id: id ?? this.id,
            identifier: identifier ?? this.identifier,
            active: active ?? this.active,
            name: name ?? this.name,
            gender: gender ?? this.gender,
            telecom: telecom ?? this.telecom,
            qualification: qualification ?? this.qualification,
            extension: extension ?? this.extension,
        );
    }

    factory Resource.fromJson(Map<String, dynamic> json){ 
        return Resource(
            resourceType: json["resourceType"],
            id: json["id"],
            identifier: json["identifier"] == null ? [] : List<Identifier>.from(json["identifier"]!.map((x) => Identifier.fromJson(x))),
            active: json["active"],
            name: json["name"] == null ? [] : List<Name>.from(json["name"]!.map((x) => Name.fromJson(x))),
            gender: json["gender"],
            telecom: json["telecom"] == null ? [] : List<Telecom>.from(json["telecom"]!.map((x) => Telecom.fromJson(x))),
            qualification: json["qualification"] == null ? [] : List<Qualification>.from(json["qualification"]!.map((x) => Qualification.fromJson(x))),
            extension: json["extension"] == null ? [] : List<ResourceExtension>.from(json["extension"]!.map((x) => ResourceExtension.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "resourceType": resourceType,
        "id": id,
        "identifier": identifier.map((x) => x?.toJson()).toList(),
        "active": active,
        "name": name.map((x) => x?.toJson()).toList(),
        "gender": gender,
        "telecom": telecom.map((x) => x?.toJson()).toList(),
        "qualification": qualification.map((x) => x?.toJson()).toList(),
        "extension": extension.map((x) => x?.toJson()).toList(),
    };

}

class ResourceExtension {
    ResourceExtension({
        required this.url,
        required this.valueInteger,
        required this.extension,
    });

    final String? url;
    final int? valueInteger;
    final List<ExtensionExtension> extension;

    ResourceExtension copyWith({
        String? url,
        int? valueInteger,
        List<ExtensionExtension>? extension,
    }) {
        return ResourceExtension(
            url: url ?? this.url,
            valueInteger: valueInteger ?? this.valueInteger,
            extension: extension ?? this.extension,
        );
    }

    factory ResourceExtension.fromJson(Map<String, dynamic> json){ 
        return ResourceExtension(
            url: json["url"],
            valueInteger: json["valueInteger"],
            extension: json["extension"] == null ? [] : List<ExtensionExtension>.from(json["extension"]!.map((x) => ExtensionExtension.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
        "valueInteger": valueInteger,
        "extension": extension.map((x) => x?.toJson()).toList(),
    };

}

class ExtensionExtension {
    ExtensionExtension({
        required this.title,
        required this.url,
        required this.contentType,
    });

    final String? title;
    final String? url;
    final String? contentType;

    ExtensionExtension copyWith({
        String? title,
        String? url,
        String? contentType,
    }) {
        return ExtensionExtension(
            title: title ?? this.title,
            url: url ?? this.url,
            contentType: contentType ?? this.contentType,
        );
    }

    factory ExtensionExtension.fromJson(Map<String, dynamic> json){ 
        return ExtensionExtension(
            title: json["title"],
            url: json["url"],
            contentType: json["contentType"],
        );
    }

    Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
        "contentType": contentType,
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
        required this.text,
    });

    final String? text;

    Name copyWith({
        String? text,
    }) {
        return Name(
            text: text ?? this.text,
        );
    }

    factory Name.fromJson(Map<String, dynamic> json){ 
        return Name(
            text: json["text"],
        );
    }

    Map<String, dynamic> toJson() => {
        "text": text,
    };

}

class Qualification {
    Qualification({
        required this.code,
        required this.issuer,
    });

    final Name? code;
    final Issuer? issuer;

    Qualification copyWith({
        Name? code,
        Issuer? issuer,
    }) {
        return Qualification(
            code: code ?? this.code,
            issuer: issuer ?? this.issuer,
        );
    }

    factory Qualification.fromJson(Map<String, dynamic> json){ 
        return Qualification(
            code: json["code"] == null ? null : Name.fromJson(json["code"]),
            issuer: json["issuer"] == null ? null : Issuer.fromJson(json["issuer"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code?.toJson(),
        "issuer": issuer?.toJson(),
    };

}

class Issuer {
    Issuer({
        required this.display,
    });

    final String? display;

    Issuer copyWith({
        String? display,
    }) {
        return Issuer(
            display: display ?? this.display,
        );
    }

    factory Issuer.fromJson(Map<String, dynamic> json){ 
        return Issuer(
            display: json["display"],
        );
    }

    Map<String, dynamic> toJson() => {
        "display": display,
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
