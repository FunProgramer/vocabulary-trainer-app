package privat.funprogramer.vocabularytrainer.trainer_activity;

import android.graphics.Color;
import android.os.Bundle;
import android.os.ResultReceiver;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import com.google.android.material.card.MaterialCardView;
import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.model.Vocabulary;

import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link VocabularyTestFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class VocabularyTestFragment extends Fragment {

    private static final String ARG_INDEX = "VOCABULARY_INDEX";
    private static final String ARG_VOCABULARY = "TEST_VOCABULARY";
    private static final String ARG_FIRST_LANGUAGE = "FIRST_LANGUAGE";
    private static final String ARG_SECOND_LANGUAGE = "SECOND_LANGUAGE";
    public static final String ARG_RESULT_RECEIVER = "RESULT_RECEIVER";

    private int index;
    private Vocabulary vocabulary;
    private String firstLanguage;
    private String secondLanguage;
    private ResultReceiver resultReceiver;

    public VocabularyTestFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param index The index of the Vocabulary to test in the VocabularyCollection
     * @param vocabulary The vocabulary that this Fragment should test.
     * @param firstLanguage The first language for the vocabulary
     * @param secondLanguage The second language for the vocabulary
     * @param resultReceiver receives a 'result' when this fragment detects that the users answer is correct
     * @return A new instance of fragment VocabularyTestFragment.
     */
    public static VocabularyTestFragment newInstance(int index, Vocabulary vocabulary, String firstLanguage,
                                                     String secondLanguage, ResultReceiver resultReceiver) {
        VocabularyTestFragment fragment = new VocabularyTestFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_INDEX, index);
        args.putParcelable(ARG_VOCABULARY, vocabulary);
        args.putString(ARG_FIRST_LANGUAGE, firstLanguage);
        args.putString(ARG_SECOND_LANGUAGE, secondLanguage);
        args.putParcelable(ARG_RESULT_RECEIVER, resultReceiver);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            index = getArguments().getInt(ARG_INDEX);
            vocabulary = getArguments().getParcelable(ARG_VOCABULARY);
            firstLanguage = getArguments().getString(ARG_FIRST_LANGUAGE);
            secondLanguage = getArguments().getString(ARG_SECOND_LANGUAGE);
            resultReceiver = getArguments().getParcelable(ARG_RESULT_RECEIVER);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_vocabulary_test, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        TextView languageTextView1 = view.findViewById(R.id.firstLanguageTextView);
        languageTextView1.setText(firstLanguage);
        TextView languageMeaningTextView = view.findViewById(R.id.firstLanguageMeaningTextView);
        languageMeaningTextView.setText(vocabulary.getFirstLanguageMeanings().get(0));

        TextView languageTextView2 = view.findViewById(R.id.secondLanguageInfinitiveTextView);
        languageTextView2.setText(secondLanguage);
        EditText languageMeaningTextEdit = view.findViewById(R.id.secondLanguageInfinitiveMeaningTextEdit);
        languageMeaningTextEdit.setHint(String.format(getResources().getString(R.string.answer_hint), secondLanguage));

        MaterialCardView resultCard = view.findViewById(R.id.resultCard);
        TextView resultTitleTextView = view.findViewById(R.id.resultTitleTextView);
        TextView resultDescriptionTextView = view.findViewById(R.id.resultDescriptionTextView);

        Button checkAnswerButton = view.findViewById(R.id.checkAnswersButton);
        checkAnswerButton.setOnClickListener(v -> {
            String text = languageMeaningTextEdit.getText().toString();
            Bundle data = new Bundle();
            data.putInt("index", index);
            if (text.equals(vocabulary.getSecondLanguageMeanings().get(0))) {
                resultCard.setVisibility(View.VISIBLE);
                resultCard.setCardBackgroundColor(Color.GREEN);
                resultTitleTextView.setText(R.string.correct_answer_info);
                resultDescriptionTextView.setText(R.string.click_next_info);
                resultReceiver.send(0, data);
            } else if (vocabulary.getSecondLanguageMeanings().contains(text)) {
                resultCard.setVisibility(View.VISIBLE);
                resultCard.setCardBackgroundColor(Color.GREEN);
                resultTitleTextView.setText(R.string.correct_answer_info);
                resultDescriptionTextView.setText(String.format(
                        getResources().getString(R.string.other_correct_answer_click_next_info),
                        buildCorrectAnswersString(vocabulary.getSecondLanguageMeanings().indexOf(text))
                ));
                resultReceiver.send(0, data);
            } else {
                resultCard.setVisibility(View.VISIBLE);
                resultCard.setCardBackgroundColor(Color.RED);
                resultTitleTextView.setText(R.string.wrong_answer_info);
                resultDescriptionTextView.setText(String.format(
                        getResources().getString(R.string.correct_answers),
                        vocabulary.getSecondLanguageMeanings().get(0) + "\n"
                ));
            }
        });
    }

    @Override
    public void onResume() {
        View view = getView();
        if (view != null) {
            EditText answerET = view.findViewById(R.id.secondLanguageInfinitiveMeaningTextEdit);
            answerET.requestFocus();
        }
        super.onResume();
    }

    private String buildCorrectAnswersString(int exclude) {
        StringBuilder correctAnswersStringBuilder = new StringBuilder();
        List<String> secondLanguageMeanings = vocabulary.getSecondLanguageMeanings();
        for (int i = 0; i < secondLanguageMeanings.size(); i++) {
            if (i == 0) continue;
            if (i == exclude) continue;
            correctAnswersStringBuilder.append(secondLanguageMeanings.get(i)).append("\n");
        }
        return correctAnswersStringBuilder.toString();
    }
}