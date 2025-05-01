package Servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import Model.StudySnap;

/**
 * Servlet implementation class StudySnapReadServlet
 */
@WebServlet("/StudySnapReadServlet")
public class StudySnapReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String FILE_PATH = "C:\\Users\\ÜmranBüyüksüren\\eclipse-workspace\\MemoBoard\\studysnap.ser";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public StudySnapReadServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Filterparameter lesen
		String datumFilter = request.getParameter("datum");
		String modulFilter = request.getParameter("modul");
		String suchbegriff = request.getParameter("suche");

		// Paginationparameter lesen
		int page = 1;
		int pageSize = 5;
		String pageParam = request.getParameter("page");

		if (pageParam != null && pageParam.matches("\\d+")) {
			page = Integer.parseInt(pageParam);
		}

		List<StudySnap> protocolls = loadProtocoll();
		List<StudySnap> gefiltert = new ArrayList<>();

		for (StudySnap eintrag : protocolls) {
			boolean passt = true;

			if (datumFilter != null && !datumFilter.isEmpty() && !eintrag.getDatum().equals(datumFilter)) {
				passt = false;
			}
			if (modulFilter != null && !modulFilter.isEmpty() && !eintrag.getModul().equalsIgnoreCase(modulFilter)) {
				passt = false;
			}

			if (suchbegriff != null && !suchbegriff.isEmpty()) {
				String summary = (eintrag.getThema() + "" + eintrag.getInhalt().toLowerCase());
				if (!summary.contains(suchbegriff.toLowerCase())) {
					passt = false;
				}
			}

			if (passt) {
				gefiltert.add(eintrag);
			}

		}
		request.setAttribute("alleModule", getAllModules(protocolls));

		// Pagination vorbereiten
		int totalProtocolls = gefiltert.size();
		int totalPages = (int) Math.ceil((double) totalProtocolls / pageSize);

		int startIndex = 0;
		int endIndex = 0;

		if (totalProtocolls == 0) {
			page = 1;
			startIndex = 0;
			endIndex = 0;
		} else {
			if (page > totalPages)
				page = totalPages;
			if (page < 1)
				page = 1;

			startIndex = (page - 1) * pageSize;
			endIndex = Math.min(startIndex + pageSize, totalProtocolls);
		}

		List<StudySnap> pagedProtocolls = gefiltert.subList(startIndex, endIndex);

		// Daten an die JSP übergeben
		request.setAttribute("protocolls", pagedProtocolls);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalPages", totalPages);

		// Auch die Filter wieder übergeben, damit sie im Formular erhalten bleiben
		request.setAttribute("datum", datumFilter);
		request.setAttribute("modul", modulFilter);
		request.setAttribute("suche", suchbegriff);

		request.getSession().setAttribute("protocolls", gefiltert);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/pages/studysnapRead.jsp");
		dispatcher.forward(request, response);

//		request.getSession().setAttribute("protocolls", gefiltert);
//		RequestDispatcher read = request.getRequestDispatcher("/jsp/pages/studysnapRead.jsp");
//		read.forward(request, response);
	}

	private List<StudySnap> loadProtocoll() {
		try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(FILE_PATH))) {
			return (List<StudySnap>) ois.readObject();
		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
			return new ArrayList<>(); // Falls Datei nicht existiert oder Fehler auftritt
		}
	}

	private List<String> getAllModules(List<StudySnap> liste) {
		Set<String> moduleSet = new HashSet<>();
		for (StudySnap s : liste) {
			if (s.getModul() != null && !s.getModul().isBlank()) {
				moduleSet.add(s.getModul());
			}
		}
		return new ArrayList<>(moduleSet);
	}

}
