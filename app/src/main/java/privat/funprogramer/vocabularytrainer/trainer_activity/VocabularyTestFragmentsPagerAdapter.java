package privat.funprogramer.vocabularytrainer.trainer_activity;

import android.os.Bundle;
import android.os.Handler;
import android.os.ResultReceiver;
import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.viewpager2.adapter.FragmentStateAdapter;
import privat.funprogramer.vocabularytrainer.model.Vocabulary;
import privat.funprogramer.vocabularytrainer.Callback;

import java.util.List;

public class VocabularyTestFragmentsPagerAdapter extends FragmentStateAdapter implements TestPagerAdapter {

    private final List<Vocabulary> vocabularies;
    private final String firstLanguage;
    private final String secondLanguage;
    private int numberOfVisiblePages = 1;
    private Callback callback;

    public VocabularyTestFragmentsPagerAdapter(@NonNull FragmentActivity fragmentActivity, List<Vocabulary> vocabularies,
                                               String firstLanguage, String secondLanguage) {
        super(fragmentActivity);
        this.vocabularies = vocabularies;
        this.firstLanguage = firstLanguage;
        this.secondLanguage = secondLanguage;
    }

    @NonNull
    @Override
    public Fragment createFragment(int position) {
        return VocabularyTestFragment.newInstance(position, vocabularies.get(position), firstLanguage, secondLanguage,
                new CorrectAnswerResultReceiver(null));
    }

    @Override
    public int getItemCount() {
        return numberOfVisiblePages;
    }

    public void registerOnNumberOfPagesChanged(Callback callback) {
        this.callback = callback;
    }

    private class CorrectAnswerResultReceiver extends ResultReceiver {

        /**
         * Create a new ResultReceive to receive results.  Your
         * {@link #onReceiveResult} method will be called from the thread running
         * <var>handler</var> if given, or from an arbitrary thread if null.
         *
         */
        public CorrectAnswerResultReceiver(Handler handler) {
            super(handler);
        }

        @Override
        protected void onReceiveResult(int resultCode, Bundle resultData) {
            int senderIndex = resultData.getInt("index");
            if (numberOfVisiblePages == vocabularies.size() || senderIndex != numberOfVisiblePages - 1) return;
            numberOfVisiblePages++;
            callback.call();
        }
    }

}
