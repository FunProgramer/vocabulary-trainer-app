# Vocabulary Trainer

An android app to learn vocabularies and irregular verbs, developed with flutter.

## Database Structure

Database structure looks like this as ERM-Diagram:

![Database structure as erm diagram](./ERM.png "ERM-Diagram")

Transformed to a RDBMS-Diagram (text form) the structure looks like this:

> VocabularyCollection(<u>ID</u>, title, language_a, language_b)\
Vocabulary(<u>ID</u>, language_a, language_a_regex, language_b, language_b_regex, collectionID(FK))
>

To find out more about the meanings of the attributes look at
the file ["assets/vocabulary-collection.schema.json"](assets/vocabulary-collection.schema.json).\
*Note: The Vocabulary object (mentioned here) is the equivalent to 
the "vocabularies" key in the schema file.*