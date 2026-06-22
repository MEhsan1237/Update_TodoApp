import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../functions/deletefun.dart';
import '../functions/updatefun.dart';
import '../notes_model/notes_model.dart';
import '../provider/provider_class.dart';
import '../utils/toast_message.dart';
import 'boxes_file.dart';

class MyAppHive extends StatefulWidget {
  const MyAppHive({super.key});

  @override
  State<MyAppHive> createState() => _MyAppHiveState();
}

class _MyAppHiveState extends State<MyAppHive> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final originalController = TextEditingController();
  String searchText = ""; // 👈 store current search text

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: themeProvider.isDarkMode 
              ? [Colors.black, Colors.deepPurple.withValues(alpha: 0.1)]
              : [const Color(0xFFF8F9FE), Colors.deepPurple.withValues(alpha: 0.05)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: true,
              pinned: true,
              centerTitle: false,
              backgroundColor: Colors.deepPurple,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "My Tasks",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.blueAccent],
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    themeProvider.toggleTheme(!themeProvider.isDarkMode);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: originalController,
                  decoration: InputDecoration(
                    hintText: "Search tasks...",
                    filled: true,
                    fillColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: Boxes.getData().listenable(),
              builder: (context, box, _) {
                var data = box.values.toList().cast<NotesModel>();

                if (data.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_late_outlined, size: 60, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            "No Tasks Yet",
                            style: GoogleFonts.poppins(fontSize: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                var filteredData = searchText.isEmpty
                    ? data
                    : data.where((note) {
                  final title = note.title.toLowerCase();
                  final desc = note.description.toLowerCase();
                  return title.contains(searchText) ||
                      desc.contains(searchText);
                }).toList();

                if (filteredData.isEmpty && searchText.isNotEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        "No matching tasks found 😕",
                        style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final note = filteredData[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Checkbox(
                              value: note.isCompleted,
                              activeColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              onChanged: (value) {
                                note.isCompleted = value ?? false;
                                note.save();
                              },
                            ),
                            title: Text(
                              note.title,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                decoration: note.isCompleted ? TextDecoration.lineThrough : null,
                                color: note.isCompleted ? Colors.grey : null,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        note.category,
                                        style: const TextStyle(color: Colors.deepPurple, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "${note.date.day}/${note.date.month}",
                                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: PopupMenuButton(
                              icon: const Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: const ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text("Edit"),
                                  ),
                                  onTap: () {
                                    if (!context.mounted) return;
                                    updateMyDialogue(context, note, note.title, note.description);
                                  },
                                ),
                                PopupMenuItem(
                                  child: const ListTile(
                                    leading: Icon(Icons.delete, color: Colors.red),
                                    title: Text("Delete", style: TextStyle(color: Colors.red)),
                                  ),
                                  onTap: () {
                                    delete(note);
                                    ToastMessage().message("Deleted");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: filteredData.length,
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
