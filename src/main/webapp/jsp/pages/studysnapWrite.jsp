<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%
String heutigesDatum = LocalDate.now().toString(); // ISO-Format: yyyy-MM-dd
request.setAttribute("heutigesDatum", heutigesDatum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StudySnap - Neues Protokoll</title>
<!-- Link zur externen CSS-Datei -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/studysnapWrite.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Red+Hat+Display:ital,wght@0,300..900;1,300..900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Limelight&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
	<jsp:include page="/jsp/navbar.jsp" />
	<div class="page-wrapper">
		<header>
			<h1>Neues Protokoll schreiben</h1>
			<p>Heute festgehalten. So oft wie nötig.</p>
		</header>
		<main>
			<div class="container">
				<form
					action="${pageContext.request.contextPath}/StudySnapWriteServlet#saved"
					method="POST">
					<!-- Flexbox für Datum, Modul, Thema nebeneinander -->
					<div class="form-row">
						<div>
							<label for="datum">Datum:</label> <input type="date" id="datum"
								name="datum" value="${heutigesDatum}" required>
						</div>
						<div>
							<label for="modul">Modul:</label> <select name="modul" required>
								<option value="PC Grundlagen">PC-Grundlagen</option>
								<option value="WiSo">WiSo</option>
								<option value="Netzwerktechnik">Netzwerktechnik</option>
								<option value="Betriebssysteme">Betriebssysteme</option>
								<option value="Datenbanken">Datenbanken</option>
								<option value="Programmierung">Programmierung</option>
								<option value="Objektorientierte Programmierung">Objektorientierte
									Programmierung</option>
								<option value="Java">Java</option>
							</select>
						</div>
						<div>
							<label for="thema">Thema:</label> <input type="text" name="thema"
								required>
						</div>
					</div>

					<!-- Textarea für den Inhalt -->
					<label for="inhalt">Inhalt:</label><br>
					<textarea name="inhalt" rows="10" cols="50" required></textarea>
					<br> <input type="submit" value="Speichern"> <br>

					<!-- Zurück Buttons -->
					<a href="<%=request.getContextPath()%>/StudySnapReadServlet">
						<button type="button" class="backbutton">Protokolle lesen</button>
					</a> <a href="<%=request.getContextPath()%>/index.jsp">
						<button type="button" class="backbutton">Zurück zur
							Startseite</button>
					</a>
				</form>

				<!-- Bestätigung, dass das Protokoll erfolgreich gespeichert wurde -->
				<c:if test="${not empty speichernErfolgreich}">
					<script>
					// Nur anzeigen, wenn die URL das Hash "#saved" enthält
					if (window.location.hash === "#saved") {
						Swal.fire({
							icon : 'success',
							title : 'Wissen gespeichert!',
							text : '${speichernErfolgreich}',
							timer : 3000,
							timerProgressBar : true,
							showConfirmButton: false,
							customClass : {
								popup : 'custom-swal-popup',
								title : 'custom-swal-title'
							
						
							},
						 didOpen: () => {
			                    const content = Swal.getHtmlContainer();
			                    if (content) content.style.marginTop = "10px";
			                }
			            });
			        }
				</script>
				</c:if>


				<br>
				<p>Letzte Speicherung: ${sessionScope.letzteSpeicherung != null ? sessionScope.letzteSpeicherung : "Noch keine Speicherung"}</p>
			</div>
		</main>
	</div>
	<jsp:include page="/jsp/footer.jsp"></jsp:include>
</body>
</html>
