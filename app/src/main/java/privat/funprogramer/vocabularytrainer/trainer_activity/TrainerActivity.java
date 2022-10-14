package privat.funprogramer.vocabularytrainer.trainer_activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.viewpager2.widget.ViewPager2;
import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.model.IrregularVerbCollection;
import privat.funprogramer.vocabularytrainer.model.LanguageDirection;
import privat.funprogramer.vocabularytrainer.model.VocabularyCollection;
import privat.funprogramer.vocabularytrainer.persistance.CollectionsManager;

import java.io.IOException;

public class TrainerActivity extends AppCompatActivity {

    public static final String TAG = "TrainerActivity";

    private ViewPager2 pager;
    private int numberVocabularies;
    private TextView progressInfoTextView;
    private ProgressBar progressBar;
    private Button nextButton;
    private Button backButton;
    private LinearLayout linearLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_trainer);

        pager = findViewById(R.id.pager);
        linearLayout = findViewById(R.id.linearLayout);
        progressInfoTextView = findViewById(R.id.progressInfoTextView);
        progressBar = findViewById(R.id.progressBar);
        backButton = findViewById(R.id.backButton);
        nextButton = findViewById(R.id.nextButton);

        Toolbar toolbar = findViewById(R.id.trainerActivityToolbar);
        setSupportActionBar(toolbar);

        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) actionBar.setDisplayHomeAsUpEnabled(true);

        Intent intent = getIntent();
        String fileName = intent.getStringExtra(Collection.COLLECTION_EXTRA);
        String collectionsPath = getResources().getString(R.string.vocabulary_collections_path);
        Collection collection = null;
        try {
            CollectionsManager collectionsManager = new CollectionsManager(collectionsPath);
            if (fileName.endsWith(".voc.json")) {
                collection = collectionsManager.getVocabularyCollection(fileName);
            } else if (fileName.endsWith(".irreg.verb.json")) {
                collection = collectionsManager.getIrregularVerbCollection(fileName);
            } else {
                throw new IllegalArgumentException("The trainer activity can not determine the type of " + fileName +
                        ". The file name needs to end with 'irreg.verb.json' or 'voc.json'");
            }
            if (actionBar != null) actionBar.setTitle(collection.getDisplayName());
        } catch (IOException e) {
            Log.v(TAG, "Error getting Collection with filename " + fileName, e);
        }

        assert collection != null;

        TestPagerAdapter pagerAdapter;
        if (collection instanceof VocabularyCollection) {
            int languageDirectionExtra = intent.getIntExtra(LanguageDirection.LANGUAGE_DIRECTION_EXTRA, 0);
            if (languageDirectionExtra == LanguageDirection.REVERSE.ordinal()) {
                ((VocabularyCollection) collection).swapLanguages();
            }
            numberVocabularies = ((VocabularyCollection) collection).getVocabularies().size();
            pagerAdapter = new VocabularyTestFragmentsPagerAdapter(
                    this, ((VocabularyCollection) collection).getVocabularies(),
                    collection.getFirstLanguage(),
                    collection.getSecondLanguage()
            );
            pager.setAdapter((VocabularyTestFragmentsPagerAdapter) pagerAdapter);
        } else {
            numberVocabularies = ((IrregularVerbCollection) collection).getIrregularVerbs().size();
            pagerAdapter = new IrregularVerbTestFragmentsPagerAdapter(
                    this, ((IrregularVerbCollection) collection).getIrregularVerbs(),
                    collection.getFirstLanguage(),
                    collection.getSecondLanguage()
            );
            pager.setAdapter((IrregularVerbTestFragmentsPagerAdapter) pagerAdapter);
        }
        setProgressInfo(0);

        backButton.setOnClickListener(v -> pager.setCurrentItem(pager.getCurrentItem() - 1));
        nextButton.setOnClickListener(v -> pager.setCurrentItem(pager.getCurrentItem() + 1));

        pagerAdapter.registerOnNumberOfPagesChanged(() -> {
            setProgressInfo(pagerAdapter.getItemCount() - 1);
            if (pager.getCurrentItem() < pagerAdapter.getItemCount() - 1) {
                nextButton.setVisibility(View.VISIBLE);
            } else {
                nextButton.setVisibility(View.INVISIBLE);
            }
            buttonVisibilityChangedHook();
        });

        pager.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
            @Override
            public void onPageSelected(int position) {
                if (pager.getCurrentItem() != 0) {
                    backButton.setVisibility(View.VISIBLE);
                } else {
                    backButton.setVisibility(View.INVISIBLE);
                }

                if (pager.getCurrentItem() < pagerAdapter.getItemCount() - 1) {
                    nextButton.setVisibility(View.VISIBLE);
                } else {
                    nextButton.setVisibility(View.INVISIBLE);
                }
                buttonVisibilityChangedHook();
            }
        });
    }

    private void buttonVisibilityChangedHook() {
        if (nextButton.getVisibility() != View.VISIBLE && backButton.getVisibility() != View.VISIBLE) {
            linearLayout.setVisibility(View.GONE);
        } else {
            linearLayout.setVisibility(View.VISIBLE);
        }
    }

    private void setProgressInfo(int vocabularyFraction) {
        progressInfoTextView.setText(String.format(
                String.valueOf(getResources().getText(R.string.progress_indication)),
                vocabularyFraction,
                numberVocabularies
        ));
        double progress = (double) vocabularyFraction / numberVocabularies;
        progressBar.setProgress((int) (progress * 100), true);
    }

    @Override
    public void onBackPressed() {
        if (pager.getCurrentItem() == 0) {
            super.onBackPressed();
        } else {
            pager.setCurrentItem(pager.getCurrentItem() - 1);
        }
    }
}