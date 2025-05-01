<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Link zur externen CSS-Datei für die Navbar -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/navbar.css">

<!-- Link zu Font Awesome (falls noch nicht vorhanden) -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<nav class="navbar">
	<ul class="nav-items">
		<li class="nav-item" data-text="Home"
			onclick="navigateTo('<%=request.getContextPath()%>/index.jsp')"><i class="fas fa-home"></i><span
			class="nav-label">Home</span></li>
		<li class="nav-item" data-text="DoneDing"
			onclick="navigateTo('<%=request.getContextPath()%>/jsp/pages/doneding.jsp')"><i
			class="fas fa-check-square"></i><span class="nav-label">DoneDing</span></li>
		<li class="nav-item" data-text="StudySnap"
			onclick="navigateTo('<%=request.getContextPath()%>/jsp/pages/studysnap.jsp')"><i
			class="fas fa-book-open"></i><span class="nav-label">StudySnap</span>
		</li>
		<li class="nav-item" data-text="CashCheck"
			onclick="navigateTo('<%=request.getContextPath()%>/jsp/pages/cashcheck.jsp')"><i
			class="fas fa-wallet"></i><span class="nav-label">CashCheck</span></li>
		<li class="nav-item" data-text="VertragVox"
			onclick="navigateTo('<%=request.getContextPath()%>/jsp/pages/vertragvox.jsp')"><i
			class="fas fa-file-signature"></i><span class="nav-label">VertragVox</span>
		</li>
		<li class="nav-item" data-text="DocDrop"
			onclick="navigateTo('<%=request.getContextPath()%>/jsp/pages/docdrop.jsp')"><i
			class="fas fa-notes-medical"></i><span class="nav-label">DocDrop</span>
		</li>
		<li class="nav-item" data-text="SeelenSkript"
			onclick="navigateTo('<%=request.getContextPath()%>/jsp/pages/seelenskriptF.jsp')"><i
			class="fas fa-heart"></i><span class="nav-label">SeelenSkript</span></li>
	</ul>


</nav>

<script src="<%=request.getContextPath()%>/js/navbar.js"></script>
