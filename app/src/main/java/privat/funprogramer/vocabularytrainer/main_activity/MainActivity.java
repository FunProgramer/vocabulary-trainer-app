package privat.funprogramer.vocabularytrainer.main_activity;

import android.app.Dialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts.OpenMultipleDocuments;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.exceptions.ImportFailedException;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.persistance.CollectionsManager;
import privat.funprogramer.vocabularytrainer.util.DialogUtil;

import java.util.List;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        SwipeRefreshLayout swipeRefreshLayout = findViewById(R.id.swipeRefreshLayout);

        Toolbar toolbar = findViewById(R.id.mainActivityToolbar);
        setSupportActionBar(toolbar);

        CollectionsManager collectionsManager = new CollectionsManager(getFilesDir(), this);
        List<Collection> vocabularyCollectionFiles = collectionsManager.getCollections();

        ActivityResultLauncher<String[]> openImportFile =
                registerForActivityResult(new OpenMultipleDocuments(), uris -> {
                    for (Uri uri : uris) {
                        try {
                            collectionsManager.importCollection(uri);
                        } catch (ImportFailedException e) {
                            DialogUtil.showExceptionDialog(this, e, null);
                        }
                    }
                });

        FloatingActionButton importFAB = findViewById(R.id.importFAB);
        importFAB.setOnClickListener(view -> openImportFile.launch(new String[]{"application/json"}));

        RecyclerView recyclerView = findViewById(R.id.vocabularyListView);
        recyclerView.setLayoutManager(new LinearLayoutManager(null));
        CollectionsAdapter adapter = new CollectionsAdapter(vocabularyCollectionFiles, this);
        recyclerView.setAdapter(adapter);

        swipeRefreshLayout.setRefreshing(false);
        swipeRefreshLayout.setOnRefreshListener(() -> {
            // Recreate Activity to get correct (not outdated) files
            startActivity(new Intent(this, getClass()));
            finish();
            overridePendingTransition(0, android.R.anim.fade_out);
        });
    }

}