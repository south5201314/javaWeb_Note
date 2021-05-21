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

## pageContext

1. 获取请求协议
2. 获取请求服务器 ip
3. 获取请求服务器端口
4. 获取工程路径
5. 获取请求方法
6. 获取客户端 ip 地址
7. 获取会话的 id 编号

```jsp
<body>
<%--
	request.getScheme() 它可以获取请求的协议
	request.getServerName() 获取请求的服务器 ip 或域名
	request.getServerPort() 获取请求的服务器端口号
	getContextPath() 获取当前工程路径
	request.getMethod() 获取请求的方式（GET 或 POST）
	request.getRemoteHost() 获取客户端的 ip 地址
	session.getId() 获取会话的唯一标识
--%>
<%
	pageContext.setAttribute("req", request);
%>
<%=request.getScheme() %> <br>1.协议： ${ req.scheme }<br>
	2.服务器 ip：${ pageContext.request.serverName }<br>
	3.服务器端口：${ pageContext.request.serverPort }<br>
	4.获取工程路径：${ pageContext.request.contextPath }<br>
	5.获取请求方法：${ pageContext.request.method }<br>
	6.获取客户端 ip 地址：${ pageContext.request.remoteHost }<br>
	7.获取会话的 id 编号：${ pageContext.session.id }<br>
</body>
```



# Jsp中out输出和response.getWriter输出的区别

* esponse 中表示响应，我们经常用于设置返回给客户端的内容（输出） 。
* out 也是给用户做输出使用的。

![输出区别](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/%E8%BE%93%E5%87%BA%E5%8C%BA%E5%88%AB.png)

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

![动态包含](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/%E5%8A%A8%E6%80%81%E5%8C%85%E5%90%AB.png)

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

# EL表达式

## 简介

* EL 表达式的全称是：Expression Language。是表达式语言。 

* 作用：EL 表达式主要是代替 jsp 页面中的表达式脚本在 jsp 页面中进行数据的输出。 因为 EL 表达式在输出数据的时候，要比 jsp 的表达式脚本要简洁很多。

  ```jsp
  <body>
  <%
  request.setAttribute("key","值");
  %>
  表达式脚本输出 key 的值是：
  <%=request.getAttribute("key1")==null?"":request.getAttribute("key1")%><br/>
  EL 表达式输出 key 的值是：${key1}
  </body>
  ```

  * EL 表达式的格式是：${表达式} EL 表达式在输出 null 值的时候，输出的是空串。
  * jsp 表达式脚本输出 null 值的时候，输出的是 null 字符串。

## 搜索域数据的顺序

* EL 表达式主要是在 jsp 页面中输出数据。 主要是输出域对象中的数据。 
* 当四个域中都有相同的 key 的数据的时候，EL 表达式会按照四个域的从小到大的顺序去进行搜索，找到就输出，pageContext、request、session、application。

## 输出Bean对象

Peson类：

```java
public class Person {
// i.需求——输出 Person 类中普通属性，数组属性。list 集合属性和 map 集合属性。
private String name;
private String[] phones;
private List<String> cities;
private Map<String,Object> map;
public int getAge() {
return 18;
}
```

输出的代码：

```jsp
<body>
<%
Person person = new Person();
person.setName("国哥好帅！");
person.setPhones(new String[]{"18610541354","18688886666","18699998888"});
List<String> cities = new ArrayList<String>();
cities.add("北京");
cities.add("上海");
cities.add("深圳");
person.setCities(cities);
Map<String,Object>map = new HashMap<>();
map.put("key1","value1");
map.put("key2","value2");
map.put("key3","value3");
person.setMap(map);pageContext.setAttribute("p", person);
%>
输出 Person：${ p }<br/>
输出 Person 的 name 属性：${p.name} <br>
输出 Person 的 pnones 数组属性值：${p.phones[2]} <br>
输出 Person 的 cities 集合中的元素值：${p.cities} <br>
输出 Person 的 List 集合中个别元素值：${p.cities[2]} <br>
输出 Person 的 Map 集合: ${p.map} <br>
输出 Person 的 Map 集合中某个 key 的值: ${p.map.key3} <br>
输出 Person 的 age 属性：${p.age} <br>
</body>
```

## 运算符

