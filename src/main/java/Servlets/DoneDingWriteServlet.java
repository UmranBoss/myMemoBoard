package Servlets;

import java.io.*;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

import Model.DoneDing;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DoneDingWriteServlet")
public class DoneDingWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String FILE_PATH = "C:\\Users\\ÜmranBüyüksüren\\eclipse-workspace\\MemoBoard\\doneding.ser";

	public DoneDingWriteServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String heutigesDatum = LocalDate.now().toString();
		request.setAttribute("heutigesDatum", heutigesDatum);
		RequestDispatcher disp = request.getRequestDispatcher("/jsp/pages/donedingWrite.jsp");
		disp.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<DoneDing> eintraege = loadEintraege();

		String erstellDatum = request.getParameter("erstellDatum");
		String aktuellesDatum = LocalDate.now().toString();

		if (!aktuellesDatum.equals(erstellDatum)) {
			request.setAttribute("fehler", "Das Datum muss das heutige Datum sein!");
			request.getRequestDispatcher("/jsp/pages/donedingWrite.jsp").forward(request, response);
			return;
		}

		String faelligkeitsDatumStr = request.getParameter("faelligkeitsDatum");
		LocalDate faelligkeitsDatum = null;

		try {
			faelligkeitsDatum = LocalDate.parse(faelligkeitsDatumStr);
		} catch (Exception e) {
			request.setAttribute("Fehler", "Ungültiges Fälligkeitsdatum!");
			request.getRequestDispatcher("/jsp/pages/donedingWrite.jsp").forward(request, response);
			return;
		}

		String erinnerungsDatum = request.getParameter("erinnerungsDatum");
		String erinnerungsUhrzeit = request.getParameter("erinnerungsUhrzeit");
		LocalDateTime erinnerung = null;

		if (erinnerungsDatum != null && erinnerungsUhrzeit != null && !erinnerungsDatum.isEmpty()
				&& !erinnerungsUhrzeit.isEmpty()) {
			try {
				erinnerung = LocalDateTime.parse(erinnerungsDatum + "T" + erinnerungsUhrzeit);
				if (erinnerung.isBefore(LocalDateTime.now())) {
					request.setAttribute("Fehler", "Die Erinnerung darf nicht in der Vergangenheit liegen!");
					request.getRequestDispatcher("/jsp/pages/donedingWrite.jsp").forward(request, response);
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("Fehler", "Ungültige Eingabe für Erinnerungsdatum oder -uhrzeit!");
				request.getRequestDispatcher("/jsp/pages/donedingWrite.jsp").forward(request, response);
				return;
			}
		}

		String titel = request.getParameter("titel");
		String kategorie = request.getParameter("kategorie");
		String prioritaet = request.getParameter("prioritaet");

		if (prioritaet == null || prioritaet.isEmpty()) {
			prioritaet = "Niedrig"; // Standardwert setzen
		}

		String beschreibung = request.getParameter("beschreibung");
		String zeitstempel = new SimpleDateFormat("HH:mm:ss").format(new Date());

		DoneDing neuerEintrag = new DoneDing(erstellDatum, faelligkeitsDatum, erinnerung, titel, kategorie, prioritaet,
				beschreibung);

		if (eintraege == null) {
			eintraege = new ArrayList<>();
		}
		eintraege.add(neuerEintrag);
		saveEintraege(eintraege);

		request.getSession().setAttribute("letzteSpeicherung", zeitstempel);
		request.getSession().setAttribute("donedings", eintraege);
		request.setAttribute("speichernErfolgreich", "Zeit für Heldentaten!");
		request.getRequestDispatcher("/jsp/pages/donedingWrite.jsp").forward(request, response);
	}

	private List<DoneDing> loadEintraege() {
		List<DoneDing> liste = new ArrayList<>();
		File file = new File(FILE_PATH);

		try {
			if (!file.exists()) {
				saveEintraege(liste); // leere Datei erzeugen
			} else {
				try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
					liste = (List<DoneDing>) ois.readObject();
				}
			}
		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return liste;
	}

	private void saveEintraege(List<DoneDing> liste) {
		File file = new File(FILE_PATH);
		file.getParentFile().mkdirs();

		try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(FILE_PATH))) {
			oos.writeObject(liste);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
