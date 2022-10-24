package privat.funprogramer.vocabularytrainer.main_activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.selection.ItemKeyProvider;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

import privat.funprogramer.vocabularytrainer.model.Collection;

public class CollectionKeyProvider extends ItemKeyProvider<String> {
    private final List<Collection> collections;

    /**
     * Creates a new provider with the given scope and the collections list.
     *
     * @param scope Scope can't be changed at runtime.
     * @param collections the collections list used to determine position of a key (file name)
     */
    protected CollectionKeyProvider(int scope, List<Collection> collections) {
        super(scope);

        this.collections = collections;
    }

    @Nullable
    @Override
    public String getKey(int position) {
        return collections.get(position).getFileName();
    }

    @Override
    public int getPosition(@NonNull String key) {
        for (int i = 0; i < collections.size(); i++) {
            if (collections.get(i).getFileName().equals(key)) {
                return i;
            }
        }
        return RecyclerView.NO_POSITION;
    }
}
