import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';

class NewPlaylistScreen extends StatelessWidget {
  const NewPlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.clear, color: AppTheme.neutralColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'New Playlist',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.neutralColor,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Create',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.neutralColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Cover Art Selection
              Center(
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF2A2A2A), Color(0xFF121212)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.add,
                      size: 32,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              
              // Playlist Name Input
              TextField(
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.neutralColor,
                  fontSize: 36,
                ),
                decoration: InputDecoration(
                  hintText: 'Playlist Name',
                  hintStyle: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade800,
                    fontSize: 36,
                  ),
                  filled: false,
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade900),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade900),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.neutralColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
              const SizedBox(height: 40),

              // Add Songs Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Add Songs',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.neutralColor,
                    ),
                  ),
                  Text(
                    'RECOMMENDED',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Recommended Songs List
              _buildRecommendedSongs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendedSongs() {
    final songs = [
      {'title': 'Midnight Monologue', 'artist': 'The Noir Quartet', 'gradient': const [Color(0xFF141E30), Color(0xFF243B55)]},
      {'title': 'Subterranean Echo', 'artist': 'Echo Chamber', 'gradient': const [Color(0xFF0F2027), Color(0xFF203A43)]},
      {'title': 'Fragmented Silence', 'artist': 'Loscilist', 'gradient': const [Color(0xFF121212), Color(0xFF000000)]},
      {'title': 'Velvet Horizon', 'artist': 'Aura', 'gradient': const [Color(0xFF4B79A1), Color(0xFF283E51)]},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(
                colors: song['gradient'] as List<Color>,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
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
            icon: const Icon(CupertinoIcons.add, color: Colors.grey),
            onPressed: () {},
          ),
        );
      },
    );
  }
}
