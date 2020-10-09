package Interpretation;

import Interpretation.FDType.*;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.Reader;
import java.io.IOException;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.List;

public class FDInterpreter {
    private Class<FDType> fdParentType = FDType.class;
    private static FDInterpreter instance = null;
    private static final boolean dbg = false;

	private List<Class<? extends FDType>> fdTypes =
		new ArrayList<Class<? extends FDType>>() {{
		add(FDBool.class);
		add(FDByte.class);
		add(FDDuration.class);
		add(FDLong.class);
		add(FDLong8.class);
		add(FDReal.class);
		add(FDString.class);
		add(FDTime.class);
		add(FDWord.class);
	}};

    protected FDInterpreter(){
        // Exists only to defeat instantiation.
    }

    public static FDInterpreter getInstance() {
        if(instance == null) {
            instance = new FDInterpreter();
        }
        return instance;
    }

    private final String[] fields = {"Statement-ID", "Command-Count",
		"Result-Type", "Column-Count", "Row-Count", "Column-Types",
		"Column-Aliases", "Column-Updateability", "Row-Count-Sent"};

    private FDType getFDType(String identifier) throws IllegalAccessException,
		    InstantiationException, NoSuchFieldException {
        for (Class<? extends FDType> c : fdTypes) {
            if (fdParentType.isAssignableFrom(c)
                && !Modifier.isAbstract(c.getModifiers())
                && identifier.equals(
                    c.getField("identifier").get(null))
            )
                return c.newInstance();
        }
		return null;
	}

	private void readUntil(WrappedInputStream input, StringBuilder word, char
            separator) throws IOException {
		char letter;
		word.setLength(0);
		letter = input.readChar();
		while (letter != separator) {
			word.append(letter);
			letter = input.readChar();
		}
		//if (dbg) System.out.println(word);
	}

	private void readWindowsLine(WrappedInputStream input, StringBuilder word)
			throws IOException {
		readUntil(input, word, '\r');
		if (input.readChar() != '\n') {
			// Throw exception
		}
	}

	public JSONArray interpret(WrappedInputStream input) throws
			IOException, IllegalAccessException, NoSuchFieldException,
			InstantiationException {
		StringBuilder word = new StringBuilder();
		StringBuilder output = new StringBuilder();
		char letter;
		int f = 0;

		//Process command id
		readUntil(input, word, ' ');
		//int cmdID = Integer.parseInt(word.toString().trim());
		word.setLength(0);
		if (dbg) System.out.println("interped cid");

		//Process status
		readWindowsLine(input, word);
		if ("ERROR".equals(word.toString().trim())) {
			// Parse error
		} else if (!"OK".equals(word.toString().trim())) {
			// Throw exception
		}

		//Process statement id
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		word.setLength(0);
		readWindowsLine(input, word);
		//int stmntID = Integer.parseInt(word.toString().trim());
		if (dbg) System.out.println("interped sid");

		//Process command-count
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		word.setLength(0);
		readWindowsLine(input, word);
		//int cmndCnt = Integer.parseInt(word.toString().trim());
		if (dbg) System.out.println("interped com count");

		//Process result type
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		word.setLength(0);
		readWindowsLine(input, word);
		//String resType = word.toString().trim();
		if (dbg) System.out.println("interped result type");

		//Process column count
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		word.setLength(0);
		readWindowsLine(input, word);
		int columns = Integer.parseInt(word.toString().trim());
		if (dbg) System.out.println("interped col count");

		//Process row count
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		word.setLength(0);
		readWindowsLine(input, word);
		int rows = Integer.parseInt(word.toString().trim());
		if (dbg) System.out.println("interped row count");

		//Process column types
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		List<FDType> interps = new ArrayList<>();
		for (int i=0; i<columns-1; i++) {
			readUntil(input, word, ' ');
			interps.add(getFDType(word.toString().trim()));
		}
		if (columns > 0) {
			word.setLength(0);
			readWindowsLine(input, word);
			interps.add(getFDType(word.toString().trim()));
		}
		if (dbg) System.out.println("interped col types");

		//Process column names
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		for (int i=0; i<columns-1; i++) {
			readUntil(input, word, ' ');
			String cname = word.toString().trim();
			interps.get(i).name(cname.substring(1, cname.length()-1));
			word.setLength(0);
		}
		if (columns > 0) {
			word.setLength(0);
			readWindowsLine(input, word);
			String cname = word.toString().trim();
			interps.get(interps.size()-1).name(cname.substring(1,
					cname.length()-1));
		}
		if (dbg) System.out.println("interped col names");

		//Process column updateability
		readUntil(input, word, ' ');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		List<Boolean> updateable = new ArrayList<>();
		for (int i=0; i<columns-1; i++) {
			letter = input.readChar();
			if (letter == 'Y') {
				updateable.add(true);
			} else if (letter == 'N') {
				updateable.add(false);
			} else {
				// Throw exception
			}
			input.readByte();
		}
		if (columns > 0) {
			letter = input.readChar();
			if (letter == 'Y') {
				updateable.add(true);
			} else if (letter == 'N') {
				updateable.add(false);
			} else {
				// Throw exception
			}
			readWindowsLine(input, word);
		}
		if (dbg) System.out.println("interped updateability");

		//Process row count sent
		readUntil(input, word, ':');
		if (!fields[f].equals(word.toString().trim())) {
			// Throw exception
		}
		f++;
		word.setLength(0);
		readWindowsLine(input, word);
		rows = Integer.parseInt(word.toString().trim());
		word.setLength(0);
		readWindowsLine(input, word);
		if (dbg) System.out.println("interped row count");

		//Process data
		Gson gson = new GsonBuilder().serializeNulls().create();
		FDLong rid = new FDLong();
		FDLong err = new FDLong();
		rid.name("Record_ID");
		output.append('[');
		if (dbg) System.out.println("initialised data interp");
		for (int i=0; i<rows; i++) {
			output.append('{');
			// Process record id
			if (updateable.get(i)) {
				letter = input.readChar();
				if (letter == '0') {
					rid.nullVal(output, gson);
				} else if (letter == '1') {
					rid.interpret(input, output, gson);
				} else if (letter == '2') {
					err.name(rid.getName() + "_ERROR_ID");
					err.interpret(input, output, gson);
				} else {
					// Throw exception
				}
				output.append(',');
			}
			// Process fields of that row
			for (FDType fdt : interps) {
				letter = input.readChar();
				if (dbg) System.out.println(letter + " " + fdt.getName());
				if (letter == '0') {
					fdt.nullVal(output, gson);
				} else if (letter == '1') {
					fdt.interpret(input, output, gson);
				} else if (letter == '2') {
					err.name(fdt.getName() + "_ERROR_ID");
					err.interpret(input, output, gson);
				} else {
					// Throw exception
				}
				output.append(',');
			}
			if (output.charAt(output.length()-1) == ',')
				output.deleteCharAt(output.length()-1);
			output.append("},");
			if (dbg) System.out.println(output);
		}
		if (output.charAt(output.length()-1) == ',')
				output.deleteCharAt(output.length()-1);
		output.append(']');
		System.out.println(output);

		return conversion(output.toString());
	}

	/*
Use this method to convert Alston string into JSON array
 */
	public JSONArray conversion(String text) {

		text = text.replaceAll(":[ ]*([\\w@\\:\\.\\\"\\- ]+)", ": \"$1\"");
		text = text.replaceAll(":[ ]*,", ": null,");
		try {
			JSONArray jsonArray = (JSONArray) new JSONParser().parse(text);
			return jsonArray;
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
}