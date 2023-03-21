abstract class IServerHandler<T> {
  void handle(T packet, Map<String, dynamic> json);
}
