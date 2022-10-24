package privat.funprogramer.vocabularytrainer.main_activity;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.selection.ItemDetailsLookup;
import androidx.recyclerview.selection.ItemKeyProvider;
import androidx.recyclerview.selection.SelectionTracker;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.model.LanguageDirection;
import privat.funprogramer.vocabularytrainer.model.VocabularyCollection;
import privat.funprogramer.vocabularytrainer.util.DialogUtil;
import privat.funprogramer.vocabularytrainer.util.IntentUtil;

public class CollectionsAdapter extends
        RecyclerView.Adapter<CollectionsAdapter.CollectionEntry> {

    public static final String SELECTION_ID = "privat.funprogramer.vocabularytrainer.CollectionSelection";

    private final List<Collection> collections;
    private final Context context;
    private SelectionTracker<String> tracker = null;

    public static class CollectionEntry extends RecyclerView.ViewHolder {
        private final TextView displayNameTV = itemView.findViewById(R.id.displayNameTextView);
        private final TextView languagesTV = itemView.findViewById(R.id.languagesTextView);
        private final Context context;
        private String collectionFileName;

        public CollectionEntry(@NonNull View itemView, Context context) {
            super(itemView);
            this.context = context;
        }

        public void bind(Collection collection, boolean isActivated) {
            collectionFileName = collection.getFileName();
            displayNameTV.setText(collection.getDisplayName());
            String languageSpecification = String.format(
                    context.getString(R.string.vocabulary_collection_language_specification),
                    collection.getFirstLanguage(), collection.getSecondLanguage()
            );
            languagesTV.setText(languageSpecification);

            itemView.setActivated(isActivated);

            // Define click listener for itemView
            itemView.setOnClickListener(v -> {
                if (collection instanceof VocabularyCollection) {
                    DialogUtil.showSelectLanguageDirectionDialog(context, collection,
                    (dialogInterface, i) -> {
                        Intent intent = IntentUtil
                                .createTrainerActivityIntent(context, collection.getFileName());
                        intent.putExtra(LanguageDirection.LANGUAGE_DIRECTION_EXTRA, i);
                        context.startActivity(intent);
                        dialogInterface.dismiss();
                    });
                } else {
                    context.startActivity(
                            IntentUtil
                                    .createTrainerActivityIntent(context, collection.getFileName())
                    );
                }
            });
        }

        public ItemDetailsLookup.ItemDetails<String> getItemDetails() {
            return new ItemDetailsLookup.ItemDetails<String>() {
                @Override
                public int getPosition() {
                    return getAdapterPosition();
                }

                @Nullable
                @Override
                public String getSelectionKey() {
                    return collectionFileName;
                }
            };
        }
    }

    public CollectionsAdapter(List<Collection> collections, Context context) {
        this.collections = collections;
        this.context = context;
    }

    public void setTracker(SelectionTracker<String> tracker) {
        this.tracker = tracker;
    }

    @NonNull
    @Override
    public CollectionEntry onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.vocabulary_collections_list_entry, parent, false);

        return new CollectionEntry(view, context);
    }

    @Override
    public void onBindViewHolder(@NonNull CollectionEntry entry, int position) {
        if (tracker != null) {
            Collection collection = collections.get(position);
            entry.bind(collection, tracker.isSelected(collection.getFileName()));
        }
    }

    @Override
    public int getItemCount() {
        return collections.size();
    }

}
