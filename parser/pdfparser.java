import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;

import org.apache.tika.metadata.Metadata;
import org.apache.tika.sax.BodyContentHandler;
import org.apache.tika.parser.ParseContext;
import org.apache.tika.parser.pdf.PDFParser;
import org.xml.sax.ContentHandler;

/**
 *	To compile from within parser folder: javac -classpath :tika-app-1.3.jar  pdfparser.java
 *	To run: java -cp :/RAILS_ROOT_FOLDER/parser/tika-app-1.3.jar:/RAILS_ROOT_FOLDER/parser pdfparser <pdf filepath>
 */


public class pdfparser {
	// Disables limit for pdf file size
	private static final int WRITE_LIMIT = -1;
	// Printed preceding any exception to identify script failed
	private static String EXCEPTION_IDENTIFIER;

	/**
	 * Script to parse a single pdf file
	 * @param args - File name followed by an identifier printed when an exception occurs
	 */
	public static void main(String[] args) {
		if (args.length < 2) {
			System.out.println("Need a file to parse followed by exception identifier");
			return;
		}
		EXCEPTION_IDENTIFIER = args[1];
		InputStream input = null;
		ContentHandler textHandler = null;
		try {
			File file = new File(args[0]);
			if (!file.isFile()) throw new Exception("Given file name is invalid");
			if (!isPDF(file)) throw new Exception("File type must be a pdf");
			input = new FileInputStream(file);
			textHandler = new BodyContentHandler(WRITE_LIMIT);
			Metadata metadata = new Metadata();
			PDFParser parser = new PDFParser();
			ParseContext context = new ParseContext();
			parser.parse(input, textHandler, metadata, context);
		} catch (FileNotFoundException e) {
			System.out.println(EXCEPTION_IDENTIFIER);
			printStackTrace(e);
		} catch (Exception e) {
			System.out.println(EXCEPTION_IDENTIFIER);
			printStackTrace(e);
		} finally {
			if (input != null)
				try {
					input.close();
				} catch (IOException e) {
					System.out.println(EXCEPTION_IDENTIFIER);
					printStackTrace(e);
				}
		}
		if (textHandler != null)
			System.out.println(textHandler.toString()); // Print the file
														// contents to console
	}
	
	public static Boolean isPDF(File file) {
		if (file != null)
			return file.getPath().endsWith(".pdf");
		return false;
	}
	
	public static void printStackTrace(Throwable error) {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		error.printStackTrace(pw);
		System.out.println(sw.toString());
	}

}