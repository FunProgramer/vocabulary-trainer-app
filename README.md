# Vocabulary Trainer

An app to learn vocabularies, developed with flutter.

![Screenshot of Vocabulary Trainer](./Training_Screenshot.png)

## Install
You can download the app from the [releases page](https://github.com/FunProgramer/vocabulary-trainer-app/releases).
On Android then just open that file with the "Package Installer" App (Normal APK installation).
On iOS you probably need an app like [AltStore](https://altstore.io/) to install this app.

## Usage
To use this app you need a ".voc.json" file that contains the vocabularies.
An example for such a file is in this repo: [example-vocabulary-collection.voc.json](./example-vocabulary-collection.voc.json)
If you create such a file yourself it's important, that your file follows this json schema: [schema/vocabulary-collection.schema.json](./schema/vocabulary-collection.schema.json)

Then if you have a vocabulary json file ready on your phone, click on the + Button in the bottom right corner of the app.
A file selection dialog/activity will open where you can choose you vocabulary json file.
Next you will see a preview of the vocabulary collection. Tap on the save icon in the upper right corner to import this collection.
Then you will return to the main menu where you can again select the collection and then tap on the 'thinking head' icon to start learning the vocabularies.

## Manual Build

First you need to download all dart packages.
```shell
flutter pub get
```

Before you can run the normal flutter build command, 
please run the following command to generate the required database code:

```shell
flutter packages pub run build_runner build
```

After that just the normal build command:

```shell
flutter build
```

## Database Structure

Database structure looks like this as ER model:

![Database structure as erm diagram](./ERM.png "ER Model")

Transformed to a relational database diagram (text form) the structure looks like this:

> VocabularyCollection(<u>id</u>, title, languageA, languageB)\
Vocabulary(<u>id</u>, languageA, languageARegex, languageB, languageBRegex, collectionID(FK))
>

To find out more about the meanings of the attributes look at
the file ["assets/vocabulary-collection.schema.json"](schema/vocabulary-collection.schema.json).\
*Note: The Vocabulary object (mentioned here) is the equivalent to 
the "vocabularies" key in the schema file.*

## Contributing and contact
If you have any improvements to this app feel free to create a pull request.
Also you can contact me by email or create an issue in case of any questions.
