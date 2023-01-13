/// The BrokenFileException indicates that a file was not in the expected format or was corrupted.
class BrokenFileException implements Exception {
  final String message;

  BrokenFileException(this.message);

  BrokenFileException.withDefaultMessage() : message = "Maybe there is some JSON Syntax error in the file.";

  @override
  String toString() {
    return "BrokenFileException: $message";
  }

}

class FilePickingAbortedException implements Exception {}