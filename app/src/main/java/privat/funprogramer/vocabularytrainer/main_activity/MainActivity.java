package privat.funprogramer.vocabularytrainer.main_activity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.Toast;

import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.OpenMultipleDocuments;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.selection.ItemKeyProvider;
import androidx.recyclerview.selection.MutableSelection;
import androidx.recyclerview.selection.SelectionPredicates;
import androidx.recyclerview.selection.SelectionTracker;
import androidx.recyclerview.selection.StorageStrategy;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.List;

import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.exceptions.CouldNotDeleteException;
import privat.funprogramer.vocabularytrainer.exceptions.ImportFailedException;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.persistance.CollectionsManager;
import privat.funprogramer.vocabularytrainer.util.DialogUtil;

public class MainActivity extends AppCompatActivity {

    private SelectionTracker<String> tracker;
    private CollectionsManager collectionsManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        SwipeRefreshLayout swipeRefreshLayout = findViewById(R.id.swipeRefreshLayout);

        Toolbar toolbar = findViewById(R.id.mainActivityToolbar);
        setSupportActionBar(toolbar);

        collectionsManager = new CollectionsManager(getFilesDir(), this);

        ActivityResultLauncher<String[]> openImportFile =
                registerForActivityResult(new OpenMultipleDocuments(), uris -> {
                    for (Uri uri : uris) {
                        try {
                            String importedFile = collectionsManager.importCollection(uri);
                            Toast.makeText(this,
                                    String.format("Successfully imported \"%s\"", importedFile),
                                    Toast.LENGTH_SHORT).show();
                        } catch (ImportFailedException e) {
                            DialogUtil.showExceptionDialog(this, e, null);
                        }
                    }
                    updateCollections();
                });

        FloatingActionButton importFAB = findViewById(R.id.importFAB);
        importFAB.setOnClickListener(view -> openImportFile.launch(new String[]{"application/json"}));

        List<Collection> collections = collectionsManager.getCollections();
        RecyclerView recyclerView = findViewById(R.id.vocabularyListView);
        recyclerView.setLayoutManager(new LinearLayoutManager(null));
        CollectionsAdapter adapter = new CollectionsAdapter(collections, this);
        recyclerView.setAdapter(adapter);

        tracker = new SelectionTracker.Builder<>(
                CollectionsAdapter.SELECTION_ID,
                recyclerView,
                new CollectionKeyProvider(ItemKeyProvider.SCOPE_MAPPED, adapter),
                new CollectionDetailsLookup(recyclerView),
                StorageStrategy.createStringStorage()
        ).withSelectionPredicate(
                SelectionPredicates.createSelectAnything()
        ).build();
        adapter.setTracker(tracker);

        tracker.addObserver(new SelectionTracker.SelectionObserver<String>(){
            @Override
            public void onSelectionChanged() {
                if (tracker.hasSelection()) {
                    toolbar.setTitle(String.format(
                            getString(R.string.selection), tracker.getSelection().size()
                    ));
                    invalidateOptionsMenu();
                    toolbar.setNavigationIcon(R.drawable.ic_baseline_close_24);
                    toolbar.setBackgroundResource(R.color.green_100);
                    toolbar.setTitleTextColor(ContextCompat.getColor(MainActivity.this, R.color.black));
                    toolbar.setNavigationOnClickListener(view -> tracker.clearSelection());
                } else {
                    toolbar.setTitle(R.string.app_name);
                    invalidateOptionsMenu();
                    toolbar.setNavigationIcon(null);
                    toolbar.setBackgroundResource(R.color.green_500);
                    toolbar.setTitleTextColor(ContextCompat.getColor(MainActivity.this, R.color.white));
                }
            }
        });


        swipeRefreshLayout.setRefreshing(false);
        swipeRefreshLayout.setOnRefreshListener(this::updateCollections);
    }

    @Override
    public boolean onPrepareOptionsMenu(Menu menu) {
        // Use this if statement instead of return value of this method.
        // See: comment at return value
        if (tracker.hasSelection()) {
            MenuInflater inflater = getMenuInflater();
            inflater.inflate(R.menu.deletion_menu, menu);
        }
        // androidx.activity.ComponentActivity seems to ignore this return value (l. 497)
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.action_delete) {
            MutableSelection<String> selection = new MutableSelection<>();
            tracker.copySelection(selection);
            DialogUtil.showDeleteConfirmationDialog(this, selection.size(),
                    (dialog, which) -> {
                        selection.forEach(s -> {
                            try {
                                collectionsManager.removeCollection(s);
                            } catch (CouldNotDeleteException e) {
                                DialogUtil.showExceptionDialog(this, e, null);
                            }
                        });
                        updateCollections();
                    });
        }
        return super.onOptionsItemSelected(item);
    }

    public void updateCollections() {
        // Recreate Activity to get correct (not outdated) files
        startActivity(new Intent(this, getClass()));
        finish();
        overridePendingTransition(0, android.R.anim.fade_out);
    }
}