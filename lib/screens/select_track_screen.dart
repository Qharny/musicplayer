import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme.dart';

class SelectTrackScreen extends StatefulWidget {
  const SelectTrackScreen({super.key});

  @override
  State<SelectTrackScreen> createState() => _SelectTrackScreenState();
}

class _SelectTrackScreenState extends State<SelectTrackScreen> {
  final List<Map<String, dynamic>> _tracks = [
    {
      'title': 'Midnight Monolith',
      'subtitle': 'Aethelgard • Synthesis',
      'selected': true,
      'gradient': const [Color(0xFF0F2027), Color(0xFF203A43)],
    },
    {
      'title': 'Prism Void',
      'subtitle': 'Vector Luna',
      'selected': false,
      'gradient': const [Color(0xFF2C3E50), Color(0xFF000000)],
    },
    {
      'title': 'Echoes in Carbon',
      'subtitle': 'Kinesis • Digital Silence',
      'selected': false,
      'gradient': const [Color(0xFF141E30), Color(0xFF243B55)],
    },
    {
      'title': 'Sub-Zero Pulse',
      'subtitle': 'Frequency One',
      'selected': true,
      'gradient': const [Color(0xFF000000), Color(0xFF434343)],
    },
    {
      'title': 'Linear Gravity',
      'subtitle': 'Architects of Sound',
      'selected': false,
      'gradient': const [Color(0xFF283E51), Color(0xFF4B79A1)],
    },
    {
      'title': 'Opaque Ritual',
      'subtitle': 'Nomenclature',
      'selected': false,
      'gradient': const [Color(0xFF1E293B), Color(0xFF0F172A)],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: AppTheme.neutralColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Tracks',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.neutralColor,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Done',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppTheme.neutralColor,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120), // Space for action bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search tracks, artists, or album',
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
                const SizedBox(height: 24),

                // Filter Pills
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      _buildFilterChip('All Songs', true),
                      const SizedBox(width: 8),
                      _buildFilterChip('Recent', false),
                      const SizedBox(width: 8),
                      _buildFilterChip('Albums', false),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Track List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tracks.length,
                  itemBuilder: (context, index) {
                    final track = _tracks[index];
                    return _buildTrackItem(track, index);
                  },
                ),
              ],
            ),
          ),
          
          // Bottom Action Bar overlaid
          Positioned(
            left: 8,
            right: 8,
            bottom: 8,
            child: _buildBottomActionBar(),
          ),
        ],
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
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          currentIndex: 1, // 'Explore' is selected in image
          items: const [
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(CupertinoIcons.home)),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(CupertinoIcons.search)),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.library_music_outlined)),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(CupertinoIcons.settings)),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.neutralColor : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : AppTheme.neutralColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTrackItem(Map<String, dynamic> track, int index) {
    final isSelected = track['selected'] as bool;
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
            colors: track['gradient'] as List<Color>,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        track['title'] as String,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.neutralColor,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          track['subtitle'] as String,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.grey.shade500,
          ),
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          isSelected ? CupertinoIcons.checkmark_circle_fill : CupertinoIcons.add_circled,
          color: isSelected ? AppTheme.neutralColor : Colors.grey.shade600,
          size: 24,
        ),
        onPressed: () {
          setState(() {
            _tracks[index]['selected'] = !isSelected;
          });
        },
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.music_note, color: Colors.white24, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Midnight Monolith',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.neutralColor,
                  ),
                ),
                Text(
                  'NOW SELECTING',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.grey.shade500,
                    fontSize: 10,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.play_arrow_solid, color: AppTheme.neutralColor, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
