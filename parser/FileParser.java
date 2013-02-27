import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.apache.tika.metadata.Metadata;
import org.apache.tika.sax.BodyContentHandler;
import org.apache.tika.parser.AutoDetectParser;
import org.apache.tika.parser.ParseContext;
import org.apache.tika.parser.Parser;
import org.xml.sax.ContentHandler;

/*
 *	To compile from within parser folder: javac -classpath :tika-app-1.3.jar  FileParser.java
 *	To run: java -cp :/RAILS_ROOT_FOLDER/parser/tika-app-1.3.jar:/RAILS_ROOT_FOLDER/parser FileParser <filepath> <Exception identifier>
 */

public class FileParser {
	/**
	 * Default identifier printed before exception details
	 */
	private static final String DEFAULT_EXCEPTION_IDENTIFIER = "Exception";
	/** 
	 * Disables limit for file size
	 */
	private static final int DISABLE_WRITE_LIMIT = -1;
	
	// Limit for file size in characters
	private final int WRITE_LIMIT;
	// Printed preceding any exception to identify script failed
	private final String EXCEPTION_IDENTIFIER;
	
	
	/**
	 * Construct a file parsing object
	 * 
	 * @param fileWriteLimit
	 *            - Limit parsing of file to this many characters
	 * @param exceptionIdentifier
	 *            - Identifier to be displayed in case of exception
	 */
	public FileParser(int fileWriteLimit, String exceptionIdentifier) {
		this.WRITE_LIMIT = fileWriteLimit;
		this.EXCEPTION_IDENTIFIER = exceptionIdentifier;
	}
	
	/**
	 * Construct a Parser with a write limit and default exeption string
	 * 
	 * @param fileWriteLimit
	 *            - Limit parsing of file to this many characters
	 */
	public FileParser(int fileWriteLimit) {
		this(fileWriteLimit, FileParser.DEFAULT_EXCEPTION_IDENTIFIER);
	}
	
	/**
	 * Construct a Parser with the default (disabled) Write limit
	 * 
	 * @param exceptionIdentifier
	 *            - Identifier to be displayed in case of exception
	 */
	public FileParser(String exceptionIdentifier) {
		this(FileParser.DISABLE_WRITE_LIMIT, exceptionIdentifier);
	}
	
	/**
	 * Given a file path name determine correct parser and parse the file to
	 * console
	 * 
	 * @param filePath
	 *            - Full path of the file to be parsed
	 */
	public void parse(String filePath) {
		if (filePath.endsWith(".zip")) {
			parseZip(filePath);
		} else {
			parseFile(filePath);
		}
	}
	
	/**
	 * Parse an uncompressed file with output going to the console
	 * 
	 * @param filePath
	 *            - Full path of the file to be parsed
	 */
	public void parseFile(String filePath) {
		InputStream input = null;
		try {
			File file = validateFile(filePath);
			input = new FileInputStream(file);
			parseStream(input);
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
	}
	
	/**
	 * Parse all files contained in a zip file and its sub-directories
	 * 
	 * @param filePath
	 *            - Full path for the zip archive
	 */
	public void parseZip(String filePath) {
		InputStream in = null;
		try {
			File checkedFile = validateFile(filePath);
			ZipFile zfile = new ZipFile(checkedFile);
			Enumeration<? extends ZipEntry> entries = zfile.entries();
			// Enumeration contains all files even in nested directories
			while (entries.hasMoreElements()) {
				ZipEntry entry = entries.nextElement();
				if (!entry.isDirectory()) {
					in = zfile.getInputStream(entry);
					parseStream(in);
				}
			}
		} catch (IOException e) {
			System.out.println(EXCEPTION_IDENTIFIER);
			printStackTrace(e);
		} catch (Exception e) {
			System.out.println(EXCEPTION_IDENTIFIER);
			printStackTrace(e);
		} finally {
			if (in != null)
				try {
					in.close();
				} catch (IOException e) {
					System.out.println(EXCEPTION_IDENTIFIER);
					printStackTrace(e);
				}
		}
	}
	
	/**
	 * Given an InputStream parse it using Tika, prints file contents to console
	 * 
	 * @param in
	 *            - Stream containing file contents
	 */
	public void parseStream(InputStream in) {
		ContentHandler textHandler = null;
		try {
			textHandler = new BodyContentHandler(WRITE_LIMIT);
			Metadata metadata = new Metadata();
			Parser parser = new AutoDetectParser();
			ParseContext context = new ParseContext();
			parser.parse(in, textHandler, metadata, context);
		} catch (Exception e) {
			System.out.println(EXCEPTION_IDENTIFIER);
			printStackTrace(e);
		}
		if (textHandler != null)
			System.out.println(textHandler.toString()); // Print the file
														// contents to console
	}
	
	/**
	 * Confirm a given file path points to a file
	 * 
	 * @param filePath
	 *            - Path to the file
	 * @return Created file at that path
	 * @throws Exception
	 *             - Thrown if file is invalid
	 */
	public File validateFile(String filePath) throws Exception {
		File file = new File(filePath);
		if (!file.isFile())
			throw new Exception("Given file name: " + file.getPath()
					+ " is invalid or does not exist");
		return file;
	}
	
	/**
	 * Print a stack trace of an exception to console
	 * 
	 * @param error
	 *            - Throwable containig exception information
	 */
	public static void printStackTrace(Throwable error) {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		error.printStackTrace(pw);
		System.out.println(sw.toString());
	}
	
	/**
	 * Script to parse a single pdf file
	 * 
	 * @param args
	 *            - File name followed by an identifier printed when an
	 *            exception occurs
	 */
	public static void main(String[] args) {
		if (args.length < 2) {
			System.out.println("Need a file to parse followed by exception identifier");
			return;
		}
		FileParser parser = new FileParser(args[1]);
		parser.parse(args[0]);
	}
}