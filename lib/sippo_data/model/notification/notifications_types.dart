import 'package:get/get.dart';

enum NotificationTypes {
  newPost('New Post'),
  newJob('New Job'),
  applicationStatus('Application Status Changed'),
  newApplicationReceived('New Application Received'),
  newFollower('New Follower'),
  subscriptionWillEnd('Subscription Will End Soon'),
  subscriptionEnded('Subscription Ended');

  final String typeName;

  const NotificationTypes(this.typeName);

  static NotificationTypes? typeOf(String? value) {
    return NotificationTypes.values
        .firstWhereOrNull((e) => value == e.typeName);
  }
}

