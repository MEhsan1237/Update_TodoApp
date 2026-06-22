
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../provider/provider_class.dart';
import '../notes_model/notes_model.dart';
import 'boxes_file.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var tasks = box.values.toList().cast<NotesModel>();
          int total = tasks.length;
          int completed = tasks.where((t) => t.isCompleted).length;
          int pending = total - completed;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 180.0,
                floating: false,
                pinned: true,
                centerTitle: false,
                backgroundColor: Colors.deepPurple,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Analytics', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryCards(total, completed, pending),
                      const SizedBox(height: 24),
                      Text(
                        'Completion Rate',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      _buildPieChart(completed, pending),
                      const SizedBox(height: 24),
                      Text(
                        'Activity Overview',
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      _buildBarChart(tasks),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCards(int total, int completed, int pending) {
    return Row(
      children: [
        _statCard('Total', total.toString(), Colors.blue),
        _statCard('Done', completed.toString(), Colors.green),
        _statCard('Pending', pending.toString(), Colors.orange),
      ],
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: color.withValues(alpha: 0.8))),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(int completed, int pending) {
    bool isEmpty = completed == 0 && pending == 0;
    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
      ),
      child: PieChart(
        PieChartData(
          sectionsSpace: 6,
          centerSpaceRadius: 50,
          sections: isEmpty 
            ? [PieChartSectionData(value: 1, title: '0%', color: Colors.grey[300]!, radius: 40)]
            : [
                PieChartSectionData(
                  value: completed.toDouble(),
                  title: '${((completed/(completed+pending))*100).toInt()}%',
                  color: Colors.deepPurple,
                  radius: 60,
                  titleStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                ),
                PieChartSectionData(
                  value: pending.toDouble(),
                  title: '${((pending/(completed+pending))*100).toInt()}%',
                  color: Colors.orangeAccent,
                  radius: 50,
                  titleStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14),
                ),
              ],
        ),
      ),
    );
  }

  Widget _buildBarChart(List<NotesModel> tasks) {
    // Group by category
    Map<String, int> categories = {};
    if (tasks.isEmpty) {
      categories = {'None': 0};
    } else {
      for (var task in tasks) {
        categories[task.category] = (categories[task.category] ?? 0) + 1;
      }
    }

    List<BarChartGroupData> groups = [];
    int i = 0;
    categories.forEach((cat, count) {
      groups.add(
        BarChartGroupData(
          x: i++,
          barRods: [
            BarChartRodData(
              toY: count.toDouble(),
              color: Colors.deepPurple,
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    });

    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          barGroups: groups,
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < categories.keys.length) {
                    return Text(categories.keys.elementAt(value.toInt()).substring(0, 3));
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }
}
