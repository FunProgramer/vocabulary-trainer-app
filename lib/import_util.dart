import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:json_schema3/json_schema3.dart';
import 'package:json_schema3/src/json_schema/models/validation_results.dart';
import 'package:vocabulary_trainer_app/exception.dart';
import 'package:vocabulary_trainer_app/model.dart';

Future<FullVocabularyCollection> readVocabularyCollectionFromJSONFile() async {
  FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
    dialogTitle: "Pick a Vocabulary Collection JSON File",
    type: FileType.custom,
    allowedExtensions: ["json"],
    allowMultiple: false,
    lockParentWindow: true
  );
  if (fileResult != null) {
    File collectionFile = File(fileResult.files.single.path!);
    String json = await collectionFile.readAsString();

    var validationResults = await _validateJSON(json);

    if (!validationResults.isValid) {
      throw BrokenFileException(validationResults.errors.toString());
    }

    return _serializeJSON(json);
  } else {
    throw FilePickingAbortedException();
  }
}

Future<ValidationResults> _validateJSON(String json) async {
  final schemaString =
      await rootBundle.loadString("schema/vocabulary-collection.schema.json");

  final schema = await JsonSchema.createAsync(schemaString);
  return schema.validate(json, parseJson: true);
}

Future<FullVocabularyCollection> _serializeJSON(String json) async {
  Map<String, dynamic> collectionMap = await jsonDecode(json);
  return FullVocabularyCollection.fromJson(collectionMap);
}