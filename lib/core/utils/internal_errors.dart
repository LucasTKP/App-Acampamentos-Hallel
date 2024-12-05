class InternalErrors implements Exception {
  final String message;
  InternalErrors({required this.message});

  @override
  String toString() => message;
}
