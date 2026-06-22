
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../notes_model/notes_model.dart';
import '../utils/toast_message.dart';
import '../utils/notification_class.dart';

Future updateMyDialogue(BuildContext context, NotesModel notesModel, String title, String description) {
  final titleController = TextEditingController(text: title);
  final descriptionController = TextEditingController(text: description);
  String selectedCategory = notesModel.category;
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
                    "Update Task",
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
                      prefixIcon: const Icon(Icons.description_outlined, color: Colors.deepPurple),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                      onPressed: () async {
                        notesModel.title = titleController.text;
                        notesModel.description = descriptionController.text;
                        notesModel.category = selectedCategory;
                        await notesModel.save();
                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                        ToastMessage().message("Update successfully");
                        NotificationClass.showNotification(
                          id: 2,
                          title: "Task Updated",
                          body: "The task '${notesModel.title}' has been updated.",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        "Update Changes",
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
