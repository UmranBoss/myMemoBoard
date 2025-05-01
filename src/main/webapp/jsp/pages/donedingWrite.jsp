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
<title>DoneDing - Neue Aufgabe</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/studysnapWrite.css">

<!-- Fonts und Icons -->
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

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<jsp:include page="/jsp/navbar.jsp" />
	<header>
		<h1>Neue Aufgabe hinzufügen</h1>
		<p>Klar geplant – besser erledigt.</p>
	</header>
	<main>
		<div class="container">
			<form
				action="${pageContext.request.contextPath}/DoneDingWriteServlet#saved"
				method="POST">

				<!-- Flexbox für Erstelltdatum, Fälligkeitsdatum, Erinnerungsdatum -->
				<div class="form-row">
					<div>
						<label for="erstellDatum">Erstellt am:</label> <input type="date"
							id="erstellDatum" name="erstellDatum" value="${heutigesDatum}"
							required>
					</div>
					<div>
						<label for="faelligskeitsDatum">Fällig am:</label> <input
							type="date" id="faelligkeitsDatum" name="faelligkeitsDatum"
							required>
					</div>
					<div>
						<label for="erinnerungsDatum">Erinnern am:</label> <input
							type="date" id="erinnerungsDatum" name="erinnerungsDatum">
					</div>
					<div>
						<label for="erinnerungsUhrZeit">Um:</label> <input type="time"
							id="erinnerungsUhrzeit" name="erinnerungsUhrzeit">
					</div>
				</div>

				<!-- Flexbox für Titel, Kategorie, Priorität -->
				<div class="form-row">
					<div>
						<label for="titel">Titel:</label> <input type="text" id="titel"
							name="titel" required>
					</div>
					<div>
						<label for="kategorie">Kategorie:</label> <select name="kategorie">
							<option value="Privat">Privat</option>
							<option value="Uni">Uni/Schule</option>
							<option value="Arbeit">Arbeit</option>
							<option value="Sonstiges">Sonstiges</option>
						</select>
					</div>
					<div>
						<label for="prioritaet">Priorität:</label> <select
							name="prioritaet" id="prioritaet" required>
							<option value="Niedrig"
								<%="Niedrig".equals(request.getParameter("prioritaet")) ? "selected" : ""%>>Niedrig</option>
							<option value="Mittel"
								<%="Mittel".equals(request.getParameter("prioritaet")) ? "selected" : ""%>>Mittel</option>
							<option value="Hoch"
								<%="Hoch".equals(request.getParameter("prioritaet")) ? "selected" : ""%>>Hoch</option>
						</select>
					</div>


				</div>
				<!-- Textbereich für Beschreibung -->
				<div class="form-row">
					<label for="beschreibung">Beschreibung:</label><br>
					<textarea id="beschreibung" name="beschreibung" rows="8" cols="50"
						placeholder="Weitere Details zur Aufgabe..."></textarea>
				</div>
				<br> <br>
				<!-- Speichern Button -->
				<input type="submit" value="Aufgabe speichern">

				<!-- Zurück Buttons -->
				<br> <br> <a
					href="<%=request.getContextPath()%>/DoneDingReadServlet">
					<button type="button" class="backbutton">Aufgaben anzeigen</button>
				</a> <a href="<%=request.getContextPath()%>/index.jsp">
					<button type="button" class="backbutton">Zurück zur
						Startseite</button>
				</a>

			</form>

			<!-- Bestätigung, dass die Aufgabe erfolgreich gespeichert wurde -->
			<c:if test="${not empty speichernErfolgreich}">
				<script>
					if (window.location.hash === "#saved") {
						Swal.fire({
							icon : 'success',
							title : 'Aufgabe erfasst!',
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
		</form>
	</main>
	<jsp:include page="/jsp/footer.jsp"></jsp:include>
</body>
</html>
