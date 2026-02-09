abstract class UseCase<UType, Params> {
  Future<UType> call({Params params});
}
