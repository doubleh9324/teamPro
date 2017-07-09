<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

</head>
<body>

리스트
	<table>
		<thead>
			<tr>
				<th>p_code</th>
				<th>이름</th>
				<th>관</th>
				<th>좌석수</th>
				<th>주소</th>
				<th>연락처</th>
				<th>홈페이지</th>
			</tr>
		</thead>
 				<c:choose>
                <c:when test="${fn:length(placeList) > 0}">
                    <c:forEach items="${placeList }" var="row">
                        <tr>
                            <td>${row.p_code }</td>
                            <td class="title">${row.name }</td>
                            <td>${row.screen_name }</td>
                            <td>${row.capacity }</td>
                            <td>${row.address }</td>
                            <td>${row.contact_num }</td>
                            <td>${row.homepage }</td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4">조회된 결과가 없습니다.</td>
                    </tr>
                </c:otherwise>
           	 </c:choose>
	</table>
</body>
</html>