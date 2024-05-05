class Endpoints {
  //static const String ipBackend = 'URL';
  static const String ipBackend = String.fromEnvironment('ipBackend',
      defaultValue: 'http://10.192.230.83:5000');
  // defaultValue: 'http://km0-api:9090');
}
