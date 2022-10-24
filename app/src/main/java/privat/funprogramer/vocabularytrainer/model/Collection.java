package privat.funprogramer.vocabularytrainer.model;

public abstract class Collection {

    public static final String COLLECTION_EXTRA = "privat.funprogramer.vocabularytrainer.CollectionExtra";


    final String displayName;
    String firstLanguage;
    String secondLanguage;
    String fileName;

    public Collection(String displayName, String firstLanguage, String secondLanguage) {
        this.displayName = displayName;
        this.firstLanguage = firstLanguage;
        this.secondLanguage = secondLanguage;
    }

    public abstract boolean isValidObject();

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

    public void setFileName(String sourceFileName) {
        this.fileName = sourceFileName;
    }

    public String getFileName() {
        return fileName;
    }
}
