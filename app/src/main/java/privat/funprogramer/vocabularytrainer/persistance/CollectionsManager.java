package privat.funprogramer.vocabularytrainer.persistance;

import android.content.Context;
import android.net.Uri;
import android.util.Log;
import com.google.gson.Gson;
import privat.funprogramer.vocabularytrainer.exceptions.BrokenFileException;
import privat.funprogramer.vocabularytrainer.exceptions.CouldNotDeleteException;
import privat.funprogramer.vocabularytrainer.exceptions.ImportFailedException;
import privat.funprogramer.vocabularytrainer.exceptions.UnsupportedFileExtensionException;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.model.IrregularVerbCollection;
import privat.funprogramer.vocabularytrainer.model.VocabularyCollection;
import privat.funprogramer.vocabularytrainer.util.IOUtil;

import java.io.*;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

public class CollectionsManager {

    private static final String TAG = "CollectionsManager";

    private final File collectionsFolder;

    private final Context context;

    public CollectionsManager(File collectionsFolder, Context context) {
        this.collectionsFolder = collectionsFolder;
        this.context = context;
    }

    public void importCollection(Uri uri) throws ImportFailedException {
        String fileName = uri.getLastPathSegment();
        try (InputStream inputStream = context.getContentResolver().openInputStream(uri)) {
            String content = IOUtil.inputStreamToString(inputStream);
            parseAndCheckCollection(uri.getLastPathSegment(), content);
            File destinationFile = new File(collectionsFolder + "/" + fileName);
            IOUtil.stringToFileOutputStream(content, new FileOutputStream(destinationFile));
        } catch (IOException | UnsupportedFileExtensionException | BrokenFileException e) {
            throw new ImportFailedException(fileName, e);
        }
    }

    public void removeCollection(String fileName) throws FileNotFoundException, CouldNotDeleteException {
        File fileToDelete = new File(collectionsFolder + "/" + fileName);
        String displayName = fileName;
        try {
            Collection collection = getCollection(fileName);
            String displayNameTemp = collection.getDisplayName();
            if (displayNameTemp != null) {
                displayName = displayNameTemp;
            }
        } catch (UnsupportedFileExtensionException | BrokenFileException | IOException e) {
            e.printStackTrace();
        }
        if (fileToDelete.exists()) {
            if (!fileToDelete.delete()) {
                throw new CouldNotDeleteException(displayName);
            }
        } else {
            throw new FileNotFoundException();
        }
    }

    public List<Collection> getCollections() {
        File[] files = collectionsFolder.listFiles();
        List<Collection> collections = new ArrayList<>();

        assert files != null;
        for (File file : files) {
            try {
                collections.add(getCollection(file.getName()));
            } catch (IOException | UnsupportedFileExtensionException | BrokenFileException e) {
                Log.w(TAG, "An exception occurred while reading or checking the following file: "+ file, e);
            }
        }

        return collections;
    }

    public <T extends Collection> T getCollection(String fileName)
            throws IOException, UnsupportedFileExtensionException, BrokenFileException {
        File file = new File(collectionsFolder + "/" + fileName);
        if (!file.exists()) throw new FileNotFoundException();

        try (InputStream inputStream = Files.newInputStream(file.toPath())) {
            String content = IOUtil.inputStreamToString(inputStream);
            T collection = parseAndCheckCollection(fileName, content);
            collection.setSourceFileName(file.getName());
            return collection;
        }
    }

    private <T extends Collection> T parseAndCheckCollection(String fileName, String fileContent)
            throws IOException, UnsupportedFileExtensionException, BrokenFileException {
        Class<? extends Collection> type;
        if (fileName.endsWith(VocabularyCollection.FILE_EXTENSION)) {
            type = VocabularyCollection.class;
        } else if (fileName.endsWith(IrregularVerbCollection.FILE_EXTENSION)) {
            type = IrregularVerbCollection.class;
        } else {
            throw new UnsupportedFileExtensionException();
        }

        Collection collection = new Gson().fromJson(fileContent, type);
        if (collection == null || !collection.isValidObject()) {
            throw new BrokenFileException();
        }

        //noinspection unchecked
        return (T) collection;
    }

}
