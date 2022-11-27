package server;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import server.beans.MemberBean;
import server.beans.ToDoBean;

/* Data File과의 통신 */
public class DataAccessObject {
	private ResultSet rs;
	private PreparedStatement ps;

	public DataAccessObject() {

	}

	/* CONNECTION CREATION */
	/* Oracle과 연결을 하기 위한 CONNECTION 
	 * DAO에서 connection을 만들기는 하였으나 제어는 AUTH에서 맡는다
	 * 
	 * */
	public Connection openConnection() {
		Connection connection = null;
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.0.106:1521:xe","DEVKJW","1234");
		} catch (SQLException e) {
			System.out.println("Error : OracleDriver를 찾을 수 없습니다.");
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			System.out.println("Error : Connect를 연결 할 수 없습니다.");
			e.printStackTrace();
		}
		
		return connection;
	}

	
	/* CONNECTION CLOSE */
	/* isClose는 connection이 모두 닫혀있으면, frue 아니면 false 
	 * [boolean]값을 리턴한다. 그러므로 앞에 !을 붙여 사용한다.*/
	public void closeConnection(Connection connection) {
		try {
			if(connection != null && !connection.isClosed()) {
				if(this.rs != null && !this.rs.isClosed()) this.rs.close();
				if(this.ps != null && !this.ps.isClosed()) this.ps.close();
				connection.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	/* [SEL]ID의 존재여부 확인을 위한 메소드 
	 * DB SQL에서 ID의 존재여부를 확인한 리턴값이 COUNT로 인한 1 OR 0 값이므로, 
	 * INT를 사용하여 리턴한다. (DB의 아이디가 있다면 1, 아니면 0)
	 * MemberBean member에는 
	 * */
	public int isMemberId(MemberBean dbData, Connection connection) {
		this.rs = null;
		/* ?를 사용할 수 있는 건 Preparedstatement를 사용하기 때문 */
		String query ="SELECT COUNT(*) AS ISMRID FROM MR WHERE MR_ID = ?";
		int result = 0;

		try {
			this.ps = connection.prepareStatement(query);
		 
		ps.setNString(1, dbData.getAccessCode());
		this.rs = ps.executeQuery();
		
		while(rs.next()) {
			result = rs.getInt("ISMRID");
		}
		
		}catch (SQLException e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	
	/* [SEL] id와 password의 일치여부를 확인하는 메소드 */
	public int isSame(MemberBean dbData, Connection connection) {
		this.rs = null;
		String query = "SELECT COUNT(*) AS ISACCESS FROM MR WHERE MR_ID = ? AND MR_PW = ?";
		int result = 0;
		
		
		try {
			this.ps = connection.prepareStatement(query);
			ps.setNString(1, dbData.getAccessCode());
			ps.setNString(2, dbData.getSecretCode());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				result = rs.getInt("ISACCESS");
			}
			
		} catch (SQLException e) {
			// TODO: handle exception
		}
		return result;
	}
	
	/* [SEL]ACCESSSTATE */
	public int getAccessState(Connection connection, MemberBean dbData) {
		this.rs = null;
		String query = "SELECT SUM(AH_STATE) AS ISACCESS FROM AH WHERE AH_MRID = ?";
		int result = 0;
		
		try {
			this.ps = connection.prepareStatement(query);
			ps.setNString(1, dbData.getAccessCode());
			rs = ps.executeQuery();
			
			while(rs.next()) {
				result = rs.getInt("ISACCESS");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return result;
	}
	
	
	
	
	
	
	/* [INS] ACCESSHISTORY
	 * DB SQL의 ACCESSHISTORY에 INSERT하기 위한 메소드
	 * 로그인 1, 
	 *  */
	public int insAccessHistory(MemberBean dbData, Connection connection) {
		int result = 0;
		rs = null;
		String query = "INSERT INTO AH(AH_MRID, AH_DATE, AH_STATE) "
				+ "VALUES(?,DEFAULT,?)";
		/* DML connection이기때문에 리턴값이 숫자값으로 반환된다. */
		try {
			this.ps = connection.prepareStatement(query);
			ps.setNString(1, dbData.getAccessCode());
			ps.setInt(2, dbData.getAccessType());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/* TRANSATION COMMIT OR ROLLBACK을 위한 메소드 */
	public boolean transaction (boolean transaction, Connection connection) {
		boolean result = false;
		
		try {
			if(transaction) {
				connection.commit();
				result = true;
			}else 	connection.rollback();

		}catch(SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void modifyTranStatus(Connection connection, boolean status) {
		try {
			if(connection != null && !connection.isClosed())
			connection.setAutoCommit(status);
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
	}
	
	public ArrayList<ToDoBean> gettodoList(Connection connection ,ToDoBean dbData){
		ArrayList<ToDoBean> todoList = new ArrayList<ToDoBean>();
		ToDoBean table = null;
		String query = "SELECT TO_CHAR(TD_DATE, 'YYYYMMDD') AS STARTDATE, "
				+ "TO_CHAR(TD_ENDDATE, 'YYYYMMDD') AS ENDDATE "
				+ "FROM DA.TODO WHERE TD_MRID = ? AND TO_CHAR(TD_DATE,'YYYYMM') = ?";
		
		
		try {
			this.ps = connection.prepareStatement(query);
			this.ps.setNString(1, dbData.getAccessCode());
			this.ps.setNString(2, dbData.getStartDate());
		
			this.rs = this.ps.executeQuery();
			
		
			
			while(this.rs.next()) {
				table = new ToDoBean();
				table.setStartDate(this.rs.getNString("STARTDATE"));
				table.setEndDate(this.rs.getNString("ENDDATE"));
				todoList.add(table);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		

		return todoList;
	}
	
	
	/* 등록된 일정리스트를 가지고 오기위한 메소드 */
	public ArrayList<ToDoBean> gettodoList2(Connection connection, ToDoBean dbData){
		ArrayList<ToDoBean> todoList = new ArrayList<ToDoBean>();
		ToDoBean table2 = null;
		/*  */
		String query = "SELECT * FROM DA.TODOLIST "
				+ "WHERE ACCESSCODE = ? AND "
				+ "(SUBSTR(STARTDATE, 1, 8) >= ? AND SUBSTR(ENDDATE, 1, 8) <= ? ) "
				+(dbData.getVisibleType() == null? "" : " AND ACTIVATION = ?");
		
		try {
			this.ps = connection.prepareStatement(query);
			
			this.ps.setNString(1, dbData.getAccessCode() );
			this.ps.setNString(2, dbData.getStartDate());
			this.ps.setNString(3, dbData.getEndDate());
			/* getVisibleType의 'T'는 모든 것을 포함하는 것이기 때문에 
			 * 따로 특정을 잡아주지 않았다 */
			if(dbData.getVisibleType() != null ) {
				this.ps.setNString(4, dbData.getVisibleType());
			}
			
			
			this.rs = this.ps.executeQuery();
			
			while(this.rs.next()) {
				
			table2 = new ToDoBean();
			table2.setAccessCode(this.rs.getNString("DAYLIST"));
			table2.setStartDate(this.rs.getNString("STARTDATE"));
			table2.setEndDate(this.rs.getNString("ENDDATE"));
			table2.setComments(this.rs.getNString("FEEDBACK"));
			table2.setContents(this.rs.getNString("CONTENT"));
			table2.setStatus(this.rs.getNString("STATE"));
			/* ResultSet으로 받아오는 값이 'A'이면  */
			table2.setActive(this.rs.getNString("ACTIVATION").equals("A")? true : false);
			
			
			todoList.add(table2);
			}
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return todoList;
	}
	
	
	/*
	 *    개발자      : 김지웅
	 * 메서드기능설명    : Modify 기능을 수행하기 위해 리스트를 불러오는 메소드
	 * 파라미터 선정이유 : SQL과 JAVA와의 연동을 위한 CONNECTION과 유저의 입력값을 넣기위한 ToDoBean
	 * Return Type 선정이유 : 크기가 지정되지 않은 값을 넣기위해 ArrayList를 활용하여 SQL DB의 값을 검색하고 저장하여 리턴
	 * */
	public ArrayList<ToDoBean> gettodoList3(Connection connection, ToDoBean dbData){
		ArrayList<ToDoBean> todoList = new ArrayList<ToDoBean>();
		ToDoBean table2 = null;
		/*  */
		String query = "SELECT * FROM DA.TODOLIST "
				+ "WHERE ACCESSCODE = ? AND "
				+ "(SUBSTR(STARTDATE, 1, 8) <= ? AND SUBSTR(ENDDATE, 1, 8) <= ?)";
		
		//"(SUBSTR(STARTDATE, 1, 8) <= ? AND SUBSTR(ENDDATE, 1, 8) <= ?)"
		try {
			this.ps = connection.prepareStatement(query);
			
			this.ps.setNString(1, dbData.getAccessCode());
			this.ps.setNString(2, dbData.getStartDate());
			this.ps.setNString(3, dbData.getStartDate());
			
		/* STARTDATE값밖에 없기때문에 STRATDATE를 두 번 넣어 ENDDATE처럼 비교한다. */			
			
			this.rs = this.ps.executeQuery();
		
			while(this.rs.next()) {
				
			table2 = new ToDoBean();
			table2.setAccessCode(this.rs.getNString("DAYLIST"));
			table2.setStartDate(this.rs.getNString("STARTDATE"));
			table2.setEndDate(this.rs.getNString("ENDDATE"));
			table2.setComments(this.rs.getNString("FEEDBACK"));
			table2.setContents(this.rs.getNString("CONTENT"));
			table2.setStatus(this.rs.getNString("STATE"));
			/* ResultSet으로 받아오는 값이 'A'이면  */
			table2.setActive(this.rs.getNString("ACTIVATION").equals("A")? true : false);
			
			
			todoList.add(table2);
			}
			
			System.out.println("DAO gettodoList3");
			System.out.println(todoList.get(0).getStartDate());
			System.out.println(todoList.get(0).getEndDate());
		
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return todoList;
	}
	
	
}
