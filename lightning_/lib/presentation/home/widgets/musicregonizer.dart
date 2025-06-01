import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:http/http.dart' as http;
import 'package:lightning_/core/configs/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicIdentifier extends StatefulWidget {
  const MusicIdentifier({super.key});

  @override
  State<MusicIdentifier> createState() => _MusicIdentifierState();
}

class _MusicIdentifierState extends State<MusicIdentifier> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isLoading = false;

  String? _title;
  String? _artist;
  String? _album;
  String? _spotifyUrl;

  final String _apiKey = '95bb6a7321e74b134cfc4e5c46646007';

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) return;

    Directory tempDir = await getTemporaryDirectory();
    String filePath = '${tempDir.path}/recorded.aac';

    await _recorder.openRecorder();
    await _recorder.startRecorder(
      toFile: filePath,
      codec: Codec.aacADTS,
    );

    setState(() {
      _isRecording = true;
      _title = null;
      _artist = null;
      _album = null;
      _spotifyUrl = null;
    });

    await Future.delayed(const Duration(seconds: 6));
    await _recorder.stopRecorder();

    setState(() => _isRecording = false);

    await _identifySong(File(filePath));
  }

  Future<void> _identifySong(File audioFile) async {
    setState(() => _isLoading = true);

    final bytes = await audioFile.readAsBytes();
    final base64Audio = base64Encode(bytes);

    final response = await http.post(
      Uri.parse('https://api.audd.io/'),
      body: {
        'api_token': _apiKey,
        'audio': base64Audio,
        'return': 'spotify,deezer,apple_music',
      },
    );

    final data = json.decode(response.body);
    if (data['status'] == 'success' && data['result'] != null) {
      final result = data['result'];
      setState(() {
        _title = result['title'];
        _artist = result['artist'];
        _spotifyUrl = result['spotify']?['external_urls']?['spotify'];
      });
    } else {
      setState(() {
        _title = 'No match found.';
        _artist = null;
        _spotifyUrl = null;
      });
    }

    setState(() => _isLoading = false);
  }

  Future<void> _launchSpotify() async {
    if (_spotifyUrl != null && await canLaunchUrl(Uri.parse(_spotifyUrl!))) {
      await launchUrl(Uri.parse(_spotifyUrl!),
          mode: LaunchMode.externalApplication);
    }
  }

  /* added block here */

  Future<void> _searchGoogle() async {
    if (_title == null || _artist == null) return;

    final query = Uri.encodeComponent('$_title $_artist');
    final googleUrl = Uri.parse('https://www.google.com/search?q=$query');

    if (await canLaunchUrl(googleUrl)) {
      await launchUrl(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Google search.')),
      );
    }
  }

// might remove the added block
  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasResult = _title != null;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: _isRecording || _isLoading ? null : _startRecording,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
            icon: const Icon(Icons.music_note_rounded),
            label: Text(
              _isRecording ? 'Listening...' : 'Tap to Identify Music',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          if (_isLoading) const CircularProgressIndicator(),
          if (hasResult && !_isLoading) ...[
            const Text(
              '🎵 Identified Song',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Title: $_title   Artist: $_artist',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 0),
          ],
        ],
      ),
    );
  }
}
