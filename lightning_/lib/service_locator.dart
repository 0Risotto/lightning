import 'package:get_it/get_it.dart';
import 'package:lightning_/data/repository/auth/auth_repository_impl.dart';
import 'package:lightning_/data/sources/auth/auth_firebase_service.dart';
import 'package:lightning_/domain/repository/auth/auth.dart';
import 'package:lightning_/domain/usecases/auth/signin.dart';
import 'package:lightning_/domain/usecases/auth/singup.dart';

final sl = GetIt.instance;

Future <void> initializeDependencies() async{


  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );


  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SingupUseCase>(
    SingupUseCase()
  );

   sl.registerSingleton<SinginUseCase>(
    SinginUseCase()
  );
}