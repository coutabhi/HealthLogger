package com.services;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.entities.Vitals;

public class VitalsService {

	public void saveVitals(Vitals vitals) {
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");

			try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {
				Transaction trans = session.beginTransaction();

				session.save(vitals);

				trans.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteByVitalId(Long vitalId) {
		Configuration cfg = new Configuration();
		cfg.configure("hibernate.cfg.xml");

		try (SessionFactory sf = cfg.buildSessionFactory(); Session session = sf.openSession()) {
			Transaction trans = session.beginTransaction();

			Vitals vitals = session.get(Vitals.class, vitalId);

			if (vitals != null) {
				vitals.getPatient().getVitals().remove(vitals);

				session.delete(vitals);

				trans.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<Vitals> getVitalsByPatientId(Long patientId) {
		List<Vitals> vitals = null;
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			SessionFactory sf = cfg.buildSessionFactory();
			Session session = sf.openSession();
			Transaction trans = session.beginTransaction();
			vitals = session.createQuery("FROM Vitals WHERE patient.patientId = :patientId", Vitals.class)
					.setParameter("patientId", patientId).list();
			return vitals;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
