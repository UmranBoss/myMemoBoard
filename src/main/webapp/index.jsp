<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

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


<!-- Link zur externen CSS-Datei -->
<link rel="stylesheet" type="text/css" href="css/index.css">




<title>MemoBoard</title>
</head>
<body>
	<jsp:include page="/jsp/navbar.jsp" />
	<div class="page-wrapper">
		<header>
			<h1>Mein MemoBoard</h1>
			<p>Klick Dich durch, bleib im Flow.</p>
		</header>
		<main>
			<div class="kachel-container">
				<div class="kachel" onclick="rotateKachel(this);"
					data-link="<%=request.getContextPath()%>/jsp/pages/doneding.jsp">
					<div class="card-inner">
						<div class="card-front">
							<div class="gif-wrapper">
								<img src="webContent/home/static/todo.png" class="static"
									alt="todo preview"> <img
									src="webContent/home/animated/todo.gif" class="animated"
									alt="todo animation">
							</div>
						</div>
						<div class=card-back>
							<h2>DoneDing</h2>
							<p>Deine Aufgaben - schön klar & struktiert.</p>
						</div>
					</div>
				</div>
				<div class="kachel" onclick="rotateKachel(this);"
					data-link="<%=request.getContextPath()%>/jsp/pages/studysnap.jsp">
					<div class="card-inner">
						<div class="card-front">
							<div class="gif-wrapper">
								<img src="webContent/home/static/protocol.png" class="static"
									alt="protocol preview"> <img
									src="webContent/home/animated/protocol.gif" class="animated"
									alt="protocol animation">
							</div>
						</div>
						<div class="card-back">
							<h2>StudySnap</h2>
							<p>Alles Wichtige aus dem Unterricht.</p>
						</div>
					</div>
				</div>
				<div class="kachel" onclick="rotateKachel(this);"
					data-link="finance.jsp">
					<div class="card-inner">
						<div class="card-front">
							<div class="gif-wrapper">
								<img src="webContent/home/static/finance.png" class="static"
									alt="finance preview"> <img
									src="webContent/home/animated/finance.gif" class="animated"
									alt="finance animation">
							</div>
						</div>
						<div class="card-back">
							<h2>CashCheck</h2>
							<p>Behalte den Überblick über dein Geld.</p>
						</div>
					</div>
				</div>
				<div class="kachel" onclick="rotateKachel(this);"
					data-link="contract.jsp">
					<div class="card-inner">
						<div class="card-front">
							<div class="gif-wrapper">
								<img src="webContent/home/static/contract.png" class="static"
									alt="contract preview"> <img
									src="webContent/home/animated/contract.gif" class="animated"
									alt="contract animation">
							</div>
						</div>
						<div class="card-back">
							<h2>VertragVox</h2>
							<p>Du weißt, was du unterschrieben hast.</p>
						</div>
					</div>
				</div>
				<div class="kachel" onclick="rotateKachel(this);"
					data-link="doctor.jsp">
					<div class="card-inner">
						<div class="card-front">

							<div class="gif-wrapper">
								<img src="webContent/home/static/doctor.png" class="static"
									alt="doctor preview"> <img
									src="webContent/home/animated/doctor.gif" class="animated"
									alt="doctor animation">
							</div>
						</div>
						<div class="card-back">
							<h2>DocDrop</h2>
							<p>Vergiss nie wieder deinen Termin.</p>
						</div>
					</div>
				</div>
				<div class="kachel" onclick="rotateKachel(this);"
					data-link="diary.jsp">
					<div class="card-inner">
						<div class="card-front">
							<div class="gif-wrapper">
								<img src="webContent/home/static/diary.png" class="static"
									alt="diary preview"> <img
									src="webContent/home/animated/diary.gif" class="animated"
									alt="diary animation">
							</div>
						</div>
						<div class="card-back">
							<h2>SeelenSkript</h2>
							<p>Ein Platz für dich.</p>
						</div>
					</div>
				</div>
			</div>
		</main>
		<jsp:include page="/jsp/footer.jsp"></jsp:include>
	</div>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
</body>
</html>