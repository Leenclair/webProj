<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//String msg=(String)request.getAttribute("msg");
	//String url=(String)request.getAttribute("url");  //=> /pd/pdEdit.do
	//url = request.getContextPath()+url;//=> /mymvc + /pd/pdEdit.do
%>

<script type="text/javascript">
   alert("${msg}");
   location.href="<c:url value='${url}'/>";
</script>

</body>
</html>



