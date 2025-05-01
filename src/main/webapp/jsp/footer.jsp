<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Link zur externen CSS-Datei -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/footer.css">
<!-- footer.jsp -->
<section id="footer">
	<footer>
		<p class="app-name">
			<strong>MemoBoard</strong> – <em>Sag deinem Chaos ciao!</em>
		</p>
		<p>
			&copy; <span id="year"></span> | Version 1.0 (Beta) | HTML · CSS ·
			JavaScript · Java · MySQL
		</p>
		<p>
			Erstellt von <strong>Ümran Büyüksüren</strong> | <a
				href="https://github.com/UmranBoss" target="_blank"
				class="github-link"> <i class="fab fa-github github-icon"></i>
			</a>
		</p>
	</footer>
</section>
<script>
	document.getElementById('year').textContent = new Date().getFullYear();
</script>