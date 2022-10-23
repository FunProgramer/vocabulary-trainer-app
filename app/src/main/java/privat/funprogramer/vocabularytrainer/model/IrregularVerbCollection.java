package privat.funprogramer.vocabularytrainer.model;

import java.util.List;

public class IrregularVerbCollection extends Collection {

    public static final String FILE_EXTENSION = ".irreg.verb.json";

    private final List<IrregularVerb> irregularVerbs;

    public IrregularVerbCollection(String displayName, String firstLanguage,
                                String secondLanguage, List<IrregularVerb> irregularVerbs) {
        super(displayName, firstLanguage, secondLanguage);
        this.irregularVerbs = irregularVerbs;
    }

    public boolean isValidObject() {
        return displayName != null && firstLanguage != null && secondLanguage != null && irregularVerbs != null;
    }

    public List<IrregularVerb> getIrregularVerbs() {
        return irregularVerbs;
    }

}
