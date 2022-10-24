package privat.funprogramer.vocabularytrainer.util;

import java.io.*;

public class IOUtil {

    public static String inputStreamToString(InputStream inputStream) throws IOException {
        ByteArrayOutputStream result = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int length;
        while ((length = inputStream.read(buffer)) != -1) {
            result.write(buffer, 0, length);
        }
        return result.toString("UTF-8");
    }

    public static void stringToFileOutputStream(String string, FileOutputStream outputStream) throws IOException {
        OutputStreamWriter osw = new OutputStreamWriter(outputStream);
        BufferedWriter bw = new BufferedWriter(osw);
        bw.write(string);
        bw.close();
    }

    public static String exceptionToStackTraceString(Exception e) {
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        return sw.toString();
    }

}
