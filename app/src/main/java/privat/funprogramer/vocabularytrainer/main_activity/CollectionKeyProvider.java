package privat.funprogramer.vocabularytrainer.main_activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.selection.ItemKeyProvider;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

import privat.funprogramer.vocabularytrainer.model.Collection;

public class CollectionKeyProvider extends ItemKeyProvider<String> {
    private final CollectionsAdapter collectionsAdapter;

    /**
     * Creates a new provider with the given scope and the collections list.
     *
     * @param scope Scope can't be changed at runtime.
     * @param collectionsAdapter that correspondences to this key provider
     */
    protected CollectionKeyProvider(int scope, CollectionsAdapter collectionsAdapter) {
        super(scope);
        this.collectionsAdapter = collectionsAdapter;
    }

    @Nullable
    @Override
    public String getKey(int position) {
        return collectionsAdapter.getCollections().get(position).getFileName();
    }

    @Override
    public int getPosition(@NonNull String key) {
        List<Collection> collections = collectionsAdapter.getCollections();
        for (int i = 0; i < collections.size(); i++) {
            if (collections.get(i).getFileName().equals(key)) {
                return i;
            }
        }
        return RecyclerView.NO_POSITION;
    }
}
