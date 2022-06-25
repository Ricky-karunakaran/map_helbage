import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:helbage/app/_route.dart';
import 'package:helbage/model/_model.dart';

import 'package:helbage/services/FirebaseServices/auth_service.dart';
import 'package:helbage/services/FirebaseServices/storage_service.dart';
import 'package:helbage/shared/_shared.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainScreenViewModel extends IndexTrackingViewModel {
  final _navigator = locator<NavigationService>();
  final _storageService = locator<storage_service>();
  final _auth = locator<AuthService>();

  void initializeNotification() {
    List<ReminderModel> reminderList = [];

    var listener =
        _storageService.readCollectionAsStream("reminder").listen((event) {});
    listener.onData((data) {
      reminderList =
          data.docs.map((e) => ReminderModel.fromJson(e.data())).toList();

      reminderList = reminderList
          .where(
              (element) => element.userID == _auth.getUID() && element.status)
          .toList();

      List<int> indexList = [];
      int counter = 0;
      reminderList.forEach((element) {
        int sub = element.schedule.lastIndexOf("/");
        var listener2 = _storageService
            .readDocumentAsStream(element.schedule.substring(0, sub),
                element.schedule.substring(sub + 1))
            .listen((event) {});

        listener2.onData((value) {
          var temp = pathModel.fromFireStore(
              startTimeString: value['StartTime'],
              locationList: value['locationList'],
              durationList: value['durationList'],
              vehicle: value['vehicle'],
              endTimeString: value['EndTime']);

          counter++;

          createNotification(counter, temp, element);

          // }
        });
      });
    });

    notifyListeners();
  }

  void createNotification(int id, pathModel object, ReminderModel reminder) {
    AwesomeNotifications().cancel(id).whenComplete(() {
      print("cancel");
    });
    var startime = object.getStartTime();
    var endtime = object.getEndTime();
    var current = DateTime.now();

    int first = reminder.schedule.indexOf("/");
    int second = reminder.schedule.indexOf("/", first + 1);
    int last = reminder.schedule.lastIndexOf("/");
    String state = reminder.schedule.substring(first + 1, second);
    String path = reminder.schedule.substring(last + 1);
    String title = path + " (State: " + state + ")";
    String? startlocation = object.startLocation;
    String? endlocation = object.endLocation;
    String? body = startlocation! + " to " + endlocation!;

    AwesomeNotifications().createNotification(
        schedule:
            NotificationCalendar(hour: startime!.hour, minute: startime.minute),
        content: NotificationContent(
            id: id, channelKey: 'scheduled_channel', title: title, body: body));
  }
}
