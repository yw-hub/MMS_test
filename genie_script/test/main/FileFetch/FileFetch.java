//package Interpretation;

import java.io.File;
import java.io.*;

public class FileFetch {
	public static File fetch(String gPath,
		String pSurname, String pFName, int pID,
		String fRName) {
		String fPath = gPath + "/Images/" +
			pSurname.charAt(0) + "/" +
			pSurname + pFName.charAt(0) + Integer.toString(pID) + "/" +
			fRName;
		return new File(fPath);
	}
	
	public static void main(String[] args) throws IOException {
		String gPath = "C:/Users/Administrator/Downloads/Genie";
		String pSurname = "Ienttwo";
		String pFName = "Pat";
		int pid = 40;
		String fRName = "2.txt";
		
		File f = fetch(gPath, pSurname, pFName, pid, fRName);
		if (!f.exists())
			System.out.println("problem: file doesn't exist");
		BufferedReader br = new BufferedReader(new FileReader(f));
		String line;
		while ((line = br.readLine()) != null)
			System.out.println(line);
	}
}