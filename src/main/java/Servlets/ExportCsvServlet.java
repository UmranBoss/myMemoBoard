package Servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.List;

import Model.StudySnap;

/**
 * Servlet implementation class ExportCsvServlet
 */
@WebServlet("/ExportCsvServlet")
public class ExportCsvServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String FILE_PATH = "C:\\Users\\ÜmranBüyüksüren\\eclipse-workspace\\MemoBoard\\studysnap.ser";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ExportCsvServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Hole die ausgewählten Protokolle (ID-Array aus den Checkboxes)
		String[] exportIds = request.getParameterValues("exportIds");

		// Hole die Protokolle aus der Session
		List<StudySnap> protocolls = (List<StudySnap>) request.getSession().getAttribute("protocolls");

		// Setze den Content-Type auf "text/csv"
		response.setContentType("text/csv");
		response.setHeader("Content-Disposition", "attachment; filename=StudySnap_Protokolle.csv");

		// Schreibe BOM (Byte Order Mark) für UTF-8, damit Excel die Datei korrekt als
		// UTF-8 interpretiert
		OutputStream os = response.getOutputStream();
		os.write(0xEF);
		os.write(0xBB);
		os.write(0xBF); // BOM für UTF-8

		// Erstelle einen Writer mit UTF-8 Codierung
		BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(os, "UTF-8"));

		// Header-Zeile (Spaltennamen)
		writer.write("Datum; Modul; Thema; Inhalt\n");

		// Falls exportIds nicht null ist, exportiere nur die ausgewählten Zeilen
		if (exportIds != null) {
			for (String id : exportIds) {
				int index = Integer.parseInt(id); // ID aus dem Formular (Index der Protokolle)
				StudySnap eintrag = protocolls.get(index);

				// Datum formatieren
				String formatiertesDatum = eintrag.getDatum();
				String modul = eintrag.getModul();
				String thema = eintrag.getThema();
				String inhalt = eintrag.getInhalt();

				// Jede Zeile: ein Protokoll, alle Felder in ihren Spalten (durch Komma
				// getrennt, Inhalt escaped)
				writer.write(escapeCsv(formatiertesDatum) + ";" + escapeCsv(modul) + ";" + escapeCsv(thema) + ";"
						+ escapeCsv(inhalt) + "\n");
			}
		}

		// Schließe den Writer
		writer.flush();
		writer.close();
	}

	// CSV-Escape für Sonderzeichen (z. B. Komma oder Zeilenumbrüche)
	private String escapeCsv(String input) {
		if (input == null)
			return "";

		String escaped = input.replace("\"", "\"\"");
		if (escaped.contains(",") || escaped.contains("\n") || escaped.contains("\"")) {
			return "\"" + escaped + "\"";
		} else {
			return escaped;
		}

	}
}