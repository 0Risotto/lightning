import 'package:dartz/dartz.dart';
import 'package:lightning_/data/models/auth/create_user_req.dart';
import 'package:lightning_/data/models/auth/signin_user_req.dart';
import 'package:lightning_/data/sources/auth/auth_firebase_service.dart';
import 'package:lightning_/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {

  

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }
  

  
  @override
  Future<Either> signin(SigninUserReq signinUserReq)async {
    return await sl<AuthFirebaseService>().signin(signinUserReq);
  }
  
}