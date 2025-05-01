package Model;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class DoneDing implements Serializable {
	private static final long serialVersionUID = 1L;

	private String erstellDatum;
	private LocalDate faelligkeitsDatum;
	private LocalDateTime erinnerungsDatum;
	private String titel;
	private String kategorie;
	private String prioritaet;
	private String beschreibung;

	public DoneDing(String erstellDatum, LocalDate faelligkeitsDatum, LocalDateTime erinnerungsDatum, String titel,
			String kategorie, String prioritaet, String beschreibung) {
		super();
		this.erstellDatum = erstellDatum;
		this.faelligkeitsDatum = faelligkeitsDatum;
		this.erinnerungsDatum = erinnerungsDatum;
		this.titel = titel;
		this.kategorie = kategorie;
		this.prioritaet = prioritaet;
		this.beschreibung = beschreibung;
	}

	public String getErstellDatum() {
		return erstellDatum;
	}

	public void setErstellDatum(String erstellDatum) {
		this.erstellDatum = erstellDatum;
	}

	public LocalDate getFaelligkeitsDatum() {
		return faelligkeitsDatum;
	}

	public void setFaelligkeitsDatum(LocalDate faelligkeitsDatum) {
		this.faelligkeitsDatum = faelligkeitsDatum;
	}

	public LocalDateTime getErinnerungsDatum() {
		return erinnerungsDatum;
	}

	public void setErinnerungsDatum(LocalDateTime erinnerungsDatum) {
		this.erinnerungsDatum = erinnerungsDatum;
	}

	public String getTitel() {
		return titel;
	}

	public void setTitel(String titel) {
		this.titel = titel;
	}

	public String getKategorie() {
		return kategorie;
	}

	public void setKategorie(String kategorie) {
		this.kategorie = kategorie;
	}

	public String getPrioritaet() {
		return prioritaet;
	}

	public void setPrioritaet(String prioritaet) {
		this.prioritaet = prioritaet;
	}

	public String getBeschreibung() {
		return beschreibung;
	}

	public void setBeschreibung(String beschreibung) {
		this.beschreibung = beschreibung;
	}

}