import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';
import '../routes/custom_route.dart';
import 'new_playlist_screen.dart';
import 'settings_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor, // Black background
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'), // Placeholder
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Good evening',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 22,
                        color: AppTheme.neutralColor,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(CupertinoIcons.add, color: Colors.grey),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(page: const NewPlaylistScreen()),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.settings, color: Colors.grey),
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

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search your library',
                    prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
                    fillColor: const Color(0xFF121212), // Match secondary
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // TabBar
              TabBar(
                isScrollable: true,
                indicatorColor: AppTheme.neutralColor,
                indicatorWeight: 2,
                labelColor: AppTheme.neutralColor,
                unselectedLabelColor: Colors.grey.shade500,
                labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                tabs: const [
                  Tab(text: 'SONGS'),
                  Tab(text: 'ALBUMS'),
                  Tab(text: 'ARTISTS'),
                  Tab(text: 'PLAYLISTS'),
                ],
              ),

              // TabBarView
              Expanded(
                child: TabBarView(
                  children: [
                    _buildSongsList(),
                    const Center(child: Text('Albums')),
                    const Center(child: Text('Artists')),
                    const Center(child: Text('Playlists')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongsList() {
    final songs = [
      {'title': 'Midnight City', 'artist': 'M83 • Hurry Up, We\'re Dreaming', 'gradient': const [Color(0xFF2C3E50), Color(0xFF000000)]},
      {'title': 'Starboy', 'artist': 'The Weeknd • Starboy', 'gradient': const [Color(0xFF141E30), Color(0xFF243B55)]},
      {'title': 'Resonance', 'artist': 'Home • Odyssey', 'gradient': const [Color(0xFF4B79A1), Color(0xFF283E51)]},
      {'title': 'Levitating', 'artist': 'Dua Lipa • Future Nostalgia', 'gradient': const [Color(0xFF000000), Color(0xFF434343)]},
      {'title': 'Ocean Eyes', 'artist': 'Billie Eilish • Don\'t Smile at Me', 'gradient': const [Color(0xFF0F2027), Color(0xFF203A43)]},
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 90), // Padding for MiniPlayer
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: song['gradient'] as List<Color>,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(Icons.music_note, color: Colors.white24, size: 30),
          ),
          title: Text(
            song['title'] as String,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.neutralColor,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              song['artist'] as String,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
