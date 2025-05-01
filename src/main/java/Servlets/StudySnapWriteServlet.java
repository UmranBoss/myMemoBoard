package Servlets;

import java.util.List;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

import Model.StudySnap;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProtocolWriteServlet
 */
@WebServlet("/StudySnapWriteServlet")
public class StudySnapWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String FILE_PATH = "C:\\Users\\ÜmranBüyüksüren\\eclipse-workspace\\MemoBoard\\studysnap.ser";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudySnapWriteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Heutiges Datum im Format yyyy-MM-dd (HTML5-kompatibel für input[type="date"])
		String heutigesDatum = LocalDate.now().toString();

		// Als Attribut an die JSP übergeben
		request.setAttribute("heutigesDatum", heutigesDatum);

		// Weiterleitung zur JSP
		RequestDispatcher dispatcher = request.getRequestDispatcher("/datum.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Laden der Protokolle aus der Datei
		List<StudySnap> protocolls = loadProtocoll();

		String aktuellesDatum = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String datum = request.getParameter("datum");
		if (!aktuellesDatum.equals(datum)) {

			request.setAttribute("fehler", "Das Datum muss das heutige Datum sein!");
			request.getRequestDispatcher("/jsp/pages/studysnapWrite.jsp").forward(request, response);
			return;
		}

		String modul = request.getParameter("modul");
		String thema = request.getParameter("thema");
		String inhalt = request.getParameter("inhalt");
		String zeitstempel = new SimpleDateFormat("HH:mm:ss").format(new Date());

		StudySnap neuerEintrag = new StudySnap(datum, modul, thema, inhalt);

		if (protocolls == null) {
			protocolls = new ArrayList<>(); // Falls keine Protokolle vorhanden sind, erzeuge eine leere Liste
		}
		protocolls.add(neuerEintrag);
		saveProtocoll(protocolls);

		request.getSession().setAttribute("letzteSpeicherung", zeitstempel);
		request.getSession().setAttribute("protocolls", protocolls);
		request.setAttribute("speichernErfolgreich", "Das Protokoll ist jetzt in der Cloud der Unsterblichkeit.");
		request.getRequestDispatcher("/jsp/pages/studysnapWrite.jsp").forward(request, response);
																							
	}

	private List<StudySnap> loadProtocoll() {
		List<StudySnap> protocolls = new ArrayList<>();
		try {
			File file = new File(FILE_PATH);
			if (!file.exists()) {
				// Datei existiert nicht, also leere Liste zurückgeben oder initialisierte Daten
				// erzeugen
				System.out.println("Datei existiert nicht, neue Datei wird erstellt.");
				saveProtocoll(protocolls); // Leere Datei speichern
			} else {
				try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
					protocolls = (List<StudySnap>) ois.readObject();
				}
			}
		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return protocolls;
	}

	private void saveProtocoll(List<StudySnap> protocolls) {

		File file = new File(FILE_PATH);
		file.getParentFile().mkdirs(); // Verz erstellen, falls es nicht existiert

		try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
			oos.writeObject(protocolls);
			System.out.println("Datei wurde erfolgreich geschrieben!");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
