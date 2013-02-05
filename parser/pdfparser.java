import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;

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
	private static final int WRITE_LIMIT = -1; // Disables limit for pdf file size

	public static void main(String[] args) throws Exception {
		if (args.length < 1) {
			throw new Exception("Need a file to parse");
		}
		InputStream input = null;
		ContentHandler textHandler = null;
		try {
			input = new FileInputStream(new File(args[0]));
			textHandler = new BodyContentHandler(WRITE_LIMIT);
			Metadata metadata = new Metadata();
			PDFParser parser = new PDFParser();
			ParseContext context = new ParseContext();
			parser.parse(input, textHandler, metadata, context);
		} catch (Exception e) {
			System.exit(0);
		} finally {
			if (input != null)
				input.close();
		}
		if (textHandler != null)
			System.out.println(textHandler.toString()); // Print the file
														// contents to console
	}

}