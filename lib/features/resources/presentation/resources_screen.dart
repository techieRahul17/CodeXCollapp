import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/common_widgets/glass_card.dart';

class ResourcesScreen extends ConsumerWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Academic Resources', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUploadSection(),
            const SizedBox(height: 24),
            const Text(
              "Top Contributors",
              style: TextStyle(color: AppTheme.primary, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Orbitron'),
            ),
            const SizedBox(height: 12),
            _buildLeaderboard(),
            const SizedBox(height: 24),
            const Text(
              "Latest Materials",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Orbitron'),
            ),
            const SizedBox(height: 12),
            _buildResourcesList(),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadSection() {
    return GlassCard(
      child: Row(
        children: [
          const Icon(Icons.cloud_upload_outlined, color: AppTheme.accent, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Share Knowledge",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Upload notes, PYQs, and slides to earn XP.",
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Open Upload Dialog (Placeholder)
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaderboard() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final colors = [Colors.amber, Colors.grey, Colors.brown, Colors.white54, Colors.white54];
          return Container(
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: colors[index].withOpacity(0.2),
                      child: Text("U${index + 1}", style: TextStyle(color: colors[index])),
                    ),
                    if (index < 3)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(Icons.star, color: colors[index], size: 16),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("${(5-index)*100} XP", style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildResourcesList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: GlassCard(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.description, color: AppTheme.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data Structures Unit ${index + 1} Notes",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "By Rahul V S • 2 days ago",
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.download, color: Colors.white70),
              ],
            ),
          ),
        );
      },
    );
  }
}
