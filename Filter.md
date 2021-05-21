[TOC]

# 简介

## 什么是Filter过滤器

* Filter 过滤器它是 JavaWeb 的三大组件之一。三大组件分别是：Servlet 程序、Listener 监听器、Filter 过滤器。
* Filter 过滤器它是 JavaEE 的规范。也就是接口。
* Filter 过滤器它的作用是：拦截请求，过滤响应。

## 拦截请求常见的应用场景

* 权限检查
* 日记操作
* 事务管理 
* ……等等

# 使用

1. 编写一个类去实现 Filter 接口
2. 实现过滤方法 doFilter()
3. 到 web.xml 中去配置 Filter 的拦截路径

# 声明周期

Filter的生命周期包含几个方法：

1. 构造方法

2. init初始化方法

   第1、2步，在web工程启动的时候执行(并创建Filter实例对象)。

3. doFilter过滤方法

   第3步，每次拦截到请求就会执行。

4. destroy销毁方法

   第4步，在web工程停止的时候，就会执行(web工程停止，Filter实例对象也会被销毁，由JVM虚拟机回收)。

# FilterConfig类

* FilterConfig 类见名知义，它是 Filter 过滤器的配置文件类。 
* Tomcat 每次创建 Filter 的时候，也会同时创建一个 FilterConfig 类，这里包含了 Filter 配置文件(web.xml文件)的配置信息。

* 作用：
  * 获取 Filter 的名称， filter-name 的内容。
  * 获取在 Filter 中配置的 init-param 初始化参数。
  * 获取 ServletContext 对象。

* 常用方法：

  | Method            | Desc                                         |
  | ----------------- | -------------------------------------------- |
  | getFilterName     | 获取 Filter 的名称，filter-name 的内容       |
  | getInitParameter  | 获取在 Filter 中配置的 init-param 初始化参数 |
  | getServletContext | 获取 ServletContext 对象                     |

# FilterChain类

* FilterChain 就是过滤器链（多个过滤器如何一起工作）。

![image-20210513232100429](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/FilterChain.png)

* 这个类只有一个方法：doFilter(ServletRequest request ,ServletResponse response)

# Filter的拦截路径

## 精确匹配

```xml
<url-pattern>/target.jsp</url-pattern>
以上配置的路径，表示请求地址必须为：http://ip:port/工程路径/target.jsp
```

## 目录匹配

```xml
<url-pattern>/admin/*</url-pattern>
以上配置的路径，表示请求地址必须为：http://ip:port/工程路径/admin/*
```

## 后缀名匹配

```xml
<url-pattern>*.html</url-pattern>
以上配置的路径，表示请求地址必须以.html 结尾才会拦截到
```

注意：Filter 过滤器它只关心请求的地址是否匹配，不关心请求的资源是否存在。