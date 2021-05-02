[TOC]

# 简介

## 什么是Jsp？

* Jsp全称java server pages，java的服务器页面。
* Jsp的主要作用是：替代servlet程序回传HTML页面的数据，这样做是因为servlet程序回传html页面数据是一件非常繁琐的事情，开发成本和维护成本极高。

* Jsp页面和html页面一样，都是存放在web目录下，访问也和html页面一样。

## Jsp本质是什么？

* Jsp页面本质上是一个servlet程序。
* 当客户端第一次访问jsp页面的时候，Tomcat服务器都会被jsp页面翻译成一个java源文件，并对它进行编译成.class字节码程序。

# Jsp语法

## Jsp头部page指令

* jsp的page指令可以修改jsp页面中一些重要的属性，或者行为。

  常用属性：

| 属性        | 描述                                                    | 备注                                      |
| ----------- | ------------------------------------------------------- | ----------------------------------------- |
| language    | 指定jsp 翻译后的语言文件类型                            | 暂时只支持 java                           |
| contentType | 指定jsp返回的数据类型                                   | response.setContentType()参数值           |
| pageEncode  | 当前jsp页面的字符集                                     | 一般设置为UTF-8                           |
| import      | 用于导包、导类                                          | 类似于java源代码                          |
| autoFlush   | 设置当前out输出流缓存区满后是否自动刷新                 | 默认值是true，一般不会修改                |
| buffer      | 设置out缓存区的大小                                     | 默认值8kb                                 |
| errorPage   | 设置jsp页面出现运行时出错后自动跳转到指定的错误页面路径 |                                           |
| isErrorPage | 设置当前 jsp 页面是否是错误信息页面。                   | 默认是 false。如果是 true可以获取异常信息 |
| session     | 设置访问当前 jsp 页面，是否会创建 HttpSession 对象。    | 默认值true                                |
| extends     | 设置 jsp 翻译出来的 java 类默认继承那个类               |                                           |

## 声明脚本

* 极少使用。

* 声明脚本的格式是：

  ```jsp
  <%! 声明代码 %>
  ```

* 作用：给翻译出来的java类声明属性、方法、代码块和内部类等。

  jsp文件：

```jsp
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
```

## 表达式脚本

* 常用。

* 格式

  ```jsp
  <%= 表达式 %>
  ```

* 作用：jsp页面输出数据(往客户端回传数据)。

* 特点：

  * 所有的表达式脚本都会被翻译到 `_jspService()` 方法中
  * 表达式脚本都会被翻译成为 `out.print()` 输出到页面上
  * 由于表达式脚本翻译的内容都在`_jspService()` 方法中,所以`_jspService()`方法中的对象都可以直接使用。
  * 表达式脚本中的表达式不能以分号结束。

```jsp
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
        
        ......
            
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
```

注意：表达式脚本输出对象时会调用此对象的toString()方法来进行输出。

## 代码脚本

* 格式：

  ```jsp
  <%
      java语句
  %>
  ```

* 作用：在jsp页面中编写自己需要的功能代码(写的是java语句)。
* 特点：
  * 代码脚本翻译之后都在`_jspService` 方法中。
  * 代码脚本由于翻译到`_jspService()`方法中，所以在`_jspService()`方法中的现有对象都可以直接使用。
  * 还可以由多个代码脚本块组合完成一个完整的 java 语句。
  * 代码脚本还可以和表达式脚本一起组合使用，在 jsp页面上输出数据。

```jsp
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
```

## 代码注释

* java代码注释

  ```java
  // 单行注释
  /*
  多行注释
  */
  ```

* html注释

  ```html
  <!-- html注释 -->
  ```

* jsp注释

  ```jsp
  <%-- jsp注释 --%>
  ```

  

# Jsp九大内置对象

| 对象        | 类型                | 描述               |
| ----------- | ------------------- | ------------------ |
| request     | HttpServletRequest  | 请求对象           |
| response    | HttpServletResponse | 响应对象           |
| pageContext | PageContext         | jsp上下文对象      |
| session     | HttpSession         | 会话对象           |
| application | ServletContext      | ServletContext对象 |
| config      | ServletConfig       | ServletConfig对象  |
| out         | JspWriter           | jsp输出流对象      |
| page        | Object              | 指向当前jsp的对象  |
| exception   | ServletException    | 异常对象           |

# 四大域对象

