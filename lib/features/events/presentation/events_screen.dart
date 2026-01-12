import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/common_widgets/glass_card.dart';
import '../../../core/common_widgets/gradient_button.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Upcoming Events', style: TextStyle(fontFamily: 'Orbitron', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Admin Create Event
        },
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: GlassCard(
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      image: const DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/400x200"), // Placeholder
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(Icons.event, size: 48, color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hackathon 2024",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Orbitron',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text("OCT 24", style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.white54),
                            SizedBox(width: 4),
                            Text("Main Auditorium", style: TextStyle(color: Colors.white54)),
                            SizedBox(width: 16),
                            Icon(Icons.access_time, size: 16, color: Colors.white54),
                            SizedBox(width: 4),
                            Text("10:00 AM", style: TextStyle(color: Colors.white54)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Join the biggest coding battle of the year. Teams of 4. 24 hours.",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 16),
                        GradientButton(
                          text: "Register Now",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
