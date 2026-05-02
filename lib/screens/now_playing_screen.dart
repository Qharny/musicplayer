import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_down, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              'PLAYING FROM PLAYLIST',
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Midnight Resonance',
              style: TextStyle(
                color: AppTheme.neutralColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Album Art
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color(0xFF1E1E1E),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF2A3B4C), Color(0xFF121212)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.music_note, size: 80, color: Colors.white.withOpacity(0.05)),
                  ),
                ),
              ),

              // Song Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spectral Horizon',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.neutralColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Aether Velocity',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.heart, color: Colors.grey, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),

              // Progress Bar
              Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      activeTrackColor: AppTheme.neutralColor,
                      inactiveTrackColor: Colors.grey.shade800,
                      thumbColor: AppTheme.neutralColor,
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                      trackShape: const RectangularSliderTrackShape(),
                    ),
                    child: Slider(
                      value: 0.65,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2:44', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                      Text('4:12', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    ],
                  ),
                ],
              ),

              // Main Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.shuffle, color: Colors.grey, size: 24),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.backward_end_fill, color: AppTheme.neutralColor, size: 32),
                    onPressed: () {},
                  ),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppTheme.neutralColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(CupertinoIcons.play_arrow_solid, color: Colors.black, size: 36),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.forward_end_fill, color: AppTheme.neutralColor, size: 32),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.repeat, color: Colors.grey, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),

              // Bottom Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(Icons.devices, color: Colors.grey, size: 20),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.share, color: Colors.grey, size: 20),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.queue_music, color: Colors.grey, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: AppTheme.primaryColor,
          selectedItemColor: AppTheme.neutralColor,
          unselectedItemColor: Colors.grey.shade600,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.heart),
              label: 'FAVORITES',
            ),
          ],
        ),
      ),
    );
  }
}
