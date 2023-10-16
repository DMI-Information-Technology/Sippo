import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';

import 'notifications_types.dart';

interface class NotificationsTypesConverter {
  NewPostNotificationModel asNotificationPost() => throw UnimplementedError();

  NewJobNotificationModel asNotificationJob() => throw UnimplementedError();

  NotificationApplicationStatusModel asNotificationApplication() =>
      throw UnimplementedError();
}

abstract class BaseNotificationModel implements NotificationsTypesConverter {
  const BaseNotificationModel({
    this.id,
    this.type,
    this.body,
    this.title,
    this.isRead,
    this.date,
  });

  NotificationTypes? get notificationType {
    return NotificationTypes.typeOf(this.type);
  }

  final String? id;
  final String? type;
  final String? body;
  final String? title;
  final bool? isRead;
  final String? date;

  @override
  NewJobNotificationModel asNotificationJob() {
    return this as NewJobNotificationModel;
  }

  @override
  NewPostNotificationModel asNotificationPost() {
    return this as NewPostNotificationModel;
  }

  @override
  NotificationApplicationStatusModel asNotificationApplication() {
    return this as NotificationApplicationStatusModel;
  }
  static BaseNotificationModel? fromNotificationsJson(
      Map<String, dynamic> json,
      ) {
    final type = NotificationTypes.typeOf(json['type']);
    print("type type: $type");
    return switch (type) {
      NotificationTypes.newPost => NewPostNotificationModel.fromJson(json),
      NotificationTypes.newJob => NewJobNotificationModel.fromJson(json),
      NotificationTypes.applicationStatus =>
          NotificationApplicationStatusModel.fromJson(json),
      NotificationTypes.newApplicationReceived => null,
      NotificationTypes.newFollower => null,
      NotificationTypes.subscriptionWillEnd => null,
      NotificationTypes.subscriptionEnded => null,
      _ => null,
    };
  }
}

class NewPostNotificationModel extends BaseNotificationModel {
  final NotificationDataModel<CompanyDetailsPostModel>? data;

  const NewPostNotificationModel({
    super.id,
    super.type,
    super.title,
    super.body,
    super.isRead,
    super.date,
    this.data,
  });

  factory NewPostNotificationModel.fromJson(Map<String, dynamic> json) {
    return NewPostNotificationModel(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      body: json["body"],
      isRead: json["is_read"],
      date: json["date"],
      data: NotificationDataModel.fromJson(
        json["data"],
        (dataJson) {
          print("post notification :${dataJson['post']}");
          return CompanyDetailsPostModel.fromJson(dataJson['post']);
        },
      ),
    );
  }

  NewPostNotificationModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
    NotificationDataModel<CompanyDetailsPostModel>? data,
  }) {
    return NewPostNotificationModel(
      id: id ?? super.id,
      type: type ?? super.type,
      body: body ?? super.body,
      title: title ?? super.title,
      isRead: isRead ?? super.isRead,
      date: date ?? super.date,
      data: data ?? this.data,
    );
  }

  NewPostNotificationModel copyWithSetIsRead(bool isRead) {
    return this.copyWith(isRead: isRead);
  }

  @override
  String toString() {
    return 'NewPostNotificationModel{id: $id, type: $type, body: $body, title: $title, isRead: $isRead, date: $date, data: $data}';
  }
}

class NewJobNotificationModel extends BaseNotificationModel {
  final NotificationDataModel<CompanyJobModel>? data;

  const NewJobNotificationModel({
    super.id,
    super.type,
    super.title,
    super.body,
    super.isRead,
    super.date,
    this.data,
  });

  factory NewJobNotificationModel.fromJson(Map<String, dynamic> json) {
    return NewJobNotificationModel(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      body: json["body"],
      isRead: json["is_read"],
      date: json["date"],
      data: NotificationDataModel.fromJson(
        json["data"],
        (dataJson) => CompanyJobModel.fromJson(dataJson['job']),
      ),
    );
  }

  NewJobNotificationModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
    NotificationDataModel<CompanyJobModel>? data,
  }) {
    return NewJobNotificationModel(
      id: id ?? super.id,
      type: type ?? super.type,
      body: body ?? super.body,
      title: title ?? super.title,
      isRead: isRead ?? super.isRead,
      date: date ?? super.date,
      data: data ?? this.data,
    );
  }

  NewJobNotificationModel copyWithSetIsRead(bool isRead) {
    return this.copyWith(isRead: isRead);
  }

  @override
  String toString() {
    return 'NewJobNotificationModel{id: $id, type: $type, body: $body, title: $title, isRead: $isRead, date: $date, data: $data}';
  }
}

class NotificationDataModel<T> {
  final T? item;
  final CompanyDetailsModel? company;

  const NotificationDataModel({this.item, this.company});

  factory NotificationDataModel.fromJson(
    Map<String, dynamic> json,
    T? Function(Map<String, dynamic> dataJson) fromItemJson,
  ) {
    return NotificationDataModel(
      item: fromItemJson(json),
      company: CompanyDetailsModel.fromJson(json["company"]),
    );
  }

  @override
  String toString() {
    return 'NotificationDataModel{item: $item, company: $company}';
  }
}

class NotificationApplicationStatusModel extends BaseNotificationModel {
  final NotificationApplicationDataModel? data;

  const NotificationApplicationStatusModel({
    super.id,
    super.type,
    super.title,
    super.body,
    super.isRead,
    super.date,
    this.data,
  });

  factory NotificationApplicationStatusModel.fromJson(
      Map<String, dynamic> json) {
    return NotificationApplicationStatusModel(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      body: json["body"],
      isRead: json["is_read"],
      date: json["date"],
      data: NotificationApplicationDataModel.fromJson(json["data"]),
    );
  }

  NotificationApplicationStatusModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
    NotificationApplicationDataModel? data,
  }) {
    return NotificationApplicationStatusModel(
      id: id ?? super.id,
      type: type ?? super.type,
      body: body ?? super.body,
      title: title ?? super.title,
      isRead: isRead ?? super.isRead,
      date: date ?? super.date,
      data: data ?? this.data,
    );
  }

  NotificationApplicationStatusModel copyWithSetIsRead(bool isRead) {
    return this.copyWith(isRead: isRead);
  }

  @override
  String toString() {
    return 'NotificationApplicationStatusModel{id: $id, type: $type, body: $body, title: $title, isRead: $isRead, date: $date, data: $data}';
  }
}

class NotificationApplicationDataModel {
  final int? companyId;
  final int? jobId;

  const NotificationApplicationDataModel({this.companyId, this.jobId});

  factory NotificationApplicationDataModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return NotificationApplicationDataModel(
      companyId: json["company_id"],
      jobId: json["job_id"],
    );
  }

  @override
  String toString() {
    return 'NotificationApplicationDataModel{companyId: $companyId, jobId: $jobId}';
  }
}
