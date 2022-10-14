package privat.funprogramer.vocabularytrainer.persistance;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.google.gson.Gson;
import com.google.gson.stream.JsonReader;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.model.IrregularVerbCollection;
import privat.funprogramer.vocabularytrainer.model.VocabularyCollection;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class CollectionsManager {

    private static final String TAG = "CollectionsManager";

    private final File collectionsFolder;

    public CollectionsManager(String collectionsPath) {
        collectionsFolder = new File(collectionsPath);
    }

    public List<Collection> getCollections() {
        File[] files = collectionsFolder.listFiles();
        List<Collection> collections = new ArrayList<>();

        assert files != null;
        for (File file : files) {
            if (file.getName().endsWith(".voc.json")) {
                try {
                    collections.add(getVocabularyCollection(file.getName()));
                } catch (IOException e) {
                    Log.w(TAG, "Could not read file " + file, e);
                }
            }
            if (file.getName().endsWith(".irreg.verb.json")) {
                try {
                    collections.add(getIrregularVerbCollection(file.getName()));
                } catch (IOException e) {
                    Log.w(TAG, "Could not read file "+ file, e);
                }
            }
        }

        return collections;
    }

    @NonNull
    public VocabularyCollection getVocabularyCollection(String fileName) throws IOException {
        if (!fileName.endsWith(".voc.json")) throw new IllegalArgumentException("fileName should end with '.voc.json'");
        File file = new File(collectionsFolder + "/" + fileName);
        if (!file.exists()) {
            throw new FileNotFoundException();
        }
        VocabularyCollection collection = readVocabularyCollection(file);
        if (collection != null && collection.isValidObject()) {
            return collection;
        } else {
            throw new IOException("File " + file + " is empty or broken");
        }
    }

    @Nullable
    private VocabularyCollection readVocabularyCollection(File collectionFile) throws IOException {
        FileReader reader = new FileReader(collectionFile);
        JsonReader jsonReader = new JsonReader(reader);
        VocabularyCollection vocabularyCollection = new Gson().fromJson(jsonReader, VocabularyCollection.class);
        if (vocabularyCollection != null) {
            vocabularyCollection.setSourceFileName(collectionFile.getName());
        }
        return vocabularyCollection;
    }

    @NonNull
    public IrregularVerbCollection getIrregularVerbCollection(String fileName) throws IOException {
        if (!fileName.endsWith(".irreg.verb.json")) {
            throw new IllegalArgumentException("fileName should end with '.irreg.verb.json'");
        }
        File file = new File(collectionsFolder + "/" + fileName);
        if (!file.exists()) {
            throw new FileNotFoundException();
        }
        IrregularVerbCollection collection = readIrregularVerbCollection(file);
        if (collection != null && collection.isValidObject()) {
            return collection;
        } else {
            throw new IOException("File " + file + " is empty or broken");
        }
    }

    @Nullable
    private IrregularVerbCollection readIrregularVerbCollection(File collectionFile) throws IOException {
        FileReader reader = new FileReader(collectionFile);
        JsonReader jsonReader = new JsonReader(reader);
        IrregularVerbCollection vocabularyCollection = new Gson().fromJson(jsonReader, IrregularVerbCollection.class);
        if (vocabularyCollection != null) {
            vocabularyCollection.setSourceFileName(collectionFile.getName());
        }
        return vocabularyCollection;
    }

}
