import 'package:snowflake_client/auth/service/sign-up.service.dart';
import 'package:snowflake_client/network/const/service-server/response_packet.const.dart';
import 'package:snowflake_client/network/handler/server.handler.dart';

class ServiceServerHandler implements IServerHandler<ServiceServerResponsePacket> {
  final ISignUpService _signUpService;

  ServiceServerHandler(this._signUpService);

  @override
  void handle(ServiceServerResponsePacket packet, Map<String, dynamic> json) {
    switch (packet) {
      case ServiceServerResponsePacket.generatedLoverHash:
        _signUpService.setGeneratedLoverHash(json);
        break;
      default:
        break;
    }
  }
}
