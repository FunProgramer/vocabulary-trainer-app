package privat.funprogramer.vocabularytrainer.model;

import android.os.Parcel;
import android.os.Parcelable;

import java.util.List;

public class Vocabulary implements Parcelable {

    private List<String> firstLanguageMeanings;
    private List<String> secondLanguageMeanings;

    protected Vocabulary(Parcel in) {
        firstLanguageMeanings = in.createStringArrayList();
        secondLanguageMeanings = in.createStringArrayList();
    }

    public static final Creator<Vocabulary> CREATOR = new Creator<Vocabulary>() {
        @Override
        public Vocabulary createFromParcel(Parcel in) {
            return new Vocabulary(in);
        }

        @Override
        public Vocabulary[] newArray(int size) {
            return new Vocabulary[size];
        }
    };

    public List<String> getFirstLanguageMeanings() {
        return firstLanguageMeanings;
    }

    public List<String> getSecondLanguageMeanings() {
        return secondLanguageMeanings;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeStringList(firstLanguageMeanings);
        dest.writeStringList(secondLanguageMeanings);
    }

    protected void swapLanguages() {
        List<String> temp = firstLanguageMeanings;
        firstLanguageMeanings = secondLanguageMeanings;
        secondLanguageMeanings = temp;
    }
}
