<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>表达式脚本</title>
</head>
<body>
<%!
    class Student {
        private int id;
        private int age;
        private String name;

        public Student() {
        }

        public Student(int id, int age, String name) {
            this.id = id;
            this.age = age;
            this.name = name;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            this.age = age;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "Student{" +
                    "id=" + id +
                    ", age=" + age +
                    ", name='" + name + '\'' +
                    '}';
        }
    }

    private Map<String, Student> map = new HashMap();

    {
        map.put("小明", new Student(1, 18, "小明"));
        map.put("夏利", new Student(2, 19, "夏利"));
    }
%>
<%--输出基本类型数据--%>
<%= 9999 %><br>
<%= 12.66d %><br>
<%= 88 + 99%><br>
<%--输出字符串--%>
<%= "我是字符串" %><br>
<%--输出对象--%>
<%= map %><br>
<%=map.get("小明")%>
</body>
</html>
