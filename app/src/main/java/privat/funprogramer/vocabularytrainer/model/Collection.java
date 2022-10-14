package privat.funprogramer.vocabularytrainer.model;

public abstract class Collection {

    public static final String COLLECTION_EXTRA = "privat.funprogramer.vocabularytrainer.CollectionExtra";


    final String displayName;
    String firstLanguage;
    String secondLanguage;
    String sourceFileName;

    public Collection(String displayName, String firstLanguage, String secondLanguage) {
        this.displayName = displayName;
        this.firstLanguage = firstLanguage;
        this.secondLanguage = secondLanguage;
    }

    public String[] getLanguageDirections() {
        return new String[]{firstLanguage + " ➔ " + secondLanguage, secondLanguage + " ➔ " + firstLanguage};
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getFirstLanguage() {
        return firstLanguage;
    }

    public String getSecondLanguage() {
        return secondLanguage;
    }

    public void setSourceFileName(String sourceFileName) {
        this.sourceFileName = sourceFileName;
    }

    public String getSourceFileName() {
        return sourceFileName;
    }
}
