<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="sidebar">
	<div class="sidebar-header">
		<div class="profile-placeholder">
			<i class="fas fa-user-circle fa-3x"></i> <span class="username">Willkommen!</span>
		</div>
	</div>
	<nav class="sidebar-nav">
		<ul>
			<li><a href="<%=request.getContextPath()%>/index.jsp"><i
					class="fas fa-home"></i> Startseite</a></li>
			<li><a href="todo.jsp"><i class="fas fa-tasks"></i> DoneDing</a></li>
			<li><a
				href="<%=request.getContextPath()%>/jsp/pages/studysnap.jsp"><i
					class="fas fa-book"></i> StudySnap</a></li>
			<li><a href="finance.jsp"><i class="fas fa-wallet"></i>
					CashCheck</a></li>
			<li><a href="contract.jsp"><i class="fas fa-file-signature"></i>
					VertragVox</a></li>
			<li><a href="doctor.jsp"><i class="fas fa-notes-medical"></i>
					DocDrop</a></li>
			<li><a href="diary.jsp"><i class="fas fa-pen-fancy"></i>
					SeelenSkript</a></li>
			<li><a href="#"><i class="fas fa-cog"></i> Einstellungen</a></li>
		</ul>
	</nav>
	<div class="sidebar-footer">
		<button class="action-btn">
			<i class="fas fa-plus"></i> Neuer Eintrag
		</button>
		<button class="logout-btn">
			<i class="fas fa-sign-out-alt"></i> Logout
		</button>
		<button class="theme-toggle">
			<i class="fas fa-moon"></i> Dark Mode
		</button>
	</div>
</div>
