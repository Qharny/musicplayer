import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioManager extends ChangeNotifier {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  final OnAudioQuery _audioQuery = OnAudioQuery();

  List<SongModel> _songs = [];
  List<SongModel> get songs => _songs;

  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;

  SongModel? _currentSong;
  SongModel? get currentSong => _currentSong;

  bool get isPlaying => _audioPlayer.playing;
  Duration get currentPosition => _audioPlayer.position;
  Duration get totalDuration => _audioPlayer.duration ?? Duration.zero;

  Future<void> init() async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: true,
    );

    if (_hasPermission) {
      await _fetchSongs();
    }
    notifyListeners();

    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null && _songs.isNotEmpty) {
        _currentSong = _songs[index];
        notifyListeners();
      }
    });

    _audioPlayer.positionStream.listen((_) => notifyListeners());
    _audioPlayer.playerStateStream.listen((_) => notifyListeners());
  }

  Future<void> requestPermission() async {
    _hasPermission = await _audioQuery.checkAndRequest(retryRequest: true);
    if (_hasPermission) {
      await _fetchSongs();
    }
    notifyListeners();
  }

  Future<void> _fetchSongs() async {
    _songs = await _audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    notifyListeners();
  }

  Future<void> playSong(int index) async {
    try {
      final audioSource = ConcatenatingAudioSource(
        children: _songs.map((song) {
          return AudioSource.uri(
            Uri.parse(song.uri ?? ''),
            tag: MediaItem(
              id: song.id.toString(),
              album: song.album ?? 'Unknown Album',
              title: song.title,
              artist: song.artist ?? 'Unknown Artist',
              // We'll leave artUri null for now as on_audio_query handles art locally
            ),
          );
        }).toList(),
      );

      await _audioPlayer.setAudioSource(audioSource, initialIndex: index);
      _audioPlayer.play();
    } catch (e) {
      debugPrint("Error playing audio: $e");
    }
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void playNext() {
    if (_audioPlayer.hasNext) {
      _audioPlayer.seekToNext();
    }
  }

  void playPrevious() {
    if (_audioPlayer.hasPrevious) {
      _audioPlayer.seekToPrevious();
    }
  }

  void toggleShuffle() {
    _audioPlayer.setShuffleModeEnabled(!_audioPlayer.shuffleModeEnabled);
    notifyListeners();
  }

  void toggleRepeat() {
    final mode = _audioPlayer.loopMode == LoopMode.all ? LoopMode.off : LoopMode.all;
    _audioPlayer.setLoopMode(mode);
    notifyListeners();
  }
  
  LoopMode get repeatMode => _audioPlayer.loopMode;
  bool get isShuffle => _audioPlayer.shuffleModeEnabled;
}
