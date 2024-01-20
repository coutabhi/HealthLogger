package com.services;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.entities.Patient;
import com.entities.Vitals;

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

	public boolean deletePatient(Patient patient) {
		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");
		boolean deleted = false;
		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {
			Transaction trans = session.beginTransaction();

			session.delete(patient);

			trans.commit();
			deleted = true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return deleted;
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

	public static List<Patient> searchPatientsByName(Long doctorId, String patientName) {
		List<Patient> patients = null;
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			SessionFactory sf = cfg.buildSessionFactory();
			Session session = sf.openSession();
			Transaction trans = session.beginTransaction();
			patients = session
					.createQuery("FROM Patient WHERE patientName Like :patientName and doctorId = :doctorId",
							Patient.class)
					.setParameter("patientName", "%" + patientName + "%").setParameter("doctorId", doctorId).list();
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return patients;
	}

	public List<Vitals> getVitalsWithCriticalValues(Long doctorId) {
		List<Vitals> vitalsWithCriticalValues = new ArrayList<>();

		List<Patient> allPatients = getAllPatientsByDoctorId(doctorId);

		for (Patient patient : allPatients) {
			List<Vitals> vitalsList = patient.getVitals();

			for (Vitals vitals : vitalsList) {
				if (hasCriticalVitals(vitals)) {
					vitalsWithCriticalValues.add(vitals);
				}
			}
		}

		return vitalsWithCriticalValues;
	}

	private boolean hasCriticalVitals(Vitals vitals) {
		return vitals.getBp_high() > 160 || vitals.getSpo2() < 90;
	}

}
