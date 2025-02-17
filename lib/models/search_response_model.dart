class SearchResponse {
    SearchResponse({
        required this.medications,
        required this.total,
        required this.query,
    });

    final List<Medication> medications;
    final int? total;
    final String? query;

    factory SearchResponse.fromJson(Map<String, dynamic> json){ 
        return SearchResponse(
            medications: json["medications"] == null ? [] : List<Medication>.from(json["medications"]!.map((x) => Medication.fromJson(x))),
            total: json["total"],
            query: json["query"],
        );
    }

    Map<String, dynamic> toJson() => {
        "medications": medications.map((x) => x?.toJson()).toList(),
        "total": total,
        "query": query,
    };

}

class Medication {
    Medication({
        required this.basicInfo,
        required this.administration,
        required this.clinicalInfo,
        required this.ingredients,
        required this.storage,
        required this.additionalInfo,
    });

    final BasicInfo? basicInfo;
    final Administration? administration;
    final ClinicalInfo? clinicalInfo;
    final Ingredients? ingredients;
    final Storage? storage;
    final AdditionalInfo? additionalInfo;

    factory Medication.fromJson(Map<String, dynamic> json){ 
        return Medication(
            basicInfo: json["basic_info"] == null ? null : BasicInfo.fromJson(json["basic_info"]),
            administration: json["administration"] == null ? null : Administration.fromJson(json["administration"]),
            clinicalInfo: json["clinical_info"] == null ? null : ClinicalInfo.fromJson(json["clinical_info"]),
            ingredients: json["ingredients"] == null ? null : Ingredients.fromJson(json["ingredients"]),
            storage: json["storage"] == null ? null : Storage.fromJson(json["storage"]),
            additionalInfo: json["additional_info"] == null ? null : AdditionalInfo.fromJson(json["additional_info"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "basic_info": basicInfo?.toJson(),
        "administration": administration?.toJson(),
        "clinical_info": clinicalInfo?.toJson(),
        "ingredients": ingredients?.toJson(),
        "storage": storage?.toJson(),
        "additional_info": additionalInfo?.toJson(),
    };

}

class AdditionalInfo {
    AdditionalInfo({
        required this.pregnancy,
        required this.nursingMothers,
        required this.pediatricUse,
        required this.geriatricUse,
        required this.boxedWarning,
    });

    final List<String> pregnancy;
    final List<String> nursingMothers;
    final List<String> pediatricUse;
    final List<String> geriatricUse;
    final List<String> boxedWarning;

    factory AdditionalInfo.fromJson(Map<String, dynamic> json){ 
        return AdditionalInfo(
            pregnancy: json["pregnancy"] == null ? [] : List<String>.from(json["pregnancy"]!.map((x) => x)),
            nursingMothers: json["nursing_mothers"] == null ? [] : List<String>.from(json["nursing_mothers"]!.map((x) => x)),
            pediatricUse: json["pediatric_use"] == null ? [] : List<String>.from(json["pediatric_use"]!.map((x) => x)),
            geriatricUse: json["geriatric_use"] == null ? [] : List<String>.from(json["geriatric_use"]!.map((x) => x)),
            boxedWarning: json["boxed_warning"] == null ? [] : List<String>.from(json["boxed_warning"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "pregnancy": pregnancy.map((x) => x).toList(),
        "nursing_mothers": nursingMothers.map((x) => x).toList(),
        "pediatric_use": pediatricUse.map((x) => x).toList(),
        "geriatric_use": geriatricUse.map((x) => x).toList(),
        "boxed_warning": boxedWarning.map((x) => x).toList(),
    };

}

class Administration {
    Administration({
        required this.dosageForms,
        required this.dosageAdministration,
        required this.administrationRoute,
    });

    final List<String> dosageForms;
    final List<String> dosageAdministration;
    final List<dynamic> administrationRoute;

    factory Administration.fromJson(Map<String, dynamic> json){ 
        return Administration(
            dosageForms: json["dosage_forms"] == null ? [] : List<String>.from(json["dosage_forms"]!.map((x) => x)),
            dosageAdministration: json["dosage_administration"] == null ? [] : List<String>.from(json["dosage_administration"]!.map((x) => x)),
            administrationRoute: json["administration_route"] == null ? [] : List<dynamic>.from(json["administration_route"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "dosage_forms": dosageForms.map((x) => x).toList(),
        "dosage_administration": dosageAdministration.map((x) => x).toList(),
        "administration_route": administrationRoute.map((x) => x).toList(),
    };

}

class BasicInfo {
    BasicInfo({
        required this.id,
        required this.genericName,
        required this.brandName,
        required this.manufacturer,
        required this.productType,
        required this.route,
    });

    final String? id;
    final String? genericName;
    final String? brandName;
    final String? manufacturer;
    final String? productType;
    final String? route;

    factory BasicInfo.fromJson(Map<String, dynamic> json){ 
        return BasicInfo(
            id: json["id"],
            genericName: json["generic_name"],
            brandName: json["brand_name"],
            manufacturer: json["manufacturer"],
            productType: json["product_type"],
            route: json["route"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "generic_name": genericName,
        "brand_name": brandName,
        "manufacturer": manufacturer,
        "product_type": productType,
        "route": route,
    };

}

class ClinicalInfo {
    ClinicalInfo({
        required this.indicationsUsage,
        required this.contraindications,
        required this.warnings,
        required this.warningsPrecautions,
        required this.adverseReactions,
        required this.drugInteractions,
        required this.mechanismOfAction,
    });

    final List<String> indicationsUsage;
    final List<String> contraindications;
    final List<dynamic> warnings;
    final List<dynamic> warningsPrecautions;
    final List<String> adverseReactions;
    final List<String> drugInteractions;
    final List<String> mechanismOfAction;

    factory ClinicalInfo.fromJson(Map<String, dynamic> json){ 
        return ClinicalInfo(
            indicationsUsage: json["indications_usage"] == null ? [] : List<String>.from(json["indications_usage"]!.map((x) => x)),
            contraindications: json["contraindications"] == null ? [] : List<String>.from(json["contraindications"]!.map((x) => x)),
            warnings: json["warnings"] == null ? [] : List<dynamic>.from(json["warnings"]!.map((x) => x)),
            warningsPrecautions: json["warnings_precautions"] == null ? [] : List<dynamic>.from(json["warnings_precautions"]!.map((x) => x)),
            adverseReactions: json["adverse_reactions"] == null ? [] : List<String>.from(json["adverse_reactions"]!.map((x) => x)),
            drugInteractions: json["drug_interactions"] == null ? [] : List<String>.from(json["drug_interactions"]!.map((x) => x)),
            mechanismOfAction: json["mechanism_of_action"] == null ? [] : List<String>.from(json["mechanism_of_action"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "indications_usage": indicationsUsage.map((x) => x).toList(),
        "contraindications": contraindications.map((x) => x).toList(),
        "warnings": warnings.map((x) => x).toList(),
        "warnings_precautions": warningsPrecautions.map((x) => x).toList(),
        "adverse_reactions": adverseReactions.map((x) => x).toList(),
        "drug_interactions": drugInteractions.map((x) => x).toList(),
        "mechanism_of_action": mechanismOfAction.map((x) => x).toList(),
    };

}

class Ingredients {
    Ingredients({
        required this.activeIngredients,
        required this.inactiveIngredients,
    });

    final List<dynamic> activeIngredients;
    final List<dynamic> inactiveIngredients;

    factory Ingredients.fromJson(Map<String, dynamic> json){ 
        return Ingredients(
            activeIngredients: json["active_ingredients"] == null ? [] : List<dynamic>.from(json["active_ingredients"]!.map((x) => x)),
            inactiveIngredients: json["inactive_ingredients"] == null ? [] : List<dynamic>.from(json["inactive_ingredients"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "active_ingredients": activeIngredients.map((x) => x).toList(),
        "inactive_ingredients": inactiveIngredients.map((x) => x).toList(),
    };

}

class Storage {
    Storage({
        required this.storageHandling,
        required this.howSupplied,
    });

    final List<String> storageHandling;
    final List<String> howSupplied;

    factory Storage.fromJson(Map<String, dynamic> json){ 
        return Storage(
            storageHandling: json["storage_handling"] == null ? [] : List<String>.from(json["storage_handling"]!.map((x) => x)),
            howSupplied: json["how_supplied"] == null ? [] : List<String>.from(json["how_supplied"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "storage_handling": storageHandling.map((x) => x).toList(),
        "how_supplied": howSupplied.map((x) => x).toList(),
    };

}
