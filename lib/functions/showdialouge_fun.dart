
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main_screen/boxes_file.dart';
import '../notes_model/notes_model.dart';
import '../utils/toast_message.dart';
import '../utils/notification_class.dart';

Future showMyDialogue(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedCategory = 'Work';
  final categories = ['Work', 'Personal', 'Shopping', 'Health', 'General'];

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 20,
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Create New Task",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: titleController,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelText: "Task Title",
                      hintText: "What needs to be done?",
                      prefixIcon: const Icon(Icons.title, color: Colors.deepPurple),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Add some details...",
                      prefixIcon: const Icon(Icons.description_outlined, color: Colors.deepPurple),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text("Category", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: categories.map((cat) {
                      final isSelected = selectedCategory == cat;
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (selected) {
                          setModalState(() {
                            selectedCategory = cat;
                          });
                        },
                        selectedColor: Colors.deepPurple,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isEmpty) {
                          ToastMessage().message("Title is required");
                          return;
                        }
                        var data = NotesModel(
                          title: titleController.text,
                          description: descriptionController.text,
                          date: DateTime.now(),
                          category: selectedCategory,
                          isCompleted: false,
                        );
                        var box = Boxes.getData();
                        box.add(data);
                        Navigator.pop(context);
                        ToastMessage().message("Task added successfully");
                        NotificationClass.showNotification(
                          id: 1,
                          title: "Task Added",
                          body: "Your task '${titleController.text}' has been saved.",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        "Save Task",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
