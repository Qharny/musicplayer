import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';
import 'settings_screen.dart';
import '../routes/custom_route.dart';
import 'new_playlist_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 120), // Mini player padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Good evening',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.neutralColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(CupertinoIcons.settings, color: AppTheme.neutralColor, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(page: const SettingsScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Title Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Library',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.neutralColor,
                        fontSize: 44,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '32 favorite tracks and 8 playlists.',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Filter Pills
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildFilterChip('ALL', true),
                    const SizedBox(width: 8),
                    _buildFilterChip('SONGS', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('PLAYLISTS', false),
                    const SizedBox(width: 8),
                    _buildFilterChip('ALBUMS', false),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Recent Favorites Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Recent Favorites',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.neutralColor,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'SEE ALL',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Tracks
              _buildTrackItem('Nocturnal Silence', 'Ether Drift • 2024', const [Color(0xFF1E293B), Color(0xFF0F172A)]),
              _buildTrackItem('Prism Layers', 'Spatial Theory', const [Color(0xFF0F2027), Color(0xFF203A43)]),
              _buildTrackItem('The Last Echo', 'Isolde Frey', const [Color(0xFF2C3E50), Color(0xFF000000)]),
              const SizedBox(height: 32),

              // Curated Playlists Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Curated Playlists',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.neutralColor,
                        fontSize: 22,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(page: const NewPlaylistScreen()),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Row(
                          children: [
                            Icon(CupertinoIcons.add, color: AppTheme.neutralColor, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'NEW',
                              style: TextStyle(
                                color: AppTheme.neutralColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Playlists Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildWidePlaylistCard(
                      'Midnight Focus',
                      'Deep techno & ambient structures',
                      const [Color(0xFF1E293B), Color(0xFF000000)],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSquarePlaylistCard(
                            'Primal\nBeats',
                            const [Color(0xFF141E30), Color(0xFF000000)],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildSquarePlaylistCard(
                            'Late Night\nJazz',
                            const [Color(0xFF2C3E50), Color(0xFF000000)],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.neutralColor : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : AppTheme.neutralColor,
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildTrackItem(String title, String subtitle, List<Color> gradient) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.music_note, color: Colors.white24, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.neutralColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.heart, color: Colors.grey, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildWidePlaylistCard(String title, String subtitle, List<Color> gradient) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.neutralColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquarePlaylistCard(String title, List<Color> gradient) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child: Text(
              title,
              style: const TextStyle(
                color: AppTheme.neutralColor,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
