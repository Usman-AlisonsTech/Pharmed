class DrugInteractionResponse {
    DrugInteractionResponse({
        required this.interactions,
        required this.totalInteractions,
    });

    final List<Interaction> interactions;
    final int? totalInteractions;

    factory DrugInteractionResponse.fromJson(Map<String, dynamic> json){ 
        return DrugInteractionResponse(
            interactions: json["interactions"] == null ? [] : List<Interaction>.from(json["interactions"]!.map((x) => Interaction.fromJson(x))),
            totalInteractions: json["total_interactions"],
        );
    }

    Map<String, dynamic> toJson() => {
        "interactions": interactions.map((x) => x?.toJson()).toList(),
        "total_interactions": totalInteractions,
    };

}

class Interaction {
    Interaction({
        required this.drugs,
        required this.interactionDetails,
    });

    final List<String> drugs;
    final List<String> interactionDetails;

    factory Interaction.fromJson(Map<String, dynamic> json){ 
        return Interaction(
            drugs: json["drugs"] == null ? [] : List<String>.from(json["drugs"]!.map((x) => x)),
            interactionDetails: json["interaction_details"] == null ? [] : List<String>.from(json["interaction_details"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "drugs": drugs.map((x) => x).toList(),
        "interaction_details": interactionDetails.map((x) => x).toList(),
    };

}
