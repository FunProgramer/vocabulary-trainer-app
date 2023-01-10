import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:json_schema2/json_schema2.dart';
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

    bool isValid = await _validateJSON(json);

    if (!isValid) {
      throw BrokenFileException();
    }

    return _serializeJSON(json);
  } else {
    throw FilePickingAbortedException();
  }
}

Future<bool> _validateJSON(String json) async {
  final schemaString =
      await rootBundle.loadString("schema/vocabulary-collection.schema.json");

  final schema = JsonSchema.createSchema(schemaString);
  return schema.validate(schemaString, parseJson: true);
}

Future<FullVocabularyCollection> _serializeJSON(String json) async {
  Map<String, dynamic> collectionMap = await jsonDecode(json);
  return FullVocabularyCollection.fromJson(collectionMap);
}