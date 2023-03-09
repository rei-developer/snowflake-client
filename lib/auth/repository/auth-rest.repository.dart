abstract class IAuthRestRepository {
  Future<dynamic> verify();

  Future<dynamic> verifyCustom();

  Future<dynamic> register(String name);

  Future<dynamic> withdraw();
}
