class PopularMedicationResponse {
    PopularMedicationResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    factory PopularMedicationResponse.fromJson(Map<String, dynamic> json){ 
        return PopularMedicationResponse(
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
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        required this.links,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    final int? currentPage;
    final List<Datum> data;
    final String? firstPageUrl;
    final int? from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link> links;
    final String? nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final int? to;
    final int? total;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            currentPage: json["current_page"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            firstPageUrl: json["first_page_url"],
            from: json["from"],
            lastPage: json["last_page"],
            lastPageUrl: json["last_page_url"],
            links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
            nextPageUrl: json["next_page_url"],
            path: json["path"],
            perPage: json["per_page"],
            prevPageUrl: json["prev_page_url"],
            to: json["to"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data.map((x) => x?.toJson()).toList(),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links.map((x) => x?.toJson()).toList(),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };

}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.count,
        required this.imgPath,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? count;
    final String? imgPath;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            name: json["name"],
            count: json["count"],
            imgPath: json["img_path"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
        "img_path": imgPath,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}

class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    final String? url;
    final String? label;
    final bool? active;

    factory Link.fromJson(Map<String, dynamic> json){ 
        return Link(
            url: json["url"],
            label: json["label"],
            active: json["active"],
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };

}
