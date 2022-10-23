package privat.funprogramer.vocabularytrainer.model;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.List;

public class IrregularVerb implements Parcelable {

    private final List<String> firstLanguageMeanings;
    private final List<String> secondLanguageInfinitiveMeanings;
    private final List<String> secondLanguageSimplePastMeanings;
    private final List<String> secondLanguagePastParticipleMeanings;

    protected IrregularVerb(Parcel in) {
        firstLanguageMeanings = in.createStringArrayList();
        secondLanguageInfinitiveMeanings = in.createStringArrayList();
        secondLanguageSimplePastMeanings = in.createStringArrayList();
        secondLanguagePastParticipleMeanings = in.createStringArrayList();
    }

    public static final Creator<IrregularVerb> CREATOR = new Creator<IrregularVerb>() {
        @Override
        public IrregularVerb createFromParcel(Parcel source) {
            return new IrregularVerb(source);
        }

        @Override
        public IrregularVerb[] newArray(int size) {
            return new IrregularVerb[size];
        }
    };

    public List<String> getFirstLanguageMeanings() {
        return firstLanguageMeanings;
    }

    public List<String> getSecondLanguageInfinitiveMeanings() {
        return secondLanguageInfinitiveMeanings;
    }

    public List<String> getSecondLanguageSimplePastMeanings() {
        return secondLanguageSimplePastMeanings;
    }

    public List<String> getSecondLanguagePastParticipleMeanings() {
        return secondLanguagePastParticipleMeanings;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeStringList(firstLanguageMeanings);
        dest.writeStringList(secondLanguageInfinitiveMeanings);
        dest.writeStringList(secondLanguageSimplePastMeanings);
        dest.writeStringList(secondLanguagePastParticipleMeanings);
    }

    @Override
    public int describeContents() {
        return 0;
    }
}
