package server;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.ArrayList;

import server.beans.ToDoBean;

public class TaskManager {

	public TaskManager() {

	}

	/* 특정 계정의 특정 월의 할일이 등록되어 있는 날짜 리스트 가져오기 */

	public String getTodoDateCtl(String clientData) {
		ArrayList<ToDoBean> todoList = null;
		DataAccessObject dao = new DataAccessObject();
        ToDoBean dbData = ((ToDoBean) this.setBean(clientData));
		
        Connection connection = dao.openConnection();
        todoList = dao.gettodoList(connection, dbData);
        dao.closeConnection(connection);

        this.modifyToDoList(todoList);
       
        return this.convertServerData(this.makeDayList(todoList));
     		
	}
	
	
	
	
	public String getToDoListCtl(String clientData) {
		String result = null;
		ArrayList<ToDoBean> todoList = null;
		DataAccessObject dao = new DataAccessObject();
		ToDoBean dbData = ((ToDoBean) this.setBean(clientData));
		
		Connection connection = dao.openConnection();
		
		result = this.convertServerData2(dao.gettodoList2(connection, dbData));
		
				dao.closeConnection(connection);
		return result;
	}

	/*
	 *    개발자      : 김지웅
	 * 메서드기능설명    :  할 일이 등록되어 있는 LIST를 불러오기 위한 메소드
	 * 파라미터 선정이유 :  frontEnd에서 새롭게 만든 clientData를 활용하기 위해
	 * Return Type 선정이유 : gettodoList3을 통해서 얻어진 결과값을 convertServerData2를 통해 String타입으로 리턴받기 때문에 
	 * */
	public String getToDoListCtl2(String clientData) {
		String result = null;
		ArrayList<ToDoBean> todoList = null;
		DataAccessObject dao = new DataAccessObject();
		ToDoBean dbData = ((ToDoBean) this.setBean(clientData));
		
		
		Connection connection = dao.openConnection();
		
		result = this.convertServerData2(dao.gettodoList3(connection, dbData));
		
		dao.closeConnection(connection);
		return result;
	}
	
	
	
	
	
	

	/* DAO로부터 전달받은 TODOLIST의 ENDDATE의 값을 수정 
	 * 달을 넘어가는 경우 STARTDATE의 달의 마지막 달로 출력되도록 수정
	 * */
	private void modifyToDoList(ArrayList<ToDoBean> toDoList) {
		String date = null;
		for(ToDoBean todo : toDoList) {
			date = todo.getStartDate().substring(0, 6);
			
			if( !date.equals(todo.getEndDate().substring(0, 6))) {
				// date를 LocalDate 변환  --> 해당월의 마지막 날 구하기
				// --> endDate를 해당월의 마지막 날로 변경
				todo.setEndDate(
						date + LocalDate.of(Integer.parseInt(date.substring(0, 4)), 
						Integer.parseInt(date.substring(4, 6)),	1).lengthOfMonth());
			
			}
		}
	}
	
	
	/* TODOLIST의 ENDDATE값을 수정하기위해 만든 메소드 */
	private ArrayList<Integer> makeDayList(ArrayList<ToDoBean> toDoList){
		ArrayList<Integer> dayList = new ArrayList<Integer>();
		boolean isSave;
		for(ToDoBean date : toDoList) {
			
			for(int dateIdx=Integer.parseInt(date.getStartDate().substring(6)); 
						dateIdx <= Integer.parseInt(date.getEndDate().substring(6)); 
						dateIdx++) {
				isSave = true;
				for(int listIdx=0; listIdx<dayList.size(); listIdx++) {

					if(dayList.get(listIdx) == dateIdx) {				
						isSave = false;
						break;
					}
				}
				if(isSave) dayList.add(dateIdx);
			}
		}
		return dayList;
	}
    

	private String convertServerData(ArrayList<Integer> list) {
		StringBuffer serverData = new StringBuffer();

		for (int day : list) {
			
			serverData.append(day + ":");
		}

		/* 마지막으로 추가된 항목 삭제 */
		if (serverData.length() != 0) {
			serverData.deleteCharAt(serverData.length() - 1);
		}
		return serverData.toString();
	}

	
	/* TODO의 일정리스트를 출력하기위한 메소드 */
	private String convertServerData2(ArrayList<ToDoBean> list) {
		StringBuffer serverData = new StringBuffer();

		for (ToDoBean todo : list) {
			serverData.append(todo.getAccessCode() != null ? todo.getAccessCode() + "," : "");
			serverData.append(todo.getStartDate() != null ? todo.getStartDate() + "," : "");
			serverData.append(todo.getEndDate() != null ? todo.getEndDate() + "," : "");
			serverData.append(todo.getContents() != null ? todo.getContents() + "," : "");
			serverData.append(todo.getStatus() != null ? todo.getStatus() + "," : "");
			serverData.append(todo.isActive() + ",");
			serverData.append(todo.getComments() != null ? todo.getComments() + "," : "");
			if (serverData.charAt(serverData.length() - 1) == ',') {
				serverData.deleteCharAt(serverData.length() - 1);
			}
			serverData.append(":");
		}

		if (serverData.length() > 0 && serverData.charAt(serverData.length() - 1) == ':') {
			serverData.deleteCharAt(serverData.length() - 1);
		}

		return serverData.toString();
	}

	private Object setBean(String clientData) {
		Object object = null;
		String[] splitData = clientData.split("&");
		switch (splitData[0].split("=")[1]) {
		case "9":
			object = new ToDoBean();
			((ToDoBean) object).setAccessCode(splitData[1].split("=")[1]);
			((ToDoBean) object).setStartDate(splitData[2].split("=")[1]);
			
			break;
		case "12":
			object = new ToDoBean();
			((ToDoBean) object).setAccessCode(splitData[4].split("=")[1]);
			((ToDoBean) object).setStartDate(splitData[1].split("=")[1]);
			((ToDoBean) object).setEndDate(splitData[2].split("=")[1]);
			String visibleType = splitData[3].split("=")[1];
			if (!visibleType.equals("T")) {
				((ToDoBean) object).setVisibleType(visibleType.equals("E") ? "A" : "I");
			}
			break;
		
			/* 신규 
			 * 작성일 : 2022.11.24
			 * 개발자 : 김지웅
			 * 기능 설명
			 * - MODIFY기능의 첫 부분을 수행하기 위해 날짜 정보가 담긴 clientData 정보를 Bean에 담기
			 * */
		case "31" :
			/* SERVICECODE=31&STARTDATE=********&ACCESSCODE=WOONG */
			object = new ToDoBean();
			((ToDoBean) object).setAccessCode(splitData[2].split("=")[1]);
			((ToDoBean) object).setStartDate(splitData[1].split("=")[1]);
			((ToDoBean) object).setEndDate(splitData[1].split("=")[1]);
			
			break;
		case "32" :
			object = new ToDoBean();
			
			
			break;
		case "33" :
			
			break;
		case "34" :
			
			
		case "35" :
			break;
			
		}

		return object;
	}

}
