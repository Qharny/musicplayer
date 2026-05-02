import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../theme.dart';
import '../routes/custom_route.dart';
import '../services/audio_manager.dart';
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
    return Consumer<AudioManager>(
      builder: (context, audioManager, child) {
        if (!audioManager.hasPermission) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Permissions required to browse music', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.neutralColor),
                  onPressed: () => audioManager.requestPermission(),
                  child: const Text('Allow Access', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          );
        }

        if (audioManager.songs.isEmpty) {
          return const Center(
            child: Text('No local songs found', style: TextStyle(color: Colors.white70)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 90),
          itemCount: audioManager.songs.length,
          itemBuilder: (context, index) {
            final song = audioManager.songs[index];
            return ListTile(
              onTap: () => audioManager.playSong(index),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2C3E50), Color(0xFF000000)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(Icons.music_note, color: Colors.white24, size: 30),
                ),
                artworkWidth: 56,
                artworkHeight: 56,
                artworkBorder: BorderRadius.circular(4),
              ),
              title: Text(
                song.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.neutralColor,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  song.artist ?? 'Unknown Artist',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
      },
    );
  }
}
