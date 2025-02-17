class GetThreadEmptyResponse {
    GetThreadEmptyResponse({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final Data? data;
    final String? message;

    GetThreadEmptyResponse copyWith({
        bool? success,
        Data? data,
        String? message,
    }) {
        return GetThreadEmptyResponse(
            success: success ?? this.success,
            data: data ?? this.data,
            message: message ?? this.message,
        );
    }

    factory GetThreadEmptyResponse.fromJson(Map<String, dynamic> json){ 
        return GetThreadEmptyResponse(
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
    final List<dynamic> data;
    final String? firstPageUrl;
    final dynamic from;
    final int? lastPage;
    final String? lastPageUrl;
    final List<Link> links;
    final dynamic nextPageUrl;
    final String? path;
    final int? perPage;
    final dynamic prevPageUrl;
    final dynamic to;
    final int? total;

    Data copyWith({
        int? currentPage,
        List<dynamic>? data,
        String? firstPageUrl,
        dynamic? from,
        int? lastPage,
        String? lastPageUrl,
        List<Link>? links,
        dynamic? nextPageUrl,
        String? path,
        int? perPage,
        dynamic? prevPageUrl,
        dynamic? to,
        int? total,
    }) {
        return Data(
            currentPage: currentPage ?? this.currentPage,
            data: data ?? this.data,
            firstPageUrl: firstPageUrl ?? this.firstPageUrl,
            from: from ?? this.from,
            lastPage: lastPage ?? this.lastPage,
            lastPageUrl: lastPageUrl ?? this.lastPageUrl,
            links: links ?? this.links,
            nextPageUrl: nextPageUrl ?? this.nextPageUrl,
            path: path ?? this.path,
            perPage: perPage ?? this.perPage,
            prevPageUrl: prevPageUrl ?? this.prevPageUrl,
            to: to ?? this.to,
            total: total ?? this.total,
        );
    }

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            currentPage: json["current_page"],
            data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
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
        "data": data.map((x) => x).toList(),
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

class Link {
    Link({
        required this.url,
        required this.label,
        required this.active,
    });

    final String? url;
    final String? label;
    final bool? active;

    Link copyWith({
        String? url,
        String? label,
        bool? active,
    }) {
        return Link(
            url: url ?? this.url,
            label: label ?? this.label,
            active: active ?? this.active,
        );
    }

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
