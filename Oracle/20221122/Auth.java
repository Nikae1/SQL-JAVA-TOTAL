package server;

import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import server.beans.AccessHistoryBean;
import server.beans.MemberBean;

/* 로그인, 로그아웃, 접속로그기록 */
public class Auth {
	
	public Auth() {
		
	}
		
	public boolean accessCtl(String clientData) {
		MemberBean member = (MemberBean)this.setBean(clientData);
		System.out.println(clientData);
		boolean accessResult = false;
		DataAccessObject dao = new DataAccessObject();
		Connection connection = null;
		
		connection = dao.openConnection();
		/* p1 : id존재여부 */
		if(this.convertToBool(dao.isMemberId(connection,member))) {
			/* p2 : id와 password 일치여부 */
			if(this.convertToBool(dao.isSame(connection, member))) {
				/* p3 : AccessHistory 기록(1) */
				member.setAccessType(1);
				accessResult = dao.transaction(this.convertToBool(dao.insAccessHistory(connection, member)), connection);				
			}	
		}
		
		/* TRANSACTION MANAGEMENT */
		dao.closeConnection(connection);
			
		return accessResult;
	}
	
	public void accessOut(String clientData) {
		
	}
	
	private boolean convertToBool(int value) {
		return value>0?true:false;
	}
	
	private String getDate(boolean isDate) {
		String pattern = (isDate)? "yyyyMMdd": "yyyyMMddHHmmss";
		return LocalDateTime.now().format(DateTimeFormatter.ofPattern(pattern));
	}
	
	private Object setBean(String clientData) {
		Object object = null;
		String[] splitData = clientData.split("&");
		switch(splitData[0].split("=")[1]) {
		case "-1":
			object = new AccessHistoryBean();
			((AccessHistoryBean)object).setAccessCode(splitData[1].split("=")[1]);
			break;
		case "1":
			object = new MemberBean();
			((MemberBean)object).setAccessCode(splitData[1].split("=")[1]);
			((MemberBean)object).setSecretCode(splitData[2].split("=")[1]);

			break;
		}
				
		return object;
	} 
	
	
}
