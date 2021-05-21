[TOC]

# Servlet技术

## 简介

* 什么是Servlet？
  * Servlet是javaEE规范之一。规范就是接口。
  * Servlet是javaWeb三大组件之一。三大组件分别是：Servlet程序、Filter过滤器、Listener监听器。
  * Servlet是运行在服务器上的java程序，它可以接受客户端的请求，并响应数据给客户端。

## 实现Servlet

* 编写一个类去实现 Servlet 接口。

* 实现 service 方法，处理请求，并响应数据。

* 到 web.xml 中去配置 servlet 程序的访问地址。

```java
// 实现Servlet接口并实现抽象方法
public class HelloServlet implements Servlet {
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        
    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
}
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <!-- 配置Servlet访问地址 -->
    <servlet>
        <servlet-name>HelloServlet</servlet-name>
        <servlet-class>com.revenge.servlet.Servlet.HelloServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>HelloServlet</servlet-name>
        <!-- / 表示 http://ip:port/当前工程名 -->
        <url-pattern>/helloServlet</url-pattern>
    </servlet-mapping>
</web-app>
```

## Servlet生命周期

1. 执行Servlet构造器。
2. 执行init初始化方法。
3. 执行service方法。
4. 执行destroy方法。

注意：

1. 第一、二步是在第一次访问此servlet类的时候调用，且只会执行一次。
2. 第三步，每次访问都会调用。
3. 第四步，在web工程停止的时候调用。

## 继承HttpServlet实现Servlet

一般在实际项目开发中，都是使用继承 HttpServlet 类的方式去实现 Servlet 程序。

1. 编写一个类去继承 HttpServlet 类。
2. 根据业务需要重写 doGet 或 doPost 方法。
3. 到 web.xml 中的配置 Servlet 程序的访问地址。

```java
// 继承 HttpServlet 类
public class HelleHttpServlet extends HttpServlet {
   // 在GET请求时调用
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }
    // 在POST请求时调用
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
```

```xml
<!--  web.xml 中的配置 Servlet 程序的访问地址-->
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <servlet>
        <servlet-name>HelleHttpServlet</servlet-name>
        <servlet-class>com.revenge.servlet.Servlet.HelleHttpServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>HelloServlet</servlet-name>
        <url-pattern>/helleHttpServlet</url-pattern>
    </servlet-mapping>
</web-app>
```

## Servlet中常用类

### ServletConfig类

#### 简介

* Servlet程序配置信息类。
* Servlet 程序和 ServletConfig 对象都是由 Tomcat 负责创建，我们负责使用。
* Servlet 程序默认是第一次访问的时候创建，ServletConfig 是每个 Servlet 程序创建时，就创建一个对应的 ServletConfig 对 象。

#### 作用

1. 可以获取 Servlet 程序的别名 servlet-name 的值。
2. 获取初始化参数 init-param。
3. 获取 ServletContext 对象。

web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <servlet>
        <servlet-name>HelloServlet</servlet-name>
        <servlet-class>com.revenge.servlet.Servlet.HelloServlet</servlet-class>

        <init-param>
            <param-name>username</param-name>
            <param-value>root</param-value>
        </init-param>
        <init-param>
            <param-name>password</param-name>
            <param-value>12487489</param-value>
        </init-param>

    </servlet>
    <servlet-mapping>
        <servlet-name>HelloServlet</servlet-name>
        <url-pattern>/helloServlet</url-pattern>
    </servlet-mapping>
