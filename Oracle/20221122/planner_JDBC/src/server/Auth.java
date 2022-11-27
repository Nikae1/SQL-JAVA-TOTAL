package server;

import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import server.beans.AccessHistoryBean;
import server.beans.MemberBean;

/* 로그인, 로그아웃, 접속로그기록 */
public class Auth {
	
	public Auth() {
		
	}
		
	/* p2와 p3에서 따로 else값을 잡아주지않는 이유는 boolean accessResult의 초기값이
	 * false값으로 지정되어 있기 때문이다.
	 *  */
	public boolean accessCtl(String clientData) {
		MemberBean dbData = (MemberBean)this.setBean(clientData);
		boolean accessResult = false;
		DataAccessObject dao = new DataAccessObject();
		Connection connection = null;
		
		/* Connection Open & setAutoCommit(false)*/
		connection = dao.openConnection();
		dao.modifyTranStatus(connection, false);
		/* p1 : ID의 존재여부를 확인 
		 * isMemberId(int value) DB로 부터 int값을 받아와 id의 존재여부를 확인하고
		 * convertToBool로 리턴하여 최종적으로 boolean값을 리턴받아온다.
		 * */
		if(this.convertToBool(dao.isMemberId(dbData,connection))) {
			
			/* p2 : id와 password의 일치여부를 확인 */
			if(this.convertToBool(dao.isSame(dbData,connection))) {
				
				/* p3 : AccessHistory에 기록을 남기기(로그인 상태라면 1) 
				 * 최종적으로 로그인이 성공되며, AccessHistory에 로그를 기록하였으므로,
				 * user에게 로그인성공을 보여준다. (true)
				 * */
				if(this.convertToBool(dao.getAccessState(connection, dbData))) {
					dbData.setAccessType(1);
					/* dao.transaction의 리턴값이 boolean값이므로 accessResult의 값으로
					 * 이용이 가능하다. */
					accessResult = dao.transaction(this.convertToBool(dao.insAccessHistory(dbData,connection)), connection);
				}else {
					dbData.setAccessType(-1);
					if(this.convertToBool(dao.insAccessHistory(dbData, connection))) {
						dbData.setAccessType(1);
						accessResult = dao.transaction(this.convertToBool(dao.insAccessHistory(dbData,connection)), connection);
						
					}
				}
					
			}
		}
		
		/* TRANSACTION MANAGEMENT 
		 * connection의 연결과 종료를 담당하는 메소드
		 * */
		dao.modifyTranStatus(connection, true);
		dao.closeConnection(connection);
		
		return accessResult;
	}
	
	/* DB에서 로그인을 위해 가져오는 정보를 boolean값으로 판별하여 리턴하기위한 메소드 
	 * SQL -- COUNT의 통해 1 OR 0값으로 보내오는 정보를 판별
	 * */
	private boolean convertToBool(int value) {
		return value>0? true:false;
	}
	
	
	
	
	
	public void accessOut(String clientData) {
		MemberBean dbData = (MemberBean)this.setBean(clientData);
		DataAccessObject dao = new DataAccessObject();
		Connection connection = null;
		
		/* Connection Open & setAutoCommit(false)*/
		connection = dao.openConnection();
		dao.modifyTranStatus(connection, false);
		
		/* 아이디 존재여부 */
		if(this.convertToBool(dao.isMemberId(dbData, connection))) {
			/* p2 : 로그인 상태 여부 */
			if(this.convertToBool(dao.getAccessState(connection,dbData))) {
				/* p3 : AccessHistory 기록(1) */
				dbData.setAccessType(-1);
				dao.transaction(this.convertToBool(dao.insAccessHistory(dbData, connection)), connection);
			}
				
		}
		
		/* TRANSACTION MANAGEMENT */
		dao.modifyTranStatus(connection, true);
		dao.closeConnection(connection);
		
		
	}
	
	private String getDate(boolean isDate) {
		String pattern = (isDate)? "yyyyMMdd": "yyyyMMddHHmmss";
		return LocalDateTime.now().format(DateTimeFormatter.ofPattern(pattern));
	}
	
	/* */
	private Object setBean(String clientData) {
		Object object = null;
		String[] splitData = clientData.split("&");
		switch(splitData[0].split("=")[1]) {
		case "-1":
			object = new MemberBean();
			((MemberBean)object).setAccessCode(splitData[1].split("=")[1]);
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
