package privat.funprogramer.vocabularytrainer.trainer_activity;

import android.graphics.Color;
import android.os.Bundle;
import android.os.ResultReceiver;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import com.google.android.material.card.MaterialCardView;
import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.model.IrregularVerb;

import java.util.List;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link IrregularVerbTestFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class IrregularVerbTestFragment extends Fragment {

    private static final String ARG_INDEX = "IRREGULAR_VERB_INDEX";
    private static final String ARG_IRREGULAR_VERB = "TEST_IRREGULAR_VERB";
    private static final String ARG_FIRST_LANGUAGE = "FIRST_LANGUAGE";
    private static final String ARG_SECOND_LANGUAGE = "SECOND_LANGUAGE";
    public static final String ARG_RESULT_RECEIVER = "RESULT_RECEIVER";

    private int index;
    private IrregularVerb irregularVerb;
    private String firstLanguage;
    private String secondLanguage;
    private ResultReceiver resultReceiver;

    public IrregularVerbTestFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param index The index of the Vocabulary to test in the VocabularyCollection
     * @param verb The irregular verb that this Fragment should test.
     * @param firstLanguage The first language for the vocabulary
     * @param secondLanguage The second language for the vocabulary
     * @param resultReceiver receives a 'result' when this fragment detects that the users answer is correct
     * @return A new instance of fragment VocabularyTestFragment.
     */
    public static IrregularVerbTestFragment newInstance(int index, IrregularVerb verb, String firstLanguage,
                                                        String secondLanguage, ResultReceiver resultReceiver) {
        IrregularVerbTestFragment fragment = new IrregularVerbTestFragment();
        Bundle args = new Bundle();
        args.putInt(ARG_INDEX, index);
        args.putParcelable(ARG_IRREGULAR_VERB, verb);
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
            irregularVerb = getArguments().getParcelable(ARG_IRREGULAR_VERB);
            firstLanguage = getArguments().getString(ARG_FIRST_LANGUAGE);
            secondLanguage = getArguments().getString(ARG_SECOND_LANGUAGE);
            resultReceiver = getArguments().getParcelable(ARG_RESULT_RECEIVER);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_irregular_verbs_test, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        TextView firstLanguageTextView = view.findViewById(R.id.firstLanguageTextView);
        firstLanguageTextView.setText(firstLanguage);
        TextView languageMeaningTextView = view.findViewById(R.id.firstLanguageMeaningTextView);
        languageMeaningTextView.setText(irregularVerb.getFirstLanguageMeanings().get(0));

        TextView secondLanguageInfinitiveTextView = view.findViewById(R.id.secondLanguageInfinitiveTextView);
        secondLanguageInfinitiveTextView.setText(
                String.format(getString(R.string.language_name_infinitive), secondLanguage)
        );
        EditText secondLanguageInfinitiveMeaningTextEdit =
                view.findViewById(R.id.secondLanguageInfinitiveMeaningTextEdit);
        secondLanguageInfinitiveMeaningTextEdit.setHint(
                String.format(getResources().getString(R.string.answer_hint),
                        String.format(getString(R.string.language_name_infinitive), secondLanguage)
                )
        );

        TextView secondLanguageSimplePastTextView = view.findViewById(R.id.secondLanguageSimplePastTextView);
        secondLanguageSimplePastTextView.setText(
                String.format(getString(R.string.language_name_simple_past), secondLanguage)
        );
        EditText secondLanguageSimplePastMeaningTextEdit =
                view.findViewById(R.id.secondLanguageSimplePastMeaningTextEdit);
        secondLanguageSimplePastMeaningTextEdit.setHint(
                String.format(getResources().getString(R.string.answer_hint),
                        String.format(getString(R.string.language_name_simple_past), secondLanguage)
                )
        );

        TextView secondLanguagePastParticipleTextView = view.findViewById(R.id.secondLanguagePastParticipleTextView);
        secondLanguagePastParticipleTextView.setText(
                String.format(getString(R.string.language_name_past_participle), secondLanguage)
        );
        EditText secondLanguagePastParticipleMeaningTextEdit =
                view.findViewById(R.id.secondLanguagePastParticipleMeaningTextEdit);
        secondLanguagePastParticipleMeaningTextEdit.setHint(
                String.format(getResources().getString(R.string.answer_hint),
                        String.format(getString(R.string.language_name_past_participle), secondLanguage)
                )
        );

        MaterialCardView resultCard = view.findViewById(R.id.resultCard);
        TextView resultTitleTextView = view.findViewById(R.id.resultTitleTextView);
        TextView resultDescriptionTextView = view.findViewById(R.id.resultDescriptionTextView);

        Button checkAnswerButton = view.findViewById(R.id.checkAnswersButton);
        checkAnswerButton.setOnClickListener(v -> {
            EditText[] answerEditTexts = new EditText[]{secondLanguageInfinitiveMeaningTextEdit,
                    secondLanguageSimplePastMeaningTextEdit, secondLanguagePastParticipleMeaningTextEdit};
            //noinspection unchecked
            List<String>[] secondLanguageMeaningsLists = (List<String>[]) new List<?>[]{
                    irregularVerb.getSecondLanguageInfinitiveMeanings(),
                    irregularVerb.getSecondLanguageSimplePastMeanings(),
                    irregularVerb.getSecondLanguagePastParticipleMeanings()
            };
            boolean allAnswersCorrect = true;
            for (int i = 0; i < answerEditTexts.length; i++) {
                EditText editText = answerEditTexts[i];
                String text = editText.getText().toString();
                List<String> secondLanguageMeanings = secondLanguageMeaningsLists[i];
                if (!secondLanguageMeanings.contains(text)) {
                    editText.setError(String.format(
                            getResources().getString(R.string.correct_answer),
                            secondLanguageMeanings.get(0)
                    ));
                    allAnswersCorrect = false;
                }
            }

            resultCard.setVisibility(View.VISIBLE);
            if (allAnswersCorrect) {
                resultCard.setCardBackgroundColor(Color.GREEN);
                resultTitleTextView.setText(R.string.correct_answers_info);
                resultDescriptionTextView.setText(R.string.click_next_info);
                Bundle data = new Bundle();
                data.putInt("index", index);
                resultReceiver.send(0, data);
            } else {
                resultCard.setCardBackgroundColor(Color.RED);
                resultTitleTextView.setText(R.string.wrong_answers_info);
                resultDescriptionTextView.setText(R.string.error_hints_above_info);
            }
        });
    }

}