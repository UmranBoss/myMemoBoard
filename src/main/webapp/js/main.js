let clicked = false;

function rotateKachel(kachel) {
	if (clicked) return;
	clicked = true;

	// Sofort alle anderen Kacheln unclickable machen
	const allKacheln = document.querySelectorAll('.kachel');
	allKacheln.forEach(k => {
		k.style.pointerEvents = 'none';
	});

	// Animation starten
	kachel.classList.add("flipped");

	const target = kachel.getAttribute("data-link");
	if (target) {
		setTimeout(() => {
			window.location.href = target;
		}, 3000); // erst nach der Animation weiterleiten
	}
}



