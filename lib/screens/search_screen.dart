import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../theme.dart';
import '../services/audio_manager.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioManager>(
      builder: (context, audioManager, child) {
        return Scaffold(
          backgroundColor: AppTheme.primaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
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
                          icon: const Icon(CupertinoIcons.settings, color: Colors.grey),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'What do you want to listen to?',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
                        fillColor: const Color(0xFF121212),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Genres/Tags
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildChip('Electronic'),
                        const SizedBox(width: 8),
                        _buildChip('Jazz Fusion'),
                        const SizedBox(width: 8),
                        _buildChip('Ambient'),
                        const SizedBox(width: 8),
                        _buildChip('Lofi Hip Hop'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Top Artists
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Top Artists',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.neutralColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildArtistCard('Solaris Echo', const [Color(0xFF2C3E50), Color(0xFF000000)]),
                        const SizedBox(width: 16),
                        _buildArtistCard('Luna Ray', const [Color(0xFF141E30), Color(0xFF243B55)]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Songs Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Songs',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.neutralColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  if (audioManager.songs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('No local songs found', style: TextStyle(color: Colors.white54)),
                    )
                  else
                    ...List.generate(
                      audioManager.songs.length > 5 ? 5 : audioManager.songs.length,
                      (index) {
                        final song = audioManager.songs[index];
                        return _buildSongItem(
                          context,
                          (index + 1).toString().padLeft(2, '0'),
                          song.title,
                          song.artist ?? 'Unknown Artist',
                          '${(song.duration! / 60000).toInt()}:${((song.duration! % 60000) / 1000).toInt().toString().padLeft(2, '0')}',
                          song.id,
                          index,
                          audioManager,
                        );
                      },
                    ),

                  const SizedBox(height: 32),

                  // Featured Album
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Featured Album',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.neutralColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFeaturedAlbum(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.neutralColor,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildArtistCard(String name, List<Color> gradient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Icon(CupertinoIcons.person_solid, color: Colors.white24, size: 40),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            color: AppTheme.neutralColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Artist',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildSongItem(BuildContext context, String index, String title, String artist, String duration, int songId, int actualIndex, AudioManager audioManager) {
    return InkWell(
      onTap: () => audioManager.playSong(actualIndex),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                index,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 8),
            QueryArtworkWidget(
              id: songId,
              type: ArtworkType.AUDIO,
              nullArtworkWidget: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF121212), Color(0xFF2A2A2A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.music_note, color: Colors.white24, size: 24),
              ),
              artworkWidth: 44,
              artworkHeight: 44,
              artworkBorder: BorderRadius.circular(4),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.neutralColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    artist,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              duration,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(width: 16),
            Icon(Icons.more_horiz, color: Colors.grey.shade600, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedAlbum(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E293B), Color(0xFF000000)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'LATEST RELEASE',
                  style: TextStyle(
                    color: AppTheme.neutralColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 16,
              child: Text(
                'Void',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppTheme.neutralColor,
                  fontSize: 56,
                  letterSpacing: -1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
