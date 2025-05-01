<%@page import="Model.StudySnap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
List<StudySnap> protocolls = (List<StudySnap>) request.getAttribute("protocolls");
Integer currentPage = (Integer) request.getAttribute("currentPage");
Integer totalPages = (Integer) request.getAttribute("totalPages");
String datum = (String) request.getAttribute("datum");
String modul = (String) request.getAttribute("modul");
String suche = (String) request.getAttribute("suche");
%>
<%@ page import="java.net.URLEncoder"%>
<%
String encodedDatum = datum != null ? URLEncoder.encode(datum, "UTF-8") : "";
String encodedModul = modul != null ? URLEncoder.encode(modul, "UTF-8") : "";
String encodedSuche = suche != null ? URLEncoder.encode(suche, "UTF-8") : "";
%>


<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudySnap - Übersicht</title>
<!-- Link zur externen CSS-Datei -->
<!-- Link zur externen CSS-Datei -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/studysnapRead.css">

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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
	<jsp:include page="/jsp/navbar.jsp" />
	<div class="page-wrapper">
		<header>
			<h1>Protokolle lesen</h1>
			<p>Ein Blick zurück für den nächsten Schritt nach vorn.</p>
		</header>
		<main>
			<div class="container">
				<form id="filterForm" method="get" action="StudySnapReadServlet"
					class="filter-form">
					<label for="datum">Datum:</label> <input type="date" name="datum"
						id="datum" value="<%=datum != null ? datum : ""%>"> <label
						for="modul">Modul:</label> <select name="modul" id="modul">
						<option value="">Alle Module</option>
						<%
						List<String> alleModule = (List<String>) request.getAttribute("alleModule");
						if (alleModule != null) {
							for (String modulName : alleModule) {
						%>
						<option value="<%=modulName%>"
							<%=modulName.equalsIgnoreCase(modul) ? "selected" : ""%>>
							<%=modulName%>
						</option>
						<%
						}
						}
						%>

					</select> <label for="suche">Volltext:</label> <input type="text"
						name="suche" id="suche" placeholder="Suchbegriff eingeben ..."
						value="<%=suche != null ? suche : ""%>">
					<button type="submit">
						<i class="fas fa-arrow-right" alt="Filtersuche"></i>
					</button>
					<a href="StudySnapReadServlet" style="" class="resetbutton">
						<button type="button" class="reset-button">
							<i class="fas fa-undo" alt="Zurücksetzen"></i>
						</button>

					</a>
				</form>
				<script>
				document.getElementById("filterForm").addEventListener(
						"keydown", function(e) {
							if (e.key === "Enter") {
								e.preventDefault(); // verhindert den Datums-Popup
								this.submit();
							}
						})
			</script>
				<form method="post" action="ExportCsvServlet">
					<table>
						<tr>
							<th>Datum</th>
							<th>Modul</th>
							<th>Thema</th>
							<th>Inhalt</th>
							<th>Export</th>
						</tr>
						<%
						SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
						SimpleDateFormat outputFormat = new SimpleDateFormat("dd.MM.yyyy");

						if (protocolls == null || protocolls.isEmpty()) {
						%>
						<tr>
							<td colspan="5">Keine Protokolle gefunden.</td>
						</tr>
						<%
						} else {
						for (int i = 0; i < protocolls.size(); i++) {
							StudySnap neuerEintrag = protocolls.get(i);
							Date parsedDate = inputFormat.parse(neuerEintrag.getDatum());
							String formattedDate = outputFormat.format(parsedDate);
						%>
						<tr>
							<td><%=formattedDate%></td>
							<td><%=neuerEintrag.getModul()%></td>
							<td><%=neuerEintrag.getThema()%></td>
							<td><%=neuerEintrag.getInhalt()%></td>
							<td><input type="checkbox" name="exportIds" value="<%=i%>">
							</td>
						</tr>
						<%
						}
						}
						%>
					</table>

					<%
					if (totalPages != null && totalPages > 1) {
					%>
					<div class="pagination">
						<%
						for (int i = 1; i <= totalPages; i++) {
						%>
						<%
						if (i == currentPage) {
						%>
						<span class="current-page"><%=i%></span>
						<%
						} else {
						%>
						<a
							href="StudySnapReadServlet?page=<%=i%><%=!encodedDatum.isEmpty() ? "&datum=" + encodedDatum : ""%><%=!encodedModul.isEmpty() ? "&modul=" + encodedModul : ""%><%=!encodedSuche.isEmpty() ? "&suche=" + encodedSuche : ""%>"><%=i%></a>

						<%
						}
						%>
						<%
						}
						%>
					</div>
					<%
					}
					%>

					<button type="submit" class="backbutton exportbutton">Exportieren
						als CSV</button>
				</form>
				<script>
  const checkboxes = document.querySelectorAll('input[name="exportIds"]');
  const exportButton = document.querySelector(".exportbutton");
  const exportForm = exportButton.closest("form");

  exportForm.addEventListener("submit", function (e) {
    const anyChecked = Array.from(checkboxes).some(cb => cb.checked);
    if (!anyChecked) {
      e.preventDefault();

      Swal.fire({
        icon: 'warning',
      title: 'Wähl ein Protokoll!',
        text: 'Sonst bleibt der Export im Tiefschlaf.',
        confirmButtonColor: '#fd6050',
        confirmButtonText: 'OK',
        customClass: {
          popup: 'custom-swal-popup',
          title: 'custom-swal-title',
          confirmButton: 'custom-swal-button',
          icon: 'custom-swal-icon'
        }
      });
    }
  });
</script>


				<a href="<%=request.getContextPath()%>/jsp/pages/studysnapWrite.jsp"
					class="link-abstand"><button type="button" class="backbutton">Neues
						Protokoll erstellen</button></a> <a
					href="<%=request.getContextPath()%>/index.jsp"><button
						type="button" class="backbutton">Zurück zur Startseite</button></a>
			</div>
		</main>
	</div>
	<jsp:include page="/jsp/footer.jsp"></jsp:include>
</body>
</html>