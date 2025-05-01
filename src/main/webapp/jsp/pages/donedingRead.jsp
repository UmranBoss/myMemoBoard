<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="Model.DoneDing"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page session="true"%>
<%
List<DoneDing> liste = (List<DoneDing>) session.getAttribute("donedings");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DoneDing - Übersicht</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/studysnapRead.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Red+Hat+Display:ital,wght@0,300..900;1,300..900&display=swap"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Alef:wght@400;700&family=Limelight&family=Mogra&family=Red+Hat+Display:ital,wght@0,300..900;1,300..900&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<jsp:include page="/jsp/navbar.jsp" />
	<header>
		<h1>DoneDings</h1>
		<p>Reflektiere, was du bereits geschafft hast.</p>
	</header>

	<main>
		<div class="container">
			<%
			if (liste == null || liste.isEmpty()) {
			%>
			<p class="info">Noch keine Aufgaben vorhanden. Schreib die Erste!</p>
			<%
			} else {
			%>
			<table>
				<tr>
					<th>Datum</th>
					<th>Titel</th>
					<th>Kategorie</th>
					<th>Priorität</th>
					<th>Beschreibung</th>
					<th>Erinnerung</th>
				</tr>
				<%
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy 'um' HH:mm");
				for (DoneDing eintrag : liste) {
				%>
				<%
				String prioRaw = eintrag.getPrioritaet();
				String prioClass = "keine-prio"; // Fallback-Klasse, wenn null

				if (prioRaw != null) {
					prioClass = "prio-" + prioRaw.toLowerCase();
				}
				%>
				<tr class="<%=prioClass%>">

					<td><%=eintrag.getErstellDatum()%></td>
					<td><%=eintrag.getTitel()%></td>
					<td><%=eintrag.getKategorie()%></td>
					<%
					String prio = eintrag.getPrioritaet();
					/* String farbe = "gray"; // Fallback-Farbe

					if (prio != null) {
						switch (prio.toLowerCase()) {
						case "hoch":
							farbe = "red";
							break;
						case "mittel":
							farbe = "orange";
							break;
						case "niedrig":
							farbe = "green";
							break;
						}
					} */
					%>
					<%-- <td class="prio-cell"><span class="prio-kreis"
						style="background-color:<%=farbe%>"></span> <%=prio != null ? prio : "Keine Priorität"%></td>


					<td> --%>
					<td><%=prio != null ? prio : "Keine Priorität"%></td>
					<td>
						<%
						// Überprüfen, ob der Inhalt null ist
						String beschreibung = eintrag.getBeschreibung();
						String beschreibungAusgabe = "";

						if (beschreibung != null) {
							// Ersetze Zeilenumbrüche mit <br>, wenn der Inhalt nicht null ist
							beschreibungAusgabe = beschreibung.replaceAll("\n", "<br>");
						}

						// Gib den Inhalt aus
						out.print(beschreibungAusgabe);
						%>
					</td>

					<td>
						<%
						if (eintrag.getErinnerungsDatum() != null) {
						%> <i class="far fa-clock"></i> <%=eintrag.getErinnerungsDatum().format(formatter)%>
						<%
						} else {
						%> <span style="color: #aaa;"><i>Keine Erinnerung</i></span> <%
 }
 %>
					</td>
				</tr>
				<%
				}
				%>
			</table>
			<%
			}
			%>

			<a href="<%=request.getContextPath()%>/jsp/pages/donedingWrite.jsp"
				class="link-abstand">
				<button type="button" class="backbutton">Neue Aufgabe
					schreiben</button>
			</a> <a href="<%=request.getContextPath()%>/index.jsp">
				<button type="button" class="backbutton">Zurück zur
					Startseite</button>
			</a>
		</div>
	</main>
</body>
</html>
