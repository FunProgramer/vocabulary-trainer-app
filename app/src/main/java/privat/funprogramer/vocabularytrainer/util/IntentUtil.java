package privat.funprogramer.vocabularytrainer.util;

import android.content.Context;
import android.content.Intent;

import privat.funprogramer.vocabularytrainer.model.Collection;
import privat.funprogramer.vocabularytrainer.trainer_activity.TrainerActivity;

public class IntentUtil {

    public static Intent createTrainerActivityIntent(Context context, String collectionFileName) {
        Intent trainerActivityIntent = new Intent(context, TrainerActivity.class);
        trainerActivityIntent.putExtra(Collection.COLLECTION_EXTRA, collectionFileName);
        return trainerActivityIntent;
    }

}
