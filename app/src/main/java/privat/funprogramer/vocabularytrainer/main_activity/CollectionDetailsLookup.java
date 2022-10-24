package privat.funprogramer.vocabularytrainer.main_activity;

import android.view.MotionEvent;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.selection.ItemDetailsLookup;
import androidx.recyclerview.widget.RecyclerView;

public class CollectionDetailsLookup extends ItemDetailsLookup<String> {

    private final RecyclerView recyclerView;

    public CollectionDetailsLookup(RecyclerView recyclerView) {
        this.recyclerView = recyclerView;
    }

    @Nullable
    @Override
    public ItemDetails getItemDetails(@NonNull MotionEvent e) {
        View view = recyclerView.findChildViewUnder(e.getX(), e.getY());
        if (view != null) {
            return ((CollectionsAdapter.CollectionEntry) recyclerView.getChildViewHolder(view)).getItemDetails();
        }
        return null;
    }

}
