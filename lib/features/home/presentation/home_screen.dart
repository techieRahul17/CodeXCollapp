import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/common_widgets/glass_card.dart';
import '../../../core/common_widgets/gradient_button.dart';
import '../../../core/utils/avatar_generator.dart';
import '../../auth/application/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // In a real app, we would fetch the user from a provider
    const String userName = "Rahul V S"; 
    const String userRole = "Member";
    
    return Scaffold(
      backgroundColor: AppTheme.background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SSN CODING CLUB',
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: AppTheme.primary,
              child: Text(
                AvatarGenerator.generateInitials(userName),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context, ref),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0F0F), AppTheme.background],
            stops: [0.0, 0.3],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroSection(userName, userRole),
                    const SizedBox(height: 24),
                    _buildSectionHeader("My Roadmap"),
                    const SizedBox(height: 12),
                    _buildRoadmapWidget(),
                    const SizedBox(height: 24),
                    _buildSectionHeader("Current Projects"),
                    const SizedBox(height: 12),
                    _buildProjectsCarousel(),
                    const SizedBox(height: 24),
                    _buildSectionHeader("Upcoming Events"),
                    const SizedBox(height: 12),
                    _buildEventsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(String name, String role) {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back,",
                  style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  name,
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppTheme.secondary.withOpacity(0.5)),
                  ),
                  child: Text(
                    role,
                    style: const TextStyle(color: AppTheme.accent, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.orbitron(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildRoadmapWidget() {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildRoadmapItem("Flutter Basics", true),
          _buildLine(),
          _buildRoadmapItem("State Mgmt", true),
          _buildLine(),
          _buildRoadmapItem("Clean Arch", false, isNext: true),
          _buildLine(),
          _buildRoadmapItem("Testing", false),
        ],
      ),
    );
  }

  Widget _buildRoadmapItem(String title, bool isCompleted, {bool isNext = false}) {
    Color color = isCompleted ? AppTheme.primary : (isNext ? AppTheme.accent : Colors.grey);
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(
            isCompleted ? Icons.check : (isNext ? Icons.play_arrow : Icons.lock),
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(color: isNext ? Colors.white : Colors.white60, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildLine() {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.only(bottom: 24, left: 4, right: 4),
      color: Colors.white24,
    );
  }

  Widget _buildProjectsCarousel() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildProjectCard("Portfolio App", "Flutter"),
          _buildProjectCard("AI Chatbot", "Python"),
          _buildProjectCard("Club Website", "React"),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String tech) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                ),
                Text(
                  tech,
                  style: const TextStyle(color: AppTheme.primary, fontSize: 12),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_forward, color: Colors.white54),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEventsList() {
    return Column(
      children: [
        _buildEventItem("Hackathon 2024", "Oct 24", "Main Auditorium"),
        const SizedBox(height: 12),
        _buildEventItem("Flutter Workshop", "Nov 02", "Lab 2"),
      ],
    );
  }

  Widget _buildEventItem(String title, String date, String location) {
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(date.split(" ")[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(date.split(" ")[1], style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text(location, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          GradientButton(
            text: "Join",
            onPressed: () {},
          ).width(80).height(36), // Custom extension or wrap in SizedBox
        ],
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: AppTheme.surface,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [AppTheme.primary, AppTheme.secondary]),
            ),
            child: Center(
              child: Text("MENU", style: TextStyle(fontFamily: "Orbitron", fontSize: 24, color: Colors.white)),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text("Home", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Colors.white),
            title: const Text("Resources", style: TextStyle(color: Colors.white)),
            onTap: () => context.push('/resources'),
          ),
          ListTile(
            leading: const Icon(Icons.group, color: Colors.white),
            title: const Text("Collaboration", style: TextStyle(color: Colors.white)),
            onTap: () => context.push('/projects'),
          ),
          ListTile(
            leading: const Icon(Icons.event, color: Colors.white),
            title: const Text("Events", style: TextStyle(color: Colors.white)),
            onTap: () => context.push('/events'),
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text("Logout", style: TextStyle(color: Colors.white)),
            onTap: () {
               ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}

extension WidgetExt on Widget {
  Widget width(double w) => SizedBox(width: w, child: this);
  Widget height(double h) => SizedBox(height: h, child: this);
}