| 对象        | 类型               | 作用域                                               |
| ----------- | ------------------ | ---------------------------------------------------- |
| pageContext | PageContextImpl    | 当前jsp页面内有效                                    |
| request     | HttpServletRequest | 一次请求内有效                                       |
| session     | HttpSession        | 一个会话内有效(打开浏览器访问服务器，直到关闭浏览器) |
| application | ServletContext     | 整web工程内都有效(web工程不停止，数据一直存在)       |

* 四个域在使用的时候，优先顺序应从小到大：pageContext、request、session、application。

# Jsp中out输出和response.getWriter输出的区别

* esponse 中表示响应，我们经常用于设置返回给客户端的内容（输出） 。
* out 也是给用户做输出使用的。

![image-20210502200037746](D:\Programming\ProgrammingLearningPlace\学习笔记\javaWeb\笔记图片\输出区别)

* out.write() 输出字符串没有问题 。
* out.print() 输出任意数据都没有问题（都转换成为字符串后调用的 write 输出） 。
* 深入源码，浅出结论：在 jsp 页面中，可以统一使用 out.print()来进行输出。

# Jsp常用标签

## 包含

### 静态包含

* 格式

  ```jsp
  <%@ include file="jsp文件路径" %>
  <%--例如--%>
  <%@ include file="/include/footer.jsp"%>
  ```

  * file 属性指定你要包含的 jsp 页面的路径。
  * 地址中第一个斜杠 / 表示为 `http://ip:port/工程路径/` 映射到代码的 web 目录。

* 特点
  * 静态包含不会翻译被包含的 jsp 页面。
  * 静态包含其实是把被包含的 jsp 页面的代码拷贝到包含的位置执行输出。

### 动态包含

* 格式

  ```jsp
  <jsp:include page="jsp文件路径"></jsp:include>
  ```

  * page 属性是指定你要包含的 jsp 页面的路径。
  * 动态包含也可以像静态包含一样，把被包含的内容执行输出到包含位置。

* 特点

  * 动态包含会把包含的 jsp 页面也翻译成为 java 代码。

  * 动态包含底层代码使用如下代码去调用被包含的 jsp 页面执行输出。

    `JspRuntimeLibrary.include(request, response, "/include/footer.jsp", out, false);`

  * 动态包含，还可以传递参数

```jsp
<%--动态包含并传递参数--%>
<jsp:include page="/include/footer.jsp">
    <jsp:param name="username" value="root"></jsp:param>
    <jsp:param name="password" value="12487489"></jsp:param>
</jsp:include>
```

![image-20210502201317532](D:\Programming\ProgrammingLearningPlace\学习笔记\javaWeb\笔记图片\动态包含)

## 请求转发

* 格式

  ```jsp
  <jsp:forward page="请求转发的路径"></jsp:forward>
  <jsp:forward page="/scope.jsp"></jsp:forward>
  ```

  * page 属性设置请求转发的路径。

# Listener监听器

* Listener 监听器它是 JavaWeb 的三大组件之一。JavaWeb 的三大组件分别是：Servlet 程序、Filter 过滤器、Listener 监听器。
* Listener 它是 JavaEE 的规范，就是接口。
* 监听器的作用是，监听某种事物的变化。然后通过回调函数，反馈给客户（程序）去做一些相应的处理。
* 现在很多监听器都不再使用了，还在使用的监听器有ServletContextListener。

## ServletContextListener

* ServletContextListener 它可以监听 ServletContext 对象的创建和销毁。 
* ServletContext 对象在 web 工程启动的时候创建，在 web 工程停止的时候销毁。 
* 监听到创建和销毁之后都会分别调用 ServletContextListener 监听器的方法反馈。
* 作用：一般用于进行web项目的初始化工作。

```java
// ServletContextListener中的两个回调方法
public interface ServletContextListener extends EventListener {
/**
* 在 ServletContext 对象创建之后马上调用，做初始化
*/
public void contextInitialized(ServletContextEvent sce);
/**
* 在 ServletContext 对象销毁之后调用
*/
public void contextDestroyed(ServletContextEvent sce);
}
```

* 如何使用ServletContextListener监听器监听ServletContext对象？
  * 编写一个类去实现ServletContextListener。
  * 实现其两个回调方法。
  * 在web.xml中配置监听器。

实现ServletContextListener
```java
public class MyServletContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("contextInitialized()");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("contextDestroyed()");
    }
}
```

配置web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <listener>
        <listener-class>com.revenge.jsp.Jsp.MyServletContextListener</listener-class>
    </listener>
</web-app>
```