package privat.funprogramer.vocabularytrainer.main_activity;

import android.app.AlertDialog;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.model.LanguageDirection;
import privat.funprogramer.vocabularytrainer.model.VocabularyCollection;
import privat.funprogramer.vocabularytrainer.trainer_activity.TrainerActivity;

import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;

public class CollectionsAdapter extends
        RecyclerView.Adapter<CollectionsAdapter.CollectionEntry> {

    private List<Collection> collections;
    private final Context context;

    public static class CollectionEntry extends RecyclerView.ViewHolder {
        private final TextView textView;
        private final TextView langaugesTextView;
        private Collection collection;

        public CollectionEntry(@NonNull View itemView, Context context) {
            super(itemView);
            // Define click listener for itemView
            itemView.setOnClickListener(v -> {
                if (collection instanceof VocabularyCollection) {
                    AlertDialog.Builder builder = new AlertDialog.Builder(context);

                    builder.setTitle(context.getString(R.string.select_language_direction))
                            .setItems(collection.getLanguageDirections(), (dialogInterface, i) -> {
                                Intent trainerActivityIntent = new Intent(context, TrainerActivity.class);
                                trainerActivityIntent.putExtra(Collection.COLLECTION_EXTRA, collection.getSourceFileName());
                                trainerActivityIntent.putExtra(LanguageDirection.LANGUAGE_DIRECTION_EXTRA, i);
                                context.startActivity(trainerActivityIntent);
                                dialogInterface.dismiss();
                            }).setNegativeButton(R.string.cancel, (dialogInterface, i) -> {
                                dialogInterface.cancel();
                            });

                    AlertDialog alertDialog = builder.create();
                    alertDialog.show();
                } else {
                    Intent trainerActivityIntent = new Intent(context, TrainerActivity.class);
                    trainerActivityIntent.putExtra(Collection.COLLECTION_EXTRA, collection.getSourceFileName());
                    context.startActivity(trainerActivityIntent);
                }
            });

            textView = itemView.findViewById(R.id.vocabularyCollectionTextView);
            langaugesTextView = itemView.findViewById(R.id.vocabularyCollectionLanguagesTextView);
        }

        public TextView getTextView() {
            return textView;
        }

        public TextView getLangaugesTextView() {
            return langaugesTextView;
        }

        public void setCollection(Collection collection) {
            this.collection = collection;
        }
    }

    public CollectionsAdapter(List<Collection> collections, Context context) {
        this.collections = collections;
        this.context = context;
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
        Collection collection = collections.get(position);
        entry.getTextView().setText(collection.getDisplayName());
        String languageSpecification = String.format(
                context.getString(R.string.vocabulary_collection_language_specification),
                collection.getFirstLanguage(), collection.getSecondLanguage()
        );
        entry.getLangaugesTextView().setText(languageSpecification);
        entry.setCollection(collections.get(position));
    }

    @Override
    public int getItemCount() {
        return collections.size();
    }

    public void setCollections(List<Collection> collections) {
        this.collections = collections;
    }

}
