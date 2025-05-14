import 'package:get_it/get_it.dart';
import 'package:lightning_/data/repository/auth/auth_repository_impl.dart';
import 'package:lightning_/data/repository/song/song_repository_impl.dart';
import 'package:lightning_/data/sources/auth/auth_firebase_service.dart';
import 'package:lightning_/data/sources/song/song_firebase_service.dart';
import 'package:lightning_/domain/repository/auth/auth.dart';
import 'package:lightning_/domain/repository/song/song.dart';
import 'package:lightning_/domain/usecases/auth/signin.dart';
import 'package:lightning_/domain/usecases/auth/singup.dart';
import 'package:lightning_/domain/usecases/song/get_news_songs.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());

  sl.registerSingleton<SingupUseCase>(SingupUseCase());

  sl.registerSingleton<SinginUseCase>(SinginUseCase());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
}
