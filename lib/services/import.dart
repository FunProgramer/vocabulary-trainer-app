import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:json_schema/json_schema.dart';

import '../exception.dart';
import '../models/complete_vocabulary_collection.dart';

Future<CompleteVocabularyCollection>
    readVocabularyCollectionFromJSONFile() async {
  FilePickerResult? fileResult = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick a Vocabulary Collection JSON File",
      type: FileType.custom,
      allowedExtensions: ["json"],
      allowMultiple: false,
      lockParentWindow: true);
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

  final schema = await JsonSchema.createAsync(schemaString);
  return schema.validate(json, parseJson: true).isValid;
}

Future<CompleteVocabularyCollection> _serializeJSON(String json) async {
  Map<String, dynamic> collectionMap = await jsonDecode(json);
  return CompleteVocabularyCollection.fromJson(collectionMap);
}
