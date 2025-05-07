import 'package:dartz/dartz.dart';
import 'package:lightning_/core/usecase/usecase.dart';
import 'package:lightning_/data/models/auth/signin_user_req.dart';
import 'package:lightning_/domain/repository/auth/auth.dart';
import 'package:lightning_/service_locator.dart';
// right left req fails goes to left and req correct goes to right
class SinginUseCase implements Usecase <Either,SigninUserReq> {
  
  

  @override
  Future<Either> call({SigninUserReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }

}