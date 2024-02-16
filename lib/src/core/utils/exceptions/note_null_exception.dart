class NoteNullException implements Exception{

  const NoteNullException({
    required this.message,
  });
  final String message;

  @override
  String toString() => message;
}
