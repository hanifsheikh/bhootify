import 'package:bhootify/models/file_model.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MusicPlayerProvider with ChangeNotifier {
  int _fileIndex = 0;
  dynamic _selectedFile = {};
  dynamic _body;
  bool _isPlaying = false;
  bool _isLoading = true;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final AudioPlayer _player = AudioPlayer();

  int get fileIndex => _fileIndex;
  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  Duration get duration => _duration;
  Duration get position => _position;
  dynamic get selectedFile => File.fromJson(_selectedFile);
  AudioPlayer get player => _player;

  void initState() {
    _duration = Duration.zero;
    _position = Duration.zero;
    _isLoading = true;
    _isPlaying = false;
    _player.onPlayerStateChanged.listen((state) {
      _isPlaying = state == PlayerState.playing;
      if (_isPlaying) {
        _isLoading = false;
      }
      notifyListeners();
    });

    // Listen to audio duration
    _player.onDurationChanged.listen((newDuration) {
      _duration = newDuration;
      notifyListeners();
    });

    // Listen to audio position
    _player.onPositionChanged.listen((newPosition) {
      _position = newPosition;
      notifyListeners();
    });
  }

  Future<List<File>> getFiles() async {
    const url =
        "https://drive.google.com/uc?export=download&id=1fYmeuoOUdV77b84untv1oeqEe2E4zSkM";
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    _selectedFile = body[_fileIndex];
    _body = body;
    return body.map<File>(File.fromJson).toList();
  }

  dynamic start(index) async {
    _selectedFile = _body[index];
    await _player.play(UrlSource(File.fromJson(_body[index]).fileURL));
    initState();
    notifyListeners();
  }

  void setEntry(int index) {
    _fileIndex = index;
    notifyListeners();
  }

  void setLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  void nextEntry() {
    _fileIndex++;
    notifyListeners();
  }

  void prevEntry() {
    _fileIndex--;
    notifyListeners();
  }

  void setSeekPosition(value) async {
    final position = Duration(seconds: value.toInt());
    await player.seek(position);
    notifyListeners();
  }
}
