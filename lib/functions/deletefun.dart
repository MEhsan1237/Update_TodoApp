
import '../notes_model/notes_model.dart';
import '../utils/notification_class.dart';

void delete(NotesModel notesModel) async {
  String taskTitle = notesModel.title;
  await notesModel.delete();
  
  NotificationClass.showNotification(
    id: 3,
    title: "Task Deleted",
    body: "The task '$taskTitle' has been removed.",
  );
}
