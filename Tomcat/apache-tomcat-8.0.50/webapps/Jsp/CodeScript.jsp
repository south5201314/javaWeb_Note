<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>代码脚本</title>
</head>
<body>
<%
    if (1 > 2) {
%>
<%="我是个傻逼"%>
<%
} else {
%>
<%="我真是太聪明了"%>
<%
    }
%><br>
<h1 align="center">九九乘法表</h1>
<table align="center">
    <%
        for (int i = 1; i <= 9; i++) {%>
    <tr>
        <%
            for (int j = 1; j <= i; j++) {%>
        <td>
            <%=j + "*" + i + "=" + i * j%>
        </td>
        <%}%>
    </tr>
    <%}%>
</table>
</body>
</html>