* 关系运算符

  | 关系运算符 | 说明     |
  | ---------- | -------- |
  | == 或 eq   | 等于     |
  | != 或 ne   | 不等于   |
  | < 或 lt    | 小于     |
  | > 或 gt    | 大于     |
  | <= 或le    | 小于等于 |
  | >= 或 ge   | 大于等于 |

* 逻辑运算符

  | 逻辑运算符 | 说明 |
  | ---------- | ---- |
  | && 或 and  | 与   |
  | \|\| 或 or | 或   |
  | ! 或 not   | 非   |

  

* 算数运算符

  | 算数运算符 | 说明 |
  | ---------- | ---- |
  | +          | 加   |
  | -          | 减   |
  | *          | 乘   |
  | / 或div    | 除   |
  | % 或 mod   | 取模 |

  

* 三元运算符

  ```jsp
  表达式 1？表达式 2：表达式 3
  如果表达式 1 的值为真，返回表达式 2 的值，如果表达式 1 的值为假，返回表达式3
  ${ 12 != 12 ? "国哥帅呆":"国哥又骗人啦" }
  ```

  

* 点运算 和 中括号运算符

  *  点运算，可以输出 Bean 对象中某个属性的值。 

  * []中括号运算，可以输出有序集合中某个元素的值。 并且[]中括号运算，还可以输出 map 集合中 key 里含有特殊字符的 key的值。

    ```jsp
    <body>
    <%
    Map<String,Object> map = new HashMap<String, Object>();
    map.put("a.a.a", "aaaValue");
    map.put("b+b+b", "bbbValue");
    map.put("c-c-c", "cccValue");
    request.setAttribute("map", map);
    %>
    ${ map['a.a.a'] } <br>
    ${ map["b+b+b"] } <br>
    ${ map['c-c-c'] } <br>
    </body>
    ```

## 11个隐含对象

| 对象             | 类型               | 描述                                             |
| ---------------- | ------------------ | ------------------------------------------------ |
| pageContext      | PageContextImpl    | 获取 jsp 中的九大内置对象                        |
| pageScope        | Map<String,String> | 获取 pageContext 域中的数据                      |
| requestScope     | Map<String,String> | 获取 Request 域中的数数据                        |
| sessionScope     | Map<String,String> | 获取 Session 域中的数据                          |
| applicationScope | Map<String,String> | 获取 ServletContext 域中的数据                   |
| param            | Map<String,String> | 获取请求参数的值                                 |
| paramValues      | Map<String,String> | 获取请求参数的值，获取多个值的时候使用           |
| header           | Map<String,String> | 获取请求头的信息                                 |
| headerValues     | Map<String,String> | 获取请求头的信息，它可以获取多个值的情况         |
| cookie           | Map<String,String> | 获取当前请求的 Cookie 信息                       |
| initParam        | Map<String,String> | 获取在 web.xml 中配置的<context-param>上下文参数 |

# JSTL标签库

## 简介

* JSTL 标签库 全称是指 JSP Standard Tag Library JSP 标准标签库。是一个不断完善的开放源代码的 JSP 标 签库。 

* EL 表达式主要是为了替换 jsp 中的表达式脚本，而标签库则是为了替换代码脚本。这样使得整个 jsp 页面 变得更佳简洁。

* JSTL 由五个不同功能的标签库组成：

  | 功能范围         | URI                                   | 前缀 |
  | ---------------- | ------------------------------------- | ---- |
  | 核心标签库(重点) | http://java.sun.com/jsp/jstl/core     | c    |
  | 格式化           | http://java.sun.com/jsp/jstl/fmt      | fmt  |
  | 函数             | http://java.sun.com/jsp/jstl/function | fn   |
  | 数据库(不使用)   | http://java.sun.com/jsp/jstl/sql      | sql  |
  | XML(不使用)      | http://java.sun.com/jsp/jstl/xml      | x    |

  * 在 jsp 标签库中使用 taglib 指令引入标签库。

    ```jsp
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    ```

## 使用

* 使用步骤：

  * 先导入 jstl 标签库的 jar 包。 
    * taglibs-standard-impl-1.2.1.jar 
    * taglibs-standard-spec-1.2.1.jar

  * 使用taglib指令引入标签库。

