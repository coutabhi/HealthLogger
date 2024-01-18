// Vitals Entity
package com.entities;

import javax.persistence.*;

import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
@Table(name = "vitals")
public class Vitals {
	@Id
	@GeneratedValue
	private Long vitalId;

	private int bp_high;

	private int bp_low;

	private int spo2;

	private Date recordedDate;

	@ManyToOne
	@JoinColumn(name = "patientId")
	private Patient patient;
	
	
	// ---------- Getters and Setters -----------------

	public Long getVitalId() {
		return vitalId;
	}

	public void setVitalId(Long vitalId) {
		this.vitalId = vitalId;
	}

	public int getBp_high() {
		return bp_high;
	}

	public void setBp_high(int bp_high) {
		this.bp_high = bp_high;
	}

	public int getBp_low() {
		return bp_low;
	}

	public void setBp_low(int bp_low) {
		this.bp_low = bp_low;
	}

	public int getSpo2() {
		return spo2;
	}

	public void setSpo2(int spo2) {
		this.spo2 = spo2;
	}

	public Date getRecordedDate() {
		return recordedDate;
	}

	public void setRecordedDate(Date recordedDate) {
		this.recordedDate = recordedDate;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(Patient patient) {
		this.patient = patient;
	}

	public Vitals() {
		this.recordedDate = new Date();
	}
	
	public String getRecordedDateFormatted() {
	    // Format the date as needed, for example:
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    return sdf.format(recordedDate);
	}

}