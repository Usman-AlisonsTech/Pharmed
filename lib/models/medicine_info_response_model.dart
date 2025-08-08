class MedicineInformationResponseModel {
    MedicineInformationResponseModel({
        required this.drug,
        required this.identifiers,
        required this.usage,
        required this.dosage,
        required this.precautions,
        required this.warnings,
    });

    final String? drug;
    final Identifiers? identifiers;
    final List<String> usage;
    final List<String> dosage;
    final List<String> precautions;
    final List<String> warnings;

    MedicineInformationResponseModel copyWith({
        String? drug,
        Identifiers? identifiers,
        List<String>? usage,
        List<String>? dosage,
        List<String>? precautions,
        List<String>? warnings,
    }) {
        return MedicineInformationResponseModel(
            drug: drug ?? this.drug,
            identifiers: identifiers ?? this.identifiers,
            usage: usage ?? this.usage,
            dosage: dosage ?? this.dosage,
            precautions: precautions ?? this.precautions,
            warnings: warnings ?? this.warnings,
        );
    }

    factory MedicineInformationResponseModel.fromJson(Map<String, dynamic> json){ 
        return MedicineInformationResponseModel(
            drug: json["drug"],
            identifiers: json["identifiers"] == null ? null : Identifiers.fromJson(json["identifiers"]),
            usage: json["usage"] == null ? [] : List<String>.from(json["usage"]!.map((x) => x)),
            dosage: json["dosage"] == null ? [] : List<String>.from(json["dosage"]!.map((x) => x)),
            precautions: json["precautions"] == null ? [] : List<String>.from(json["precautions"]!.map((x) => x)),
            warnings: json["warnings"] == null ? [] : List<String>.from(json["warnings"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "drug": drug,
        "identifiers": identifiers?.toJson(),
        "usage": usage.map((x) => x).toList(),
        "dosage": dosage.map((x) => x).toList(),
        "precautions": precautions.map((x) => x).toList(),
        "warnings": warnings.map((x) => x).toList(),
    };

}

class Identifiers {
    Identifiers({
        required this.pubchemCid,
        required this.mappedFrom,
    });

    final String? pubchemCid;
    final String? mappedFrom;

    Identifiers copyWith({
        String? pubchemCid,
        String? mappedFrom,
    }) {
        return Identifiers(
            pubchemCid: pubchemCid ?? this.pubchemCid,
            mappedFrom: mappedFrom ?? this.mappedFrom,
        );
    }

    factory Identifiers.fromJson(Map<String, dynamic> json){ 
        return Identifiers(
            pubchemCid: json["pubchem_cid"],
            mappedFrom: json["mapped_from"],
        );
    }

    Map<String, dynamic> toJson() => {
        "pubchem_cid": pubchemCid,
        "mapped_from": mappedFrom,
    };

}
