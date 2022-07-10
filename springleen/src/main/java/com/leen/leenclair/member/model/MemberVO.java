package com.leen.leenclair.member.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {
	private int no;
	private int grade;
	private String userid;
	private String pwd;
	private String name;
	private Timestamp birth;
	private String email;
	private Timestamp regdate;
	private String address;
	private String addressDetail;
	private int phone1;
	private int phone2;
	private int phone3;
	private Timestamp outdate;
}
