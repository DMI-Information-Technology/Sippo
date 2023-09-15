class PaginationModel<T> {
  PaginationModel({
    this.data,
    this.links,
    this.meta,
  });

  factory PaginationModel.fromJson(
    dynamic json, {
    required T Function(Map<String, dynamic> item) dataConverter,
  }) {
    final jsonData = json['data'];
    return PaginationModel(
      data: jsonData != null && jsonData is List && jsonData.runtimeType == List
          ? jsonData.map((v) => dataConverter(v)).toList()
          : null,
      links: json['links'] != null ? Links.fromJson(json['links']) : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  final List<T>? data;
  final Links? links;
  final Meta? meta;

  @override
  String toString() {
    return 'PaginationModel{data: $data, links: $links, meta: $meta}';
  }
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  Meta.fromJson(dynamic json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links?.add(MetaLinks.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  int? currentPage;
  int? from;
  int? lastPage;
  List<MetaLinks>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;
}

class Links {
  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  String? url;
  String? label;
  bool? active;
}

class MetaLinks {
  MetaLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  MetaLinks.fromJson(dynamic json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  String? first;
  String? last;
  String? prev;
  String? next;

  MetaLinks copyWith({
    String? first,
    String? last,
    String? prev,
    String? next,
  }) =>
      MetaLinks(
        first: first ?? this.first,
        last: last ?? this.last,
        prev: prev ?? this.prev,
        next: next ?? this.next,
      );

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'prev': prev,
        'next': next,
      };
}
