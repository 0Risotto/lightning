abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
  //type for api
  //params is to create user requests
}
