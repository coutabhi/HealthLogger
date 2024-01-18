package com.services;

import javax.servlet.http.HttpSession;

public class AdminService {
	public void adminLogout(HttpSession httpSession) {
		httpSession.invalidate();
	}
}
