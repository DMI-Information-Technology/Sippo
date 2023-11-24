import 'package:jobspot/sippo_data/model/auth_model/company_response_details.dart';
import 'package:jobspot/sippo_data/model/image_resource_model/image_resource_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_job_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/company_profile_resource_model/company_post_model.dart';
import 'package:jobspot/sippo_data/model/profile_model/profile_resource_model/profile_edit_model.dart';

import 'notifications_types.dart';

interface class NotificationsTypesConverter {
  NewPostNotificationModel asNotificationPost() => throw UnimplementedError();

  NewJobNotificationModel asNotificationJob() => throw UnimplementedError();

  NotificationApplicationStatusModel asNotificationApplication() =>
      throw UnimplementedError();

  NotificationFollowerModel asNotificationFollower() =>
      throw UnimplementedError();

  NotificationApplicationReceivedModel asNotificationApplicationReceived() =>
      throw UnimplementedError();

  NotificationApplicationSubscriptionModel
      asNotificationApplicationSubscription() => throw UnimplementedError();
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

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "type": this.type,
      "body": this.body,
      "title": this.title,
      "isRead": this.isRead,
      "date": this.date,
    };
  }

  NotificationTypes? get notificationType {
    return NotificationTypes.typeOf(this.type);
  }

  final String? id;
  final String? type;
  final String? body;
  final String? title;
  final bool? isRead;
  final String? date;

  ImageResourceModel? get image {
    return switch (notificationType) {
      NotificationTypes.newPost =>
        asNotificationPost().data?.company?.profileImage,
      NotificationTypes.newJob =>
        asNotificationJob().data?.company?.profileImage,
      NotificationTypes.applicationStatus =>
        asNotificationApplication().data?.company?.profileImage,
      NotificationTypes.newApplicationReceived =>
        asNotificationApplicationReceived().data?.customer?.profileImage,
      NotificationTypes.newFollower =>
        asNotificationFollower().data?.customer?.profileImage,
      NotificationTypes.subscriptionWillEnd => null,
      NotificationTypes.subscriptionEnded => null,
      _ => null,
    };
  }

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

  @override
  NotificationFollowerModel asNotificationFollower() {
    return this as NotificationFollowerModel;
  }

  @override
  NotificationApplicationReceivedModel asNotificationApplicationReceived() {
    return this as NotificationApplicationReceivedModel;
  }

  @override
  NotificationApplicationSubscriptionModel
      asNotificationApplicationSubscription() {
    return this as NotificationApplicationSubscriptionModel;
  }

  static BaseNotificationModel? fromNotificationsJson(
    Map<String, dynamic>? json,
  ) {
    final type = NotificationTypes.typeOf(json?['type']);
    print(
        "from asNotificationApplicationReceived for type notification: $type");
    return switch (type) {
      NotificationTypes.newPost => NewPostNotificationModel.fromJson(json),
      NotificationTypes.newJob => NewJobNotificationModel.fromJson(json),
      NotificationTypes.applicationStatus =>
        NotificationApplicationStatusModel.fromJson(json),
      NotificationTypes.newApplicationReceived =>
        NotificationApplicationReceivedModel.fromJson(json),
      NotificationTypes.newFollower => NotificationFollowerModel.fromJson(json),
      NotificationTypes.subscriptionWillEnd =>
        NotificationApplicationSubscriptionModel.fromJson(json),
      NotificationTypes.subscriptionEnded =>
        NotificationApplicationSubscriptionModel.fromJson(
          json,
        ),
      _ => null,
    };
  }

  BaseNotificationModel? copyWithSetIsRead(bool isRead) {
    return switch (notificationType) {
      NotificationTypes.newPost =>
        asNotificationPost().copyWithSetIsRead(isRead),
      NotificationTypes.newJob => asNotificationJob().copyWithSetIsRead(isRead),
      NotificationTypes.applicationStatus =>
        asNotificationApplication().copyWithSetIsRead(isRead),
      NotificationTypes.newApplicationReceived =>
        asNotificationApplicationReceived().copyWithSetIsRead(isRead),
      NotificationTypes.newFollower =>
        asNotificationFollower().copyWithSetIsRead(isRead),
      NotificationTypes.subscriptionWillEnd =>
        asNotificationApplicationSubscription().copyWithSetIsRead(isRead),
      NotificationTypes.subscriptionEnded =>
        asNotificationApplicationSubscription().copyWithSetIsRead(isRead),
      _ => null,
    };
  }

