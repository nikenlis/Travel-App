class ServerExcaption implements Exception {

}

class NotFoundExcaption implements Exception {
  final String message;

  NotFoundExcaption({required this.message});

}

class CachedExcaption implements Exception {
  
}