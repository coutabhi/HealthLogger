package com.services;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.entities.Doctor;

public class DoctorService {

	public static List<Doctor> getAllDoctorsByAdminId(Long adminId) {
		List<Doctor> patients = null;
		try {
			Configuration cfg = new Configuration();
			cfg.configure("hibernate.cfg.xml");
			SessionFactory sf = cfg.buildSessionFactory();
			Session session = sf.openSession();
			Transaction trans = session.beginTransaction();
			patients = session.createQuery("FROM Doctor WHERE adminId = :adminId", Doctor.class)
					.setParameter("adminId", adminId).list();
			trans.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return patients;
	}
	
	public void adminLogout(HttpSession httpSession) {
		httpSession.invalidate();
	}
}
