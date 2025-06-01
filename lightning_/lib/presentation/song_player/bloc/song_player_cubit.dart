import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lightning_/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  Future<void> loadSong(String url) async {
    print(url);
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }
// added these blocks might delete later

  void rewindSong() {
    final newPosition = songPosition - const Duration(seconds: 10);
    audioPlayer
        .seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
    emit(SongPlayerLoaded());
  }

  void forwardSong() {
    final max = songDuration;
    final newPosition = songPosition + const Duration(seconds: 10);
    audioPlayer.seek(newPosition <= max ? newPosition : max);
    emit(SongPlayerLoaded());
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
    emit(SongPlayerLoaded());
  }

  void updateSlider(double seconds) {
    songPosition = Duration(seconds: seconds.toInt());
    emit(SongPlayerLoaded());
  }

//... end of the block
  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
