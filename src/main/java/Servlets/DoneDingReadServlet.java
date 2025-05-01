package Servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import Model.DoneDing;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DoneDingReadServlet")
public class DoneDingReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String FILE_PATH = "C:\\Users\\ÜmranBüyüksüren\\eclipse-workspace\\MemoBoard\\doneding.ser";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<DoneDing> donedings = loadDoneDings();

		for (DoneDing d : donedings) {
			System.out.println("Geladenes DoneDing:");
			System.out.println("Titel: " + d.getTitel());
			System.out.println("Datum: " + d.getErstellDatum());
			System.out.println("Kategorie: " + d.getKategorie());
			System.out.println("Priorität: " + d.getPrioritaet());
			System.out.println("Beschreibung: " + d.getBeschreibung());
			System.out.println("Erinnerung: " + d.getErinnerungsDatum());
		}

		HttpSession session = request.getSession();
		session.setAttribute("donedings", donedings);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/jsp/pages/donedingRead.jsp");
		dispatcher.forward(request, response);
	}

	private List<DoneDing> loadDoneDings() {
		List<DoneDing> liste = new ArrayList<>();

		File file = new File(FILE_PATH);
		if (!file.exists()) {

			return liste;
		}

		try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
			liste = (List<DoneDing>) ois.readObject();

		} catch (IOException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		return liste;
	}
}
