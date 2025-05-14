import 'package:dartz/dartz.dart';
import 'package:lightning_/data/sources/song/song_firebase_service.dart';
import 'package:lightning_/domain/repository/song/song.dart';
import 'package:lightning_/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }
}
