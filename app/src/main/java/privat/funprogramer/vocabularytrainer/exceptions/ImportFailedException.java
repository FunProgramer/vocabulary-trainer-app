package privat.funprogramer.vocabularytrainer.exceptions;

import java.io.File;

public class ImportFailedException extends Exception {

    private final String fileName;

    public ImportFailedException(String fileName, Throwable cause) {
        super(cause);
        this.fileName = fileName;
    }

    public String getFileName() {
        return fileName;
    }
}