</web-app>
```

Servlet代码

```java
public class HelloServlet implements Servlet {
    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        // 获取 Init-param 初始化参数
        String username = servletConfig.getInitParameter("username");
        String password = servletConfig.getInitParameter("password");
        System.out.println(username);
        System.out.println(password);
        // 获取Servlet别名 <servlet-name>HelloServlet</servlet-name>
        String servletName = servletConfig.getServletName();
        System.out.println(servletName);
        // 获取ServletContext对象
        ServletContext servletContext = servletConfig.getServletContext();
    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
}
```

### ServletContext类

#### 简介

* ServletContext是一个域对象。
* 什么是域对象？像Map一样存储数据的对象，叫域对象。
* 域值的是存储数据的操作范围，ServletContext的域是整个Web工程。

#### 作用

1. 获取 web.xml 中配置的上下文参数 context-param。
2. 获取当前的工程路径，格式: /工程路径。
3. 获取工程部署后在服务器硬盘上的绝对路径。
4. 像 Map 一样存取数据。

web.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0">
    <context-param>
        <param-name>url</param-name>
        <param-value>www.baidu.com</param-value>
    </context-param>
    <context-param>
        <param-name>Driver</param-name>
        <param-value>com.mysql.jdbc.Driver</param-value>
    </context-param>
    <servlet>
        <servlet-name>HelleHttpServlet</servlet-name>
        <servlet-class>com.revenge.servlet.Servlet.HelleHttpServlet</servlet-class>
    </servlet>
    <servlet-mapping>
        <servlet-name>HelloServlet</servlet-name>
        <url-pattern>/helleHttpServlet</url-pattern>
    </servlet-mapping>
</web-app>
```

Servlet代码

```java
public class HelleHttpServlet extends HttpServlet {
   // 在GET请求时调用
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 在通过继承HttpServlet类的Servlet程序中可以通过以下三中方式获取ServletContext对象
        // 通过Request对象获取
        // ServletContext servletContext = req.getServletContext();
        // 通过ServletConfig对象获取
        // ServletContext servletContext = getServletConfig().getServletContext();
        // 通过getServletContext()方法获取
        ServletContext servletContext = getServletContext();
        // 获取context-param全局初始化参数
        String url = servletContext.getInitParameter("url");
        System.out.println(url);
        String driver = servletContext.getInitParameter("Driver");
        System.out.println(driver);
        // 获取当前工程路径
        String path = servletContext.getContextPath();
        System.out.println(path);
        // 获取当前工程在硬盘上的路径
        String realPath = servletContext.getRealPath("/");
        System.out.println(realPath);
        // 存储数据
        servletContext.setAttribute("key","value");
        // 获取数据
        Object value = servletContext.getAttribute("key");
    }
    // 在POST请求时调用
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
```

### HttpServletRequest类

#### 简介

* HttpServletRequest继承于ServletRequest类。
* 用于存储请求信息的类。

#### 作用

* 每次只要有请求进入 Tomcat 服务器，Tomcat 服务器就会把请求过来的 HTTP 协议信息解析好封装到 Request 对象中。 然后传递到 `service` 方法（doGet 和 doPost）中给我们使用。我们可以通过 `HttpServletRequest` 对象，获取到所有请求的信息。

#### 常用方法

| Method                        | Desc                                         |
| ----------------------------- | -------------------------------------------- |
| getRequestURI()               | 获取请求的资源路径                           |
| getRequestURL()               | 获取请求的统一资源定位符(绝对路径)           |
| getRemoteHost()               | 获取客户端的ip地址                           |
| getHeader()                   | 获取请求头                                   |
| getParameter(key)             | 获取请求的参数                               |
| getParameterValues(key)       | 获取请求的参数(有多个值时使用)               |
| getMethod()                   | 获取请求的方式(GET或POST)                    |
| getRequestDispatcher()        | 获取请求转发对象                             |
| setAttribute(key，value)      | 设置域数据                                   |
| getAttribute(key)             | 获取域数据                                   |
| setCharacterEncoding("UTF-8") | 设置POST请求体的字符集，从而解决中文乱码问题 |

### HttpServletResponse类

#### 简介

* HttpServletResponse 类和 HttpServletRequest 类一样。每次请求进来，Tomcat 服务器都会创建一个 Response 对象传递给 Servlet 程序去使用。
* HttpServletRequest 表示请求过来的信息，HttpServletResponse 表示所有响应的信息， 我们如果需要设置返回给客户端的信息，都可以通过 HttpServletResponse 对象来进行设置。

#### 作用

HttpServletResponse有两个常用的流，用于回传数据给客户端。

| Method            | Return Type         | Desc                               |
| ----------------- | ------------------- | ---------------------------------- |
| getOutputStream() | ServletOutputStream | 字节流，常用与下载(传递二进制数据) |
| getWriter()       | PrintWriter         | 字符流，常用与回传字符串           |

* 注意：两个流同时只能使用一个。 使用了字节流，就不能再使用字符流，反之亦然，否则就会报错。

## 解决中文乱码问题

### Get请求

* 先以IOS-8859-1进行编码。

