// Doctor Entity
package com.entities;

import javax.persistence.*;

import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "doctor")
public class Doctor implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	private Long doctorId;

	private String doctorEmail;

	private String doctorPhoneNo;

	private String doctorPassword;

	private String doctorName;

	private String doctorSpeciality;

	@OneToMany(mappedBy = "doctor", cascade = CascadeType.ALL)
	private List<Patient> patients;

	@Transient
	private int noOfPatients;

	@ManyToOne
	@JoinColumn(name = "adminId")
	private Admin admin;

	// ---------------------- Gettters and Setters-----------

	public String getDoctorSpeciality() {
		return doctorSpeciality;
	}

	public void setDoctorSpeciality(String doctorSpeciality) {
		this.doctorSpeciality = doctorSpeciality;
	}

	public Long getDoctorId() {
		return doctorId;
	}

	public void setDoctorId(Long doctorId) {
		this.doctorId = doctorId;
	}

	public String getDoctorEmail() {
		return doctorEmail;
	}

	public void setDoctorEmail(String doctorEmail) {
		this.doctorEmail = doctorEmail;
	}

	public String getDoctorPhoneNo() {
		return doctorPhoneNo;
	}

	public void setDoctorPhoneNo(String doctorPhoneNo) {
		this.doctorPhoneNo = doctorPhoneNo;
	}

	public String getDoctorPassword() {
		return doctorPassword;
	}

	public void setDoctorPassword(String doctorPassword) {
		this.doctorPassword = doctorPassword;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public List<Patient> getPatients() {
		return patients;
	}

	public void setPatients(List<Patient> patients) {
		this.patients = patients;
	}

	public int getNoOfPatients() {
		return noOfPatients;
	}

	public void setNoOfPatients(int noOfPatients) {
		this.noOfPatients = noOfPatients;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

	// ------------ methods ------------

	public int calculateNoOfPatients() {
		return patients != null ? patients.size() : 0;
	}
}