* core核心库的使用

  * `<c:set />`
    * 使用很少
    * 作用：set 标签可以往域中保存数据

  ```jsp
  <%--
  i.<c:set />
  作用：set 标签可以往域中保存数据
  域对象.setAttribute(key,value);
  scope 属性设置保存到哪个域
  page 表示 PageContext 域（默认值）
  request 表示 Request 域
  session 表示 Session 域
  application 表示 ServletContext 域
  var 属性设置 key 是多少
  value 属性设置值
  --%>
  保存之前：${ sessionScope.abc } <br>
  <c:set scope="session" var="abc" value="abcValue"/>
  保存之后：${ sessionScope.abc } <br>
  ```

  * `<c:if />`
    * 作用：用来做 if 判断

  ```jsp
  <%--
  test 属性表示判断的条件（使用 EL 表达式输出）
  --%>
  <c:if test="${ 12 == 12 }">
  <h1>12 等于 12</h1>
  </c:if>
  <c:if test="${ 12 != 12 }">
  <h1>12 不等于 12</h1>
  </c:if>
  ```

  

  *  ` <c:choose> <c:when> <c:otherwise>`
    * 多路判断。跟 switch ... case .... default非常接近

  ```jsp
  <%--
      choose 标签开始选择判断
      when 标签表示每一种判断情况
      test 属性表示当前这种判断情况的值
      otherwise 标签表示剩下的情况
      <c:choose> <c:when> <c:otherwise>标签使用时需要注意的点：
          1、标签里不能使用 html 注释，要使用 jsp 注释
          2、when 标签的父标签一定要是 choose 标签
          --%>
          <%
          request.setAttribute("height", 180);
          %>
          <c:choose>
              <%-- 这是 html 注释 --%>
              <c:when test="${ requestScope.height > 190 }">
                  <h2>小巨人</h2>
              </c:when>
              <c:when test="${ requestScope.height > 180 }">
                  <h2>很高</h2>
              </c:when>
              <c:when test="${ requestScope.height > 170 }">
                  <h2>还可以</h2>
              </c:when><c:otherwise>
              <c:choose>
                  <c:when test="${requestScope.height > 160}">
                      <h3>大于 160</h3>
                  </c:when>
                  <c:when test="${requestScope.height > 150}">
                      <h3>大于 150</h3>
                  </c:when>
                  <c:when test="${requestScope.height > 140}">
                      <h3>大于 140</h3>
                  </c:when>
                  <c:otherwise>
                      其他小于 140
                  </c:otherwise>
              </c:choose>
          </c:otherwise>
          </c:choose>
  ```

  

  * ` <c:forEach />` 
    * 作用：遍历输出使用。

  Student类：

  ```java
  public class Student {
  //4.编号，用户名，密码，年龄，电话信息
      private Integer id;
      private String username;
      private String password;
      private Integer age;
  	private String phone;
      	...
  }
  ```

  jsp：

  ```jsp
  <%--遍历 List 集合---list 中存放 Student 类，有属性：编号，用户名，密码，年龄，电话信息--%>
  <%
  List<Student> studentList = new ArrayList<Student>();
      for (int i = 1; i <= 10; i++) {
      studentList.add(new Student(i,"username"+i ,"pass"+i,18+i,"phone"+i));
      }
      request.setAttribute("stus", studentList);
      %>
      <table>
          <tr>
              <th>编号</th>
              <th>用户名</th>
              <th>密码</th>
              <th>年龄</th>
              <th>电话</th>
              <th>操作</th>
          </tr>
          <%--
          items 表示遍历的集合
          var 表示遍历到的数据
          begin 表示遍历的开始索引值
          end 表示结束的索引值
          step 属性表示遍历的步长值
          varStatus 属性表示当前遍历到的数据的状态
          for（int i = 1; i < 10; i+=2）
          --%>
          <c:forEach begin="2" end="7" step="2" varStatus="status" items="${requestScope.stus}" var="stu">
              <tr>
                  <td>${stu.id}</td>
                  <td>${stu.username}</td>
                  <td>${stu.password}</td>
                  <td>${stu.age}</td>
                  <td>${stu.phone}</td>
                  <td>${status.step}</td>
              </tr>
          </c:forEach>
      </table>
  ```

  