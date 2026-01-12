import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/common_widgets/glass_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: const Text('Collaboration', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: AppTheme.primary,
            labelColor: AppTheme.primary,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(text: "Project Showcase"),
              Tab(text: "Find Team"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildShowcaseTab(),
            _buildFindTeamTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildShowcaseTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "AI Health Assistant",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Icon(Icons.star_border, color: AppTheme.accent),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ["Flutter", "Python", "TensorFlow"]
                      .map((e) => Chip(
                            label: Text(e, style: const TextStyle(fontSize: 10, color: Colors.white)),
                            backgroundColor: Colors.white10,
                            padding: EdgeInsets.zero,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 8),
                const Text(
                  "A smart health monitoring app using wearable data.",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey,
                      child: Text("RD", style: TextStyle(fontSize: 10, color: Colors.white)),
                    ),
                    const SizedBox(width: 8),
                    const Text("Rahul Dev", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFindTeamTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: GlassCard(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppTheme.surface,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Looking for React Dev",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "For: E-Commerce Hackathon Project",
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    minimumSize: const Size(60, 30),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text("Connect", style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
