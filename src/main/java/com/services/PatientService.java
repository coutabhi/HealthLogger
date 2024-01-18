package com.services;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.entities.Patient;

public class PatientService {

	public static List<Patient> getAllPatientsByDoctorId(Long doctorId) {
		List<Patient> patients = null;
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			SessionFactory sf = cfg.buildSessionFactory();
			Session session = sf.openSession();
			Transaction trans = session.beginTransaction();
			patients = session.createQuery("FROM Patient WHERE doctorId = :doctorId", Patient.class)
					.setParameter("doctorId", doctorId).list();
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return patients;
	}

	public int deletePatient(Long patientId) {
		int result = 0;
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			SessionFactory sf = cfg.buildSessionFactory();
			Session session = sf.openSession();
			Transaction trans = session.beginTransaction();
			result = session.createQuery("DELETE FROM Patient WHERE patientId = :patientId")
					.setParameter("patientId", patientId).executeUpdate();
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public Patient getPatientDetails(Long patientId) {
		Patient patient = null;
		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");

		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {
			Transaction trans = session.beginTransaction();

			// Use uniqueResult() instead of createQuery() to retrieve a single result
			patient = (Patient) session.createQuery("FROM Patient WHERE patientId = :patientId")
					.setParameter("patientId", patientId).uniqueResult();

			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return patient;
	}

	public Patient updatePatient(Patient patient) {
		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");

		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {
			Transaction trans = session.beginTransaction();

			session.update(patient);

			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return patient;
	}
	
	 public static List<Patient> searchPatientsByName(Long DoctorId, String patientName) {
		 List<Patient> patients = null;
		 try {
				Configuration cfg = new Configuration();
				cfg.configure("hibernate.cfg.xml");
				SessionFactory sf = cfg.buildSessionFactory();
				Session session = sf.openSession();
				Transaction trans = session.beginTransaction();
				patients = session.createQuery("FROM Patient WHERE patientName = :patientName and DoctorId = :DoctorId", Patient.class)
						.setParameter("patientName", patientName)
						.setParameter("DoctorId", DoctorId).list();
				trans.commit();
			} catch (Exception e) {
				e.printStackTrace();
			}
		 return patients;
	    }

}
