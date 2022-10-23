package privat.funprogramer.vocabularytrainer.util;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;

import java.io.PrintWriter;
import java.io.StringWriter;

import privat.funprogramer.vocabularytrainer.R;
import privat.funprogramer.vocabularytrainer.exceptions.BrokenFileException;
import privat.funprogramer.vocabularytrainer.exceptions.CouldNotDeleteException;
import privat.funprogramer.vocabularytrainer.exceptions.ImportFailedException;
import privat.funprogramer.vocabularytrainer.exceptions.OpenFailedException;
import privat.funprogramer.vocabularytrainer.exceptions.UnsupportedFileExtensionException;

public class DialogUtil {

    public static void showExceptionDialog(Context context, Exception e, DialogInterface.OnClickListener okListener) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setIcon(android.R.drawable.ic_dialog_alert);

        Throwable cause = cause = e.getCause();;
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
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            e.printStackTrace(pw);
            String stackTrace = sw.toString();
            builder.setMessage(stackTrace);
            cause = null;
        }

        if (cause != null) {
            if (cause instanceof UnsupportedFileExtensionException) {
                builder.setMessage(R.string.file_extension_message);
            } else if (cause instanceof BrokenFileException) {
                builder.setMessage(R.string.broken_file_message);
            }
        }

        builder.setPositiveButton(android.R.string.ok, okListener);
        builder.create().show();
    }

}
