enum NetworkRoutes {
  HOME,
  CONTENT,
}

extension NetworkRoutesString on NetworkRoutes {
  String get rawValue {
    switch (this) {
      case NetworkRoutes.HOME:
        return "/content/get";
      case NetworkRoutes.CONTENT:
        return "/content/get/{id}";
    }
  }
}
