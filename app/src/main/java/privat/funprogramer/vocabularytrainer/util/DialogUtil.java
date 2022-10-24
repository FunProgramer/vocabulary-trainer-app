package privat.funprogramer.vocabularytrainer.util;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;

import java.io.IOException;

import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.exceptions.BrokenFileException;
import privat.funprogramer.vocabularytrainer.exceptions.CouldNotDeleteException;
import privat.funprogramer.vocabularytrainer.exceptions.ImportFailedException;
import privat.funprogramer.vocabularytrainer.exceptions.OpenFailedException;
import privat.funprogramer.vocabularytrainer.exceptions.UnsupportedFileExtensionException;
import privat.funprogramer.vocabularytrainer.model.Collection;

public class DialogUtil {

    public static void showExceptionDialog(Context context, Exception e,
                                           OnClickListener okListener) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setIcon(android.R.drawable.ic_dialog_alert);

        Throwable cause = e.getCause();
        if (e instanceof ImportFailedException) {
            ImportFailedException ie = (ImportFailedException) e;
            builder.setTitle(
                    String.format(context.getString(R.string.import_failed_title), ie.getFileName())
            );
        } else if (e instanceof OpenFailedException) {
            builder.setTitle(R.string.open_failed_title);
        } else if (e instanceof CouldNotDeleteException) {
            CouldNotDeleteException de = (CouldNotDeleteException) e; 
            builder.setMessage(String.format(context.getString(R.string.could_not_delete_message),
                    de.getDisplayName()));
        } else {
            builder.setTitle(R.string.exception_title);
            String stackTrace = IOUtil.exceptionToStackTraceString(e);
            builder.setMessage(stackTrace);
            cause = null;
        }

        if (cause != null) {
            if (cause instanceof UnsupportedFileExtensionException) {
                builder.setMessage(R.string.file_extension_message);
            } else if (cause instanceof BrokenFileException) {
                builder.setMessage(R.string.broken_file_message);
            } else if (cause instanceof IOException) {
                String stackTrace = IOUtil.exceptionToStackTraceString(e);
                builder.setMessage(String.format(context.getString(R.string.io_exception_message),
                        stackTrace));
            }
        }

        builder.setPositiveButton(android.R.string.ok, okListener);
        builder.create().show();
    }

    public static void showSelectLanguageDirectionDialog(Context context, Collection collection,
                                                         OnClickListener itemSelectedListener) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);

        builder.setTitle(context.getString(R.string.select_language_direction))
                .setItems(collection.getLanguageDirections(), itemSelectedListener)
                .setNegativeButton(R.string.cancel, (dialogInterface, i) -> dialogInterface.cancel());

        AlertDialog alertDialog = builder.create();
        alertDialog.show();
    }

}
