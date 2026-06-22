

import 'package:hive/hive.dart';

import '../notes_model/notes_model.dart';


class Boxes    {

  static Box<NotesModel> getData()=> Hive.box("notes");

}