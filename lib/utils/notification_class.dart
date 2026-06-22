// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationClass {
//
//   static FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
//
//
//       static  initialize()async{
//      AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
//      DarwinInitializationSettings ios = DarwinInitializationSettings();
//      InitializationSettings initializationSettings = InitializationSettings(
//        android: android,
//        iOS: ios
//      );
//      await notificationsPlugin.initialize(settings: initializationSettings);
//      // if(.isAndroid){
//      //   notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
//      //
//      // }
//      // else {
//      //   notificationsPlugin.resolvePlatformSpecificImplementation<DarwinFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
//      // }
//   }
//
//   static  show () async{
//        AndroidNotificationDetails androidDetails = AndroidNotificationDetails('channel_id','mine_channel');
//        DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
//        NotificationDetails notificationDetails = NotificationDetails(
//          android: androidDetails,
//          iOS: iosDetails
//        );
//       await notificationsPlugin.show(id: 100,
//         title:'Mine Message',
//          body: 'this is the first message',
//          notificationDetails:notificationDetails
//
//        );
//
//   }
// }