//
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

  factory NewPostNotificationModel.fromJson(Map<String, dynamic>? json) {
    return NewPostNotificationModel(
      id: json?["id"],
      type: json?["type"],
      title: json?["title"],
      body: json?["body"],
      isRead: json?["is_read"],
      date: json?["date"],
      data: json?["data"] != null
          ? NotificationDataModel.fromJson(
              json?["data"],
              (dataJson) => dataJson?['post'] != null
                  ? CompanyDetailsPostModel.fromJson(dataJson?['post'])
                  : null,
            )
          : null,
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

  factory NewJobNotificationModel.fromJson(Map<String, dynamic>? json) {
    return NewJobNotificationModel(
      id: json?["id"],
      type: json?["type"],
      title: json?["title"],
      body: json?["body"],
      isRead: json?["is_read"],
      date: json?["date"],
      data: json?["data"] != null
          ? NotificationDataModel.fromJson(
              json?["data"],
              (dataJson) => dataJson?['job'] != null
                  ? CompanyJobModel.fromJson(dataJson?['job'])
                  : null,
            )
          : null,
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

class NotificationApplicationStatusModel extends BaseNotificationModel {
  NotificationApplicationStatusModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
    NotificationDataModel<CompanyJobModel>? data,
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

  final NotificationDataModel<CompanyJobModel>? data;

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
      Map<String, dynamic>? json) {
    return NotificationApplicationStatusModel(
      id: json?["id"],
      type: json?["type"],
      title: json?["title"],
      body: json?["body"],
      isRead: json?["is_read"],
      date: json?["date"],
      data: json?["date"] != null
          ? NotificationDataModel.fromJson(
              json?["data"],
              (dataJson) => dataJson?["job"] != null
                  ? CompanyJobModel.fromJson(dataJson?["job"])
                  : null,
            )
          : null,
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

class NotificationDataModel<T> {
  final T? item;
  final CompanyDetailsModel? company;

  const NotificationDataModel({this.item, this.company});

  factory NotificationDataModel.fromJson(
    Map<String, dynamic>? json,
    T? Function(Map<String, dynamic>? dataJson) fromItemJson,
  ) {
    return NotificationDataModel(
      item: fromItemJson(json),
      company: json?["company"] != null
          ? CompanyDetailsModel.fromJson(json?["company"])
          : null,
    );
  }

  @override
  String toString() {
    return 'NotificationDataModel{item: $item, company: $company}';
  }
}

class NotificationFollowerModel extends BaseNotificationModel {
  final NotificationFollowerDataModel? data;

  const NotificationFollowerModel({
    super.id,
    super.type,
    super.title,
    super.body,
    super.isRead,
    super.date,
    this.data,
  });

  factory NotificationFollowerModel.fromJson(Map<String, dynamic>? json) {
    return NotificationFollowerModel(
      id: json?["id"],
      type: json?["type"],
      title: json?["title"],
      body: json?["body"],
      isRead: json?["is_read"],
      date: json?["date"],
      data: json?["data"] != null
          ? NotificationFollowerDataModel.fromJson(json?["data"])
          : null,
    );
  }

  NotificationFollowerModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
    NotificationFollowerDataModel? data,
  }) {
    return NotificationFollowerModel(
      id: id ?? super.id,
      type: type ?? super.type,
      body: body ?? super.body,
      title: title ?? super.title,
      isRead: isRead ?? super.isRead,
      date: date ?? super.date,
      data: data ?? this.data,
    );
  }

  NotificationFollowerModel copyWithSetIsRead(bool isRead) {
    return this.copyWith(isRead: isRead);
  }

  @override
  String toString() {
    return 'NotificationFollowerModel{id: $id, type: $type, body: $body, title: $title, isRead: $isRead, date: $date, data: $data}';
  }
}

class NotificationFollowerDataModel {
  final ProfileInfoModel? customer;

  const NotificationFollowerDataModel({this.customer});

  factory NotificationFollowerDataModel.fromJson(
    Map<String, dynamic>? json,
  ) {
    print("is null? : ${json?["customer"]}");
    return NotificationFollowerDataModel(
      customer: json?["customer"] != null
          ? ProfileInfoModel.fromJson(json?["customer"])
          : null,
    );
  }

  @override
  String toString() {
    return 'NotificationFollowerDataModel{customerId: $customer}';
  }
}

class NotificationApplicationReceivedModel extends BaseNotificationModel {
  final NotificationApplicationReceivedDataModel? data;

  const NotificationApplicationReceivedModel({
    super.id,
    super.type,
    super.title,
    super.body,
    super.isRead,
    super.date,
    this.data,
  });

  factory NotificationApplicationReceivedModel.fromJson(
      Map<String, dynamic>? json) {
    return NotificationApplicationReceivedModel(
      id: json?["id"],
      type: json?["type"],
      title: json?["title"],
      body: json?["body"],
      isRead: json?["is_read"],
      date: json?["date"],
      data: json?["data"] != null
          ? NotificationApplicationReceivedDataModel.fromJson(json?["data"])
          : null,
    );
  }

  NotificationApplicationReceivedModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
    NotificationApplicationReceivedDataModel? data,
  }) {
    return NotificationApplicationReceivedModel(
      id: id ?? super.id,
      type: type ?? super.type,
      body: body ?? super.body,
      title: title ?? super.title,
      isRead: isRead ?? super.isRead,
      date: date ?? super.date,
      data: data ?? this.data,
    );
  }

  NotificationApplicationReceivedModel copyWithSetIsRead(bool isRead) {
    return this.copyWith(isRead: isRead);
  }

  @override
  String toString() {
    return 'NotificationApplicationReceivedModel{id: $id, type: $type, body: $body, title: $title, isRead: $isRead, date: $date, data: $data}';
  }
}

class NotificationApplicationReceivedDataModel {
  final ProfileInfoModel? customer;
  final CompanyJobModel? job;

  const NotificationApplicationReceivedDataModel({this.customer, this.job});

  factory NotificationApplicationReceivedDataModel.fromJson(
    Map<String, dynamic>? json,
  ) =>
      NotificationApplicationReceivedDataModel(
        customer: json?["customer"] != null
            ? ProfileInfoModel.fromJson(json?["customer"])
            : null,
        job: json?["job"] != null
            ? CompanyJobModel.fromJson(json?["job"])
            : null,
      );

  @override
  String toString() {
    return 'NotificationFollowerDataModel{customerId: $customer}';
  }
}

class NotificationApplicationSubscriptionModel extends BaseNotificationModel {
  const NotificationApplicationSubscriptionModel({
    super.id,
    super.title,
    super.body,
    super.date,
    super.isRead,
    super.type,
  });

  Map<String, dynamic> toJson() {
    return super.toJson();
  }

  factory NotificationApplicationSubscriptionModel.fromJson(
      Map<String, dynamic>? json) {
    return NotificationApplicationSubscriptionModel(
      id: json?["id"],
      type: json?["type"],
      body: json?["body"],
      title: json?["title"],
      isRead: json?["is_read"],
      date: json?["date"],
    );
  }

  NotificationApplicationSubscriptionModel copyWith({
    String? id,
    String? type,
    String? body,
    String? title,
    bool? isRead,
    String? date,
  }) {
    return NotificationApplicationSubscriptionModel(
      id: id ?? super.id,
      type: type ?? super.type,
      body: body ?? super.body,
      title: title ?? super.title,
      isRead: isRead ?? super.isRead,
      date: date ?? super.date,
    );
  }

  NotificationApplicationSubscriptionModel copyWithSetIsRead(bool isRead) {
    return this.copyWith(isRead: isRead);
  }
}
