package privat.funprogramer.vocabularytrainer.main_activity;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.widget.Toast;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;
import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.persistance.CollectionsManager;

import java.io.File;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        SwipeRefreshLayout swipeRefreshLayout = findViewById(R.id.swipeRefreshLayout);

        Toolbar toolbar = findViewById(R.id.mainActivityToolbar);
        setSupportActionBar(toolbar);

        // Request All files permission if needed
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager()) {
                Toast toast = new Toast(getBaseContext());
                toast.setText("Vocabulary Trainer needs the permission to access all files.");
                toast.show();
                Intent settingsIntent = new Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION);
                settingsIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                startActivity(settingsIntent);
            }
        }
        swipeRefreshLayout.setRefreshing(true);

        // Create directory if not it exists
        File vocabularyCollectionsFolder = new File(getResources().getString(R.string.vocabulary_collections_path));
        if (!vocabularyCollectionsFolder.exists()) {
            if (!vocabularyCollectionsFolder.mkdir()) {
               Toast toast = new Toast(getBaseContext());
               toast.setText("Vocabulary Trainer Directory could not be created.");
               toast.show();
               finish();
           }
        }

        CollectionsManager collectionsManager =
                new CollectionsManager(vocabularyCollectionsFolder.getPath());
        List<Collection> vocabularyCollectionFiles = collectionsManager.getCollections();

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