package com.leen.leenclair.comments.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommentsVO {
	private int	cNo;
	private int	btNo;
	private String cId;
	private String cContent;
	private Timestamp cRegdate;
	private int	groupno;
	private int	step;
	private int	sortno;
	private String cDelflag;
	private String editflag;
}
