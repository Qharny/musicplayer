import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';
import '../routes/custom_route.dart';
import 'home_page.dart';
import 'search_screen.dart';
import 'now_playing_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const SearchScreen(),
    const Center(child: Text('Favorites Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          _pages[_currentIndex],
          
          // Mini Player overlaid at the bottom
          Positioned(
            left: 8,
            right: 8,
            bottom: 0, // Sits right above the BottomNavigationBar because Stack is inside Scaffold body
            child: _buildMiniPlayer(),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: AppTheme.secondaryColor, // Or primaryColor based on theme
          selectedItemColor: AppTheme.neutralColor,
          unselectedItemColor: Colors.grey.shade600,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(CupertinoIcons.home),
              ),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(CupertinoIcons.search),
              ),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(CupertinoIcons.heart),
              ),
              label: 'FAVORITES',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniPlayer() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CustomPageRoute(page: const NowPlayingScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF161616), // Darker grey
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                // Mini Album Art
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF141E30), Color(0xFF243B55)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: AppTheme.neutralColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Song Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Midnight Monologue',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.neutralColor,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        'Solaris Echo',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.grey.shade500,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                // Controls
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(CupertinoIcons.shuffle, color: Colors.grey, size: 20),
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(CupertinoIcons.backward_end_fill, color: Colors.grey, size: 20),
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppTheme.neutralColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(CupertinoIcons.play_arrow_solid, color: Colors.black, size: 18),
                ),
                const SizedBox(width: 12),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(CupertinoIcons.forward_end_fill, color: Colors.grey, size: 20),
                  onPressed: () {},
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: AppTheme.neutralColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
