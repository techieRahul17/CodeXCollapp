import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ssn_coding_club/core/theme/app_theme.dart';

class CodeCastScreen extends StatefulWidget {
  const CodeCastScreen({super.key});

  @override
  State<CodeCastScreen> createState() => _CodeCastScreenState();
}

class _CodeCastScreenState extends State<CodeCastScreen>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  double frequency = 98.5;
  
  // Fake data for the feed
  final List<Map<String, String>> campusUpdates = [
    {
      "title": "Hackathon 2026 Registration Open!",
      "time": "10 min ago",
      "category": "Event"
    },
    {
      "title": "Library hours extended for finals week.",
      "time": "1 hr ago",
      "category": "Campus"
    },
    {
      "title": "New menu items at the main cafeteria 🍔",
      "time": "2 hrs ago",
      "category": "Food"
    },
  ];

  final List<Map<String, dynamic>> achievements = [
    {
      "name": "Team Nova",
      "achievement": "1st Place - SIH 2025",
      "image": "assets/images/trophy.png", // Placeholder
      "color": AppTheme.primary
    },
    {
      "name": "Rahul V S",
      "achievement": "GSoC '25 Selection",
      "image": "assets/images/google.png", // Placeholder
      "color": AppTheme.accent
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Background Gradient Animation
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.background,
                    AppTheme.surface,
                    AppTheme.background,
                  ],
                ),
              ),
            ),
          ),
          
          // Ambient Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondary.withOpacity(0.2),
                image: null,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.secondary.withOpacity(0.4),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .scale(duration: 4.seconds, begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),

          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withOpacity(0.15),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.3),
                    blurRadius: 100,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .scale(duration: 5.seconds, begin: const Offset(1, 1), end: const Offset(1.3, 1.3)),

          // Main Content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.radio_outlined, color: AppTheme.accent, size: 28),
                            const SizedBox(width: 12),
                            Text(
                              "CodeCast FM",
                              style: GoogleFonts.orbitron(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                              ).animate(onPlay: (c) => c.repeat(reverse: true))
                               .fade(duration: 600.ms, begin: 0.2, end: 1.0),
                              const SizedBox(width: 8),
                              Text(
                                "LIVE",
                                style: GoogleFonts.poppins(
                                  color: Colors.redAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Player Section
                SliverToBoxAdapter(
                  child: _buildPlayerSection(),
                ),

                // News Feed Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                    child: Text(
                      "CAMPUS FEED",
                      style: GoogleFonts.orbitron(
                        fontSize: 14,
                        color: AppTheme.textGrey,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Breaking News Ticker / List
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildUpdateCard(campusUpdates[index], index);
                    },
                    childCount: campusUpdates.length,
                  ),
                ),

                // Achievements Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
                    child: Row(
                      children: [
                        Text(
                          "HALL OF FAME",
                          style: GoogleFonts.orbitron(
                            fontSize: 14,
                            color: AppTheme.textGrey,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward, color: AppTheme.textGrey, size: 16),
                      ],
                    ),
                  ),
                ),

                // Achievements Horizontal Scroll
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: achievements.length + 1,
                      separatorBuilder: (c, i) => const SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        if (index == achievements.length) {
                          return _buildAddAchievementCard();
                        }
                        return _buildAchievementCard(achievements[index], index);
                      },
                    ),
                  ),
                ),

                // Upcoming Jams (Events) Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
                    child: Text(
                      "UPCOMING JAMS",
                      style: GoogleFonts.orbitron(
                        fontSize: 14,
                        color: AppTheme.textGrey,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                // Event Cards
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return _buildEventCard(index);
                    },
                    childCount: 2, 
                  ),
                ),
                
                const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // Visualizer
                SizedBox(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(20, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 4,
                          height: isPlaying 
                              ? 10 + math.Random().nextInt(50).toDouble() 
                              : 10.0,
                          decoration: BoxDecoration(
                            color: index % 2 == 0 ? AppTheme.primary : AppTheme.accent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      );
                    }),
                  ),
                ).animate(
                  target: isPlaying ? 1 : 0, 
                  onPlay: (c) => c.repeat()
                ).custom(
                  duration: 200.ms,
                  builder: (context, value, child) => child, 
                ), // Trigger rebuilds for random heights

                const SizedBox(height: 25),

                // Song Info
                Text(
                  "SSN Anthem - Remix",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ).animate().shimmer(duration: 2.seconds, color: Colors.white.withOpacity(0.5)),
                Text(
                  "Campus Beats • 98.5 FM",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppTheme.textGrey,
                  ),
                ),

                const SizedBox(height: 30),

                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 32),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [AppTheme.primary, AppTheme.secondary],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primary.withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ).animate(target: isPlaying ? 1 : 0)
                     .scale(end: const Offset(0.9, 0.9), duration: 100.ms),
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 32),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Frequency Slider
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2,
                    activeTrackColor: AppTheme.accent,
                    inactiveTrackColor: Colors.white24,
                    thumbColor: Colors.white,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayColor: AppTheme.accent.withOpacity(0.2),
                  ),
                  child: Slider(
                    value: frequency,
                    min: 88.0,
                    max: 108.0,
                    onChanged: (val) {
                      setState(() {
                        frequency = val;
                      });
                    },
                  ),
                ),
                Text(
                  "${frequency.toStringAsFixed(1)} MHZ",
                  style: GoogleFonts.orbitron(
                    color: AppTheme.accent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateCard(Map<String, String> update, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              update['category'] == 'Event' 
                  ? Icons.calendar_today 
                  : update['category'] == 'Food' 
                      ? Icons.fastfood 
                      : Icons.newspaper,
              color: update['category'] == 'Event' 
                  ? AppTheme.primary 
                  : update['category'] == 'Food'
                      ? Colors.orange
                      : AppTheme.accent,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  update['title']!,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  update['time']!,
                  style: GoogleFonts.poppins(
                    color: AppTheme.textGrey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
        ],
      ),
    ).animate(delay: (100 * index).ms).fadeIn().slideX(begin: 0.2, end: 0);
  }

  Widget _buildAchievementCard(Map<String, dynamic> item, int index) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (item['color'] as Color).withOpacity(0.3)),
        image: DecorationImage(
           image: const NetworkImage('https://via.placeholder.com/150/000000/FFFFFF/?text=Achievement'), // Placeholder for now
           fit: BoxFit.cover,
           colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.darken),
        )
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  item['name']!,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item['achievement']!,
                  style: GoogleFonts.poppins(
                    color: item['color'],
                    fontSize: 10,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(Icons.emoji_events, color: item['color'], size: 20),
          ),
        ],
      ),
    ).animate(delay: (200 * index).ms).scale();
  }

  Widget _buildAddAchievementCard() {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white30),
              ),
              child: const Icon(Icons.add, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Text(
              "Submit Yours",
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildEventCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      height: 120,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    'https://via.placeholder.com/200/FF007F/FFFFFF/?text=Party',
                    fit: BoxFit.cover,
                    color: AppTheme.primary.withOpacity(0.3),
                    colorBlendMode: BlendMode.colorBurn,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.primary.withOpacity(0.2),
                        child: const Center(
                          child: Icon(Icons.event, color: Colors.white24, size: 30),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      index == 0 ? "24\nOCT" : "01\nNOV",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    index == 0 ? "Neon Night Jams" : "Halloween Spooktacular",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.textGrey, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "Main Auditorium",
                        style: GoogleFonts.poppins(
                          color: AppTheme.textGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Live DJ • Food Trucks • Games",
                    style: GoogleFonts.poppins(
                      color: AppTheme.accent,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.1),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ],
      ),
    ).animate(delay: (300 * index).ms).fadeIn().slideY(begin: 0.2, end: 0);
  }
}
