package privat.funprogramer.vocabularytrainer.model;

import java.util.List;

public class VocabularyCollection extends Collection {

    private final List<Vocabulary> vocabularies;

    public VocabularyCollection(String displayName, String firstLanguage,
                                String secondLanguage, List<Vocabulary> vocabularies) {
        super(displayName, firstLanguage, secondLanguage);
        this.vocabularies = vocabularies;
    }

    public boolean isValidObject() {
        return displayName != null && firstLanguage != null && secondLanguage != null && vocabularies != null;
    }

    public List<Vocabulary> getVocabularies() {
        return vocabularies;
    }

    public void swapLanguages() {
        String temp = firstLanguage;
        firstLanguage = secondLanguage;
        secondLanguage = temp;
        for (Vocabulary vocabulary : vocabularies) {
            vocabulary.swapLanguages();
        }
    }
}
