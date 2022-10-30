package privat.funprogramer.vocabularytrainer.trainer_activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ProgressBar;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.viewpager2.widget.ViewPager2;

import java.io.IOException;

import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.exceptions.BrokenFileException;
import privat.funprogramer.vocabularytrainer.exceptions.OpenFailedException;
import privat.funprogramer.vocabularytrainer.exceptions.UnsupportedFileExtensionException;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.model.IrregularVerbCollection;
import privat.funprogramer.vocabularytrainer.model.LanguageDirection;
import privat.funprogramer.vocabularytrainer.model.VocabularyCollection;
import privat.funprogramer.vocabularytrainer.persistance.CollectionsManager;
import privat.funprogramer.vocabularytrainer.util.DialogUtil;

public class TrainerActivity extends AppCompatActivity {

    public static final String TAG = "TrainerActivity";

    public static final String NUMBER_OF_VISIBLE_PAGES = "numberOfVisiblePages";

    private ViewPager2 pager;
    private int numberVocabularies;
    private TextView progressInfoTextView;
    private ProgressBar progressBar;
    private Button nextButton;
    private Button backButton;
    private LinearLayout linearLayout;
    private TestPagerAdapter pagerAdapter;

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
        Collection collection = null;
        try {
            CollectionsManager collectionsManager = new CollectionsManager(getFilesDir(), this);
            collection = collectionsManager.getCollection(fileName);
        } catch (IOException e) {
            Log.v(TAG, "Error getting Collection with filename " + fileName, e);
        } catch (UnsupportedFileExtensionException | BrokenFileException e) {
            DialogUtil.showExceptionDialog(this, new OpenFailedException(e),
                    (dialog, which) -> TrainerActivity.this.finish());
        }


        assert collection != null;
        if (actionBar != null) actionBar.setTitle(collection.getDisplayName());

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
                if (position != 0) {
                    backButton.setVisibility(View.VISIBLE);
                } else {
                    backButton.setVisibility(View.INVISIBLE);
                }

                if (position < pagerAdapter.getItemCount() - 1) {
                    nextButton.setVisibility(View.VISIBLE);
                } else {
                    nextButton.setVisibility(View.INVISIBLE);
                }
                buttonVisibilityChangedHook();
            }
        });

        if (savedInstanceState != null) {
            pagerAdapter
                    .setNumberOfVisiblePages(savedInstanceState.getInt(NUMBER_OF_VISIBLE_PAGES));
        }
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
                "%s/%s",
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

    @Override
    protected void onSaveInstanceState(@NonNull Bundle outState) {
        outState.putInt(NUMBER_OF_VISIBLE_PAGES, pagerAdapter.getNumberOfVisiblePages());
        super.onSaveInstanceState(outState);
    }
}