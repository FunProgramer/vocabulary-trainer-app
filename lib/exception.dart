import 'package:vocabulary_trainer_app/models/data_fetching_state.dart';

/// The BrokenFileException indicates that a
/// file was not in the expected format or was corrupted.
class BrokenFileException implements Exception {}

/// The FilePickingAbortedException is thrown
/// if the user not submits a file in the file picker dialog.
class FilePickingAbortedException implements Exception {}

/// The NoDataException is thrown
/// if the database returns nothing
/// (that can happen if the requested data not exists)
class NoDataException implements Exception {}

/// The NoErrorStateException is thrown by
/// the [DataFetchingState] class to indicate,
/// that the exception getter method was called
/// while the state was not on error.
class NoErrorStateException implements Exception {}

/// The NoFinishedStateException is thrown by
/// the [DataFetchingState] class to indicate,
/// that the data getter method was called
/// while the state was not on finished.
class NoFinishedStateException implements Exception {}
