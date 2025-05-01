function toggleSidebar() {
	const sidebar = document.querySelector('.sidebar');
	const wrapper = document.querySelector('.page-wrapper');
	sidebar.classList.toggle('open');
	wrapper.classList.toggle('shifted');
}