<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>脚本声明</title>
</head>
<body>
<%!
    // 声明属性
    private int id;
    private String name;
    private Map<String, Object> map;
    private static int count;
%>
<%!
    // 声明代码块
    {
        id = 0;
        name = "";
        map = new HashMap<>();
    }

    static {
        count = 1;
    }
%>

<%!
    // 声明方法
    public int add(int a, int b) {
        return a + b;
    }

    private static int sub(int a, int b) {
        return a - b;
    }
%>
<%!
    // 声明内部类
    class ScriptInner{
        private int id;
        private int age;
        private String name;
        public ScriptInner(){

        }
        public int getId(){
            return this.id;
        }
    }
%>
</body>
</html>
