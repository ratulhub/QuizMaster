package quiz.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

/**
 * Clean FileParser utility to keep UploadServlet simple.
 */
public class FileParser {

    public static String parseTxt(InputStream is) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line).append("\n");
            }
        }
        return sb.toString();
    }

    public static String parsePdf(InputStream is) {
        try (PDDocument document = PDDocument.load(is)) {
            PDFTextStripper stripper = new PDFTextStripper();
            return stripper.getText(document);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    /**
     * Zero-dependency DOCX parser using ZipInputStream.
     */
    public static String parseDocx(InputStream is) {
        StringBuilder sb = new StringBuilder();
        try (ZipInputStream zis = new ZipInputStream(is)) {
            ZipEntry entry;
            while ((entry = zis.getNextEntry()) != null) {
                if (entry.getName().equals("word/document.xml")) {
                    BufferedReader reader = new BufferedReader(new InputStreamReader(zis));
                    String line;
                    while ((line = reader.readLine()) != null) {
                        // Strip XML tags
                        String textOnly = line.replaceAll("<[^>]+>", " ");
                        sb.append(textOnly).append("\n");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sb.toString().replaceAll(" +", " ");
    }
}
