import 'package:dartz/dartz.dart';
import 'package:lightning_/core/usecase/usecase.dart';
import 'package:lightning_/data/repository/song/song_repository_impl.dart';
import 'package:lightning_/service_locator.dart';

// right left req fails goes to left and req correct goes to right
class GetNewsSongsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepositoryImpl>().getNewSongs();
  }
}
