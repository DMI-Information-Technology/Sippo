enum ApplicationStatusType { Pending, Accepted, Rejected }

class NotificationModel {
  final String? imagePath;
  final String? title;
  final String? description;
  final String? arriveTime;
  // final bool? isSelected;
  final ApplicationStatusType? applicationStatus;

  NotificationModel({
    this.imagePath,
    this.title,
    this.description,
    this.arriveTime,
    // this.isSelected,
    this.applicationStatus,
  });
}