* 再以UTF-8进行编码。

  ```java
  public class HelleHttpServlet extends HttpServlet {
     // 在GET请求时调用
      @Override
      protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          String key = req.getParameter("key");
          String mkey = new String(key.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
      }
      // 在POST请求时调用
      @Override
      protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          
      }
  }
  ```

  

### Post请求

* 调用Request对象的setCharacterEncoding()方法设置字符集。
* 也可以使用Get请求解决中文乱码的方式解决Post中文乱码问题。

```javascript
public class HelleHttpServlet extends HttpServlet {
   // 在GET请求时调用
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String key = req.getParameter("key");
        String mkey = new String(key.getBytes(StandardCharsets.ISO_8859_1),StandardCharsets.UTF_8);
    }
    // 在POST请求时调用
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String key = req.getParameter("key");
    }
}
```

### 响应

* 方案一（不推荐）
  * 设置服务器字符集(通常为UTF-8)。
  * 通过响应头设置浏览器字符集(通常为UTF-8)。

```java
public class HelleHttpServlet extends HttpServlet {
   // 在GET请求时调用
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setHeader("Context-Type","text/html;charset=UTF-8");
    }
    // 在POST请求时调用
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}
```

* 方案二(推荐使用)
  * 调用Response对象中的setContentType()方法设置字符集。
  * 此方法会同时设置服务器和客户端都使用 UTF-8 字符集，还设置了响应头。
  * 此方法一定要在获取流对象之前调用才有效。

```java
public class HelleHttpServlet extends HttpServlet {
   // 在GET请求时调用
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       // 方案一(不推荐使用)
       // resp.setCharacterEncoding("UTF-8");
       // resp.setHeader("Context-Type","text/html;charset=UTF-8");
        
        // 方案二(推荐使用)
        resp.setContenType("text/html;charset=UTF-8");
    }
    // 在POST请求时调用
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
```

## 请求转发

#### 简介

* 什么是请求的转发?
  * 请求转发是指，服务器收到请求后，从一次资源跳转到另一个资源的操作叫请求转发。
  * GET只能转发GET，POST只能转发POST，就是doGet()转发另一个Servlet程序调用的也是doGet()，POST也是类似。

发请求转发：

```java
public class Servlet1 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("我是Servlet1,我要向Servlet2发起转发");
        request.setAttribute("servlet1","开始交易");
        request.getRequestDispatcher("/servlet2").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
```

接收请求转发：

```java
public class Servlet2 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object attribute = request.getAttribute("servlet1");
        if("开始交易".equals(attribute)){
            System.out.println("交易成功,欢迎下次合作");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
```

## 请求重定向

* 请求重定向，是指客户端给服务器发请求，然后服务器告诉客户端说。我给你一些地址。你去新地址访问。叫请求重定向（因为之前的地址可能已经被废弃）。

  ![image-20210506000249318](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/%E8%AF%B7%E6%B1%82%E9%87%8D%E5%AE%9A%E5%90%91.png)

* 请求重定向的第一种方案： 
  * 设置响应状态码 302 ，表示重定向，（已搬迁） `resp.setStatus(302);`。
  * 设置响应头，说明新的地址在哪里 `resp.setHeader("Location", "/demo/t.jsp");` 

* 请求重定向的第二种方案（推荐使用）： 
  * `resp.sendRedirect("/demo/t.jsp");`
  * 注意：重定向地址参数的第一个"/"表示`http://ip:port/`。

## Base标签

* 设置当前页面中所有相对路径工作时，参照那个路径来进行跳转。简单理解就是，与当前设置的路径为相对路径的参照路径。
* base标签需要在head标签中使用。

## / 斜杠的不同含义

* 在 web 中 / 斜杠是一种绝对路径。 
* / 斜杠 如果被浏览器解析，得到的地址是：`http://ip:port/` 。
  * `<a href="/">斜杠</a>`
* / 斜杠 如果被服务器解析，得到的地址是：`http://ip:port/工程路径`。
  1. `<url-pattern>/servlet1</url-pattern>`
  2. `servletContext.getRealPath(“/”);`
  3. `request.getRequestDispatcher(“/”);` 
* 特殊情况： response.sendRediect(“/”); 把斜杠发送给浏览器解析。得到 `http://ip:port`。

