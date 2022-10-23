package privat.funprogramer.vocabularytrainer.exceptions;

public class CouldNotDeleteException extends Exception {

    private final String displayName;

    public CouldNotDeleteException(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
