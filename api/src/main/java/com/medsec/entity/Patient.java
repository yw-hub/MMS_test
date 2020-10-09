package com.medsec.entity;

import java.sql.Date;
import java.sql.Timestamp;

@Deprecated
public class Patient {
	private String password;
	private int id;
	private String surname;
	private String firstname;
	private String middlename;
	private Date dob;
	private String email;
	private String street;
	private String suburb;
	private String state;
	private String token;
	private Timestamp token_expire_date;

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getMiddlename() {
		return middlename;
	}

	public void setMiddlename(String middlename) {
		this.middlename = middlename;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getSuburb() {
		return suburb;
	}

	public void setSuburb(String suburb) {
		this.suburb = suburb;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Timestamp getToken_expire_date() {
		return token_expire_date;
	}

	public void setToken_expire_date(Timestamp token_expire_date) {
		this.token_expire_date = token_expire_date;
	}

	@Override
	public String toString() {
		return "Patient{" +
				"password='" + password + '\'' +
				", id=" + id +
				", surname='" + surname + '\'' +
				", firstname='" + firstname + '\'' +
				", middlename='" + middlename + '\'' +
				", dob=" + dob +
				", email='" + email + '\'' +
				", street='" + street + '\'' +
				", suburb='" + suburb + '\'' +
				", state='" + state + '\'' +
				", token='" + token + '\'' +
				", token_expire_date=" + token_expire_date +
				'}';
	}
}
