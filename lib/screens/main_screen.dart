import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';
import '../routes/custom_route.dart';
import 'home_page.dart';
import 'search_screen.dart';
import 'now_playing_screen.dart';
import 'favorite_screen.dart';

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
    const FavoriteScreen(),
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
        margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF121212), // Darker grey
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
            // Top Progress Bar
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 2,
                    color: AppTheme.neutralColor,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    height: 2,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Row(
                children: [
                  // Mini Album Art
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade700, width: 2),
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
                          'Nocturnal Silence',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.neutralColor,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Ether Drift',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Controls
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(CupertinoIcons.backward_end_fill, color: Colors.grey, size: 20),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.neutralColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(CupertinoIcons.play_arrow_solid, color: Colors.black, size: 24),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(CupertinoIcons.forward_end_fill, color: Colors.grey, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
