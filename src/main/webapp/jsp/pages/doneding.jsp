<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<title>DoneDing</title>
<head>
<!-- Link zur externen CSS-Datei -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/doneding.css">

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
		<h1>DoneDing</h1>
		<p>Deine Aufgabe - schön & klar strukturiert.</p>
	</header>
	<main>
		<div class="kachel-container">
			<div class="kachel" onclick="rotateKachel(this);"
				data-link="<%=request.getContextPath()%>/jsp/pages/donedingWrite.jsp">
				<div class="card-inner">
					<div class="card-front">
						<div class="gif-wrapper">
							<img
								src="<%=request.getContextPath()%>/webContent/features/write.png"
								class="static" alt="write preview"> <img
								src="<%=request.getContextPath()%>/webContent/features/write.gif"
								class="animated" alt="write animation">
						</div>
					</div>
					<div class=card-back>
						<h2>SCHREIBEN</h2>
						<p>Mach dir 'nen Plan – bevor der Tag dich plant.</p>
					</div>
				</div>
			</div>
			<div class="kachel" onclick="rotateKachel(this);"
				data-link="<%=request.getContextPath()%>/DoneDingReadServlet">
				<div class="card-inner">
					<div class="card-front">
						<div class="gif-wrapper">
							<img
								src="<%=request.getContextPath()%>/webContent/features/read.png"
								class="static" alt="read preview"> <img
								src="<%=request.getContextPath()%>/webContent/features/read.gif"
								class="animated" alt="read animation">
						</div>
					</div>
					<div class="card-back">
						<h2>LESEN</h2>
						<p>Lesen und Haken setzen – das perfekte Duo!</p>
					</div>
				</div>
			</div>
		</div>


	</main>


	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	<jsp:include page="/jsp/footer.jsp"></jsp:include>

</body>
</html>