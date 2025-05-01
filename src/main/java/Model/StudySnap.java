package Model;

import java.io.Serializable;

public class StudySnap implements Serializable {
	private static final long serialVersionUID = 1L;

	private String datum;
	private String modul;
	private String thema;
	private String inhalt;

	public StudySnap(String datum, String modul, String thema, String inhalt) {
		super();
		this.datum = datum;
		this.modul = modul;
		this.thema = thema;
		this.inhalt = inhalt;
	}

	/**
	 * @return the datum
	 */
	public String getDatum() {
		return datum;
	}

	/**
	 * @param datum the datum to set
	 */
	public void setDatum(String datum) {
		this.datum = datum;
	}

	/**
	 * @return the modul
	 */
	public String getModul() {
		return modul;
	}

	/**
	 * @param modul the modul to set
	 */
	public void setModul(String modul) {
		this.modul = modul;
	}

	/**
	 * @return the thema
	 */
	public String getThema() {
		return thema;
	}

	/**
	 * @param thema the thema to set
	 */
	public void setThema(String thema) {
		this.thema = thema;
	}

	/**
	 * @return the inhalt
	 */
	public String getInhalt() {
		return inhalt;
	}

	/**
	 * @param inhalt the inhalt to set
	 */
	public void setInhalt(String inhalt) {
		this.inhalt = inhalt;
	}

}
