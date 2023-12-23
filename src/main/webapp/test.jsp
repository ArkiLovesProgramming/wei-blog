<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<base href="<%=basePath%>">
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="./js/myjs/test.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
    <div id="test"></div>
</body>
</html>
