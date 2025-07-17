class GetMedicationResponse {
    GetMedicationResponse({
        required this.data,
    });

    final List<Datum> data;

    GetMedicationResponse copyWith({
        List<Datum>? data,
    }) {
        return GetMedicationResponse(
            data: data ?? this.data,
        );
    }

    factory GetMedicationResponse.fromJson(Map<String, dynamic> json){ 
        return GetMedicationResponse(
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
    };

}

class Datum {
    Datum({
        required this.resourceType,
        required this.id,
        required this.status,
        required this.taken,
        required this.medicationCodeableConcept,
        required this.subject,
        required this.effectivePeriod,
        required this.dateAsserted,
        required this.informationSource,
        required this.reasonCode,
        required this.dosage,
        required this.note,
        required this.extension,
    });

    final String? resourceType;
    final String? id;
    final String? status;
    final String? taken;
    final MedicationCodeableConcept? medicationCodeableConcept;
    final InformationSource? subject;
    final Period? effectivePeriod;
    final DateTime? dateAsserted;
    final InformationSource? informationSource;
    final List<Note> reasonCode;
    final List<Dosage> dosage;
    final List<Note> note;
    final List<Extension> extension;

    Datum copyWith({
        String? resourceType,
        String? id,
        String? status,
        String? taken,
        MedicationCodeableConcept? medicationCodeableConcept,
        InformationSource? subject,
        Period? effectivePeriod,
        DateTime? dateAsserted,
        InformationSource? informationSource,
        List<Note>? reasonCode,
        List<Dosage>? dosage,
        List<Note>? note,
        List<Extension>? extension,
    }) {
        return Datum(
            resourceType: resourceType ?? this.resourceType,
            id: id ?? this.id,
            status: status ?? this.status,
            taken: taken ?? this.taken,
            medicationCodeableConcept: medicationCodeableConcept ?? this.medicationCodeableConcept,
            subject: subject ?? this.subject,
            effectivePeriod: effectivePeriod ?? this.effectivePeriod,
            dateAsserted: dateAsserted ?? this.dateAsserted,
            informationSource: informationSource ?? this.informationSource,
            reasonCode: reasonCode ?? this.reasonCode,
            dosage: dosage ?? this.dosage,
            note: note ?? this.note,
            extension: extension ?? this.extension,
        );
    }

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            resourceType: json["resourceType"],
            id: json["id"],
            status: json["status"],
            taken: json["taken"],
            medicationCodeableConcept: json["medicationCodeableConcept"] == null ? null : MedicationCodeableConcept.fromJson(json["medicationCodeableConcept"]),
            subject: json["subject"] == null ? null : InformationSource.fromJson(json["subject"]),
            effectivePeriod: json["effectivePeriod"] == null ? null : Period.fromJson(json["effectivePeriod"]),
            dateAsserted: DateTime.tryParse(json["dateAsserted"] ?? ""),
            informationSource: json["informationSource"] == null ? null : InformationSource.fromJson(json["informationSource"]),
            reasonCode: json["reasonCode"] == null ? [] : List<Note>.from(json["reasonCode"]!.map((x) => Note.fromJson(x))),
            dosage: json["dosage"] == null ? [] : List<Dosage>.from(json["dosage"]!.map((x) => Dosage.fromJson(x))),
            note: json["note"] == null ? [] : List<Note>.from(json["note"]!.map((x) => Note.fromJson(x))),
            extension: json["extension"] == null ? [] : List<Extension>.from(json["extension"]!.map((x) => Extension.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "resourceType": resourceType,
        "id": id,
        "status": status,
        "taken": taken,
        "medicationCodeableConcept": medicationCodeableConcept?.toJson(),
        "subject": subject?.toJson(),
        "effectivePeriod": effectivePeriod?.toJson(),
        "dateAsserted": dateAsserted!= null? "${dateAsserted!.year.toString().padLeft(4,'0')}-${dateAsserted!.month.toString().padLeft(2,'0')}-${dateAsserted!.day.toString().padLeft(2,'0')}":null,
        "informationSource": informationSource?.toJson(),
        "reasonCode": reasonCode.map((x) => x?.toJson()).toList(),
        "dosage": dosage.map((x) => x?.toJson()).toList(),
        "note": note.map((x) => x?.toJson()).toList(),
        "extension": extension.map((x) => x?.toJson()).toList(),
    };

}

class Dosage {
    Dosage({
        required this.text,
        required this.timing,
    });

    final String? text;
    final Timing? timing;

    Dosage copyWith({
        String? text,
        Timing? timing,
    }) {
        return Dosage(
            text: text ?? this.text,
            timing: timing ?? this.timing,
        );
    }

    factory Dosage.fromJson(Map<String, dynamic> json){ 
        return Dosage(
            text: json["text"],
            timing: json["timing"] == null ? null : Timing.fromJson(json["timing"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "text": text,
        "timing": timing?.toJson(),
    };

}

class Timing {
    Timing({
        required this.event,
        required this.repeat,
    });

    final List<DateTime> event;
    final Repeat? repeat;

    Timing copyWith({
        List<DateTime>? event,
        Repeat? repeat,
    }) {
        return Timing(
            event: event ?? this.event,
            repeat: repeat ?? this.repeat,
        );
    }

    factory Timing.fromJson(Map<String, dynamic> json){ 
        return Timing(
            event: json["event"] == null ? [] : List<DateTime>.from(json["event"]!.map((x) => DateTime.tryParse(x ?? ""))),
            repeat: json["repeat"] == null ? null : Repeat.fromJson(json["repeat"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "event": event.map((x) => x?.toIso8601String()).toList(),
        "repeat": repeat?.toJson(),
    };

}

class Repeat {
    Repeat({
        required this.frequency,
        required this.period,
        required this.periodUnit,
        required this.boundsPeriod,
    });

    final int? frequency;
    final int? period;
    final String? periodUnit;
    final Period? boundsPeriod;

    Repeat copyWith({
        int? frequency,
        int? period,
        String? periodUnit,
        Period? boundsPeriod,
    }) {
        return Repeat(
            frequency: frequency ?? this.frequency,
            period: period ?? this.period,
            periodUnit: periodUnit ?? this.periodUnit,
            boundsPeriod: boundsPeriod ?? this.boundsPeriod,
        );
    }

    factory Repeat.fromJson(Map<String, dynamic> json){ 
        return Repeat(
            frequency: json["frequency"],
            period: json["period"],
            periodUnit: json["periodUnit"],
            boundsPeriod: json["boundsPeriod"] == null ? null : Period.fromJson(json["boundsPeriod"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "frequency": frequency,
        "period": period,
        "periodUnit": periodUnit,
        "boundsPeriod": boundsPeriod?.toJson(),
    };

}

class Period {
    Period({
        required this.start,
        required this.end,
    });

    final DateTime? start;
    final DateTime? end;

    Period copyWith({
        DateTime? start,
        DateTime? end,
    }) {
        return Period(
            start: start ?? this.start,
            end: end ?? this.end,
        );
    }

    factory Period.fromJson(Map<String, dynamic> json){ 
        return Period(
            start: DateTime.tryParse(json["start"] ?? ""),
            end: DateTime.tryParse(json["end"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "start": start!= null? "${start!.year.toString().padLeft(4,'0')}-${start!.month.toString().padLeft(2,'0')}-${start!.day.toString().padLeft(2,'0')}":null,
        "end": end != null?"${end!.year.toString().padLeft(4,'0')}-${end!.month.toString().padLeft(2,'0')}-${end!.day.toString().padLeft(2,'0')}":null,
    };

}

class Extension {
    Extension({
        required this.url,
        required this.valueUrl,
        required this.valueString,
    });

    final String? url;
    final String? valueUrl;
    final String? valueString;

    Extension copyWith({
        String? url,
        String? valueUrl,
        String? valueString,
    }) {
        return Extension(
            url: url ?? this.url,
            valueUrl: valueUrl ?? this.valueUrl,
            valueString: valueString ?? this.valueString,
        );
    }

    factory Extension.fromJson(Map<String, dynamic> json){ 
        return Extension(
            url: json["url"],
            valueUrl: json["valueUrl"],
            valueString: json["valueString"],
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
        "valueUrl": valueUrl,
        "valueString": valueString,
    };

}

class InformationSource {
    InformationSource({
        required this.reference,
    });

    final String? reference;

    InformationSource copyWith({
        String? reference,
    }) {
        return InformationSource(
            reference: reference ?? this.reference,
        );
    }

    factory InformationSource.fromJson(Map<String, dynamic> json){ 
        return InformationSource(
            reference: json["reference"],
        );
    }

    Map<String, dynamic> toJson() => {
        "reference": reference,
    };

}

class MedicationCodeableConcept {
    MedicationCodeableConcept({
        required this.coding,
        required this.text,
    });

    final List<Coding> coding;
    final String? text;

    MedicationCodeableConcept copyWith({
        List<Coding>? coding,
        String? text,
    }) {
        return MedicationCodeableConcept(
            coding: coding ?? this.coding,
            text: text ?? this.text,
        );
    }

    factory MedicationCodeableConcept.fromJson(Map<String, dynamic> json){ 
        return MedicationCodeableConcept(
            coding: json["coding"] == null ? [] : List<Coding>.from(json["coding"]!.map((x) => Coding.fromJson(x))),
            text: json["text"],
        );
    }

    Map<String, dynamic> toJson() => {
        "coding": coding.map((x) => x?.toJson()).toList(),
        "text": text,
    };

}

class Coding {
    Coding({
        required this.system,
        required this.code,
        required this.display,
    });

    final String? system;
    final String? code;
    final String? display;

    Coding copyWith({
        String? system,
        String? code,
        String? display,
    }) {
        return Coding(
            system: system ?? this.system,
            code: code ?? this.code,
            display: display ?? this.display,
        );
    }

    factory Coding.fromJson(Map<String, dynamic> json){ 
        return Coding(
            system: json["system"],
            code: json["code"],
            display: json["display"],
        );
    }

    Map<String, dynamic> toJson() => {
        "system": system,
        "code": code,
        "display": display,
    };

}

class Note {
    Note({
        required this.text,
    });

    final String? text;

    Note copyWith({
        String? text,
    }) {
        return Note(
            text: text ?? this.text,
        );
    }

    factory Note.fromJson(Map<String, dynamic> json){ 
        return Note(
            text: json["text"],
        );
    }

    Map<String, dynamic> toJson() => {
        "text": text,
    };

}
