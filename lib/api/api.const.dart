enum RoutePath {
  AUTH('auth'),
  USER('user');

  const RoutePath(this.name);

  final String name;
}

enum MethodType {
  GET('get'),
  POST('post'),
  PUT('put'),
  PATCH('patch'),
  DELETE('delete');

  const MethodType(this.name);

  final String name;
}

enum StatusCode {
  UNAUTHORIZED(401),
  TOO_MANY_REQUESTS(429),
  INTERNAL_SERVER_ERROR(500);

  const StatusCode(this.code);

  final int code;
}
