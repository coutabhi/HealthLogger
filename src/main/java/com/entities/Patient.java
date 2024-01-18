// Patient Entity
package com.entities;

import javax.persistence.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "patient")
public class Patient {
	@Id
	@GeneratedValue
	private Long patientId;

	private String patientName;

	private int patientAge;

	private String patientPhoneNo;

	private String patientEmail;

	@Enumerated(EnumType.STRING)
	private Gender patientGender;

	private String patientDiagnosis;

	private String patientRemarks;

	private Date admittedDate;

	@ManyToOne
	@JoinColumn(name = "doctorId")
	private Doctor doctor;

	@OneToMany(mappedBy = "patient", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
	private List<Vitals> vitals;


	// ------------- Getters and Setter -----------------

	public Long getPatientId() {
		return patientId;
	}

	public void setPatientId(Long patientId) {
		this.patientId = patientId;
	}

	public String getPatientName() {
		return patientName;
	}

	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}

	public int getPatientAge() {
		return patientAge;
	}

	public void setPatientAge(int patientAge) {
		this.patientAge = patientAge;
	}

	public String getPatientPhoneNo() {
		return patientPhoneNo;
	}

	public void setPatientPhoneNo(String patientPhoneNo) {
		this.patientPhoneNo = patientPhoneNo;
	}

	public String getPatientEmail() {
		return patientEmail;
	}

	public void setPatientEmail(String patientEmail) {
		this.patientEmail = patientEmail;
	}

	public Gender getPatientGender() {
		return patientGender;
	}

	public void setPatientGender(Gender patientGender) {
		this.patientGender = patientGender;
	}

	public String getPatientDiagnosis() {
		return patientDiagnosis;
	}

	public void setPatientDiagnosis(String patientDiagnosis) {
		this.patientDiagnosis = patientDiagnosis;
	}

	public String getPatientRemarks() {
		return patientRemarks;
	}

	public void setPatientRemarks(String patientRemarks) {
		this.patientRemarks = patientRemarks;
	}

	public Date getAdmittedDate() {
		return admittedDate;
	}

	public void setAdmittedDate(Date admittedDate) {
		this.admittedDate = admittedDate;
	}

	public Doctor getDoctor() {
		return doctor;
	}

	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}

	public List<Vitals> getVitals() {
		return vitals;
	}

	public void setVitals(List<Vitals> vitals) {
		this.vitals = vitals;
	}

	public Patient() {
		this.admittedDate = new Date();
		this.vitals = new ArrayList<>();
	}

}