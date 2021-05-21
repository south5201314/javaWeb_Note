[TOC]

# HTTP简介

* 什么是协议？
  * 协议是指双方，或多方，相互约定好，大家都需要遵守的规则，叫协议。

* 所谓 HTTP 协议，就是指，客户端和服务器之间通信时，发送的数据，需要遵守的规则，叫 HTTP 协议。
* HTTP 协议中的数据又叫报文。

# 请求的HTTP协议格式

* 客户端给服务器发送数据叫请求。
*  服务器给客户端回传数据叫响应。
* 常用的请求有两种：GET请求和POST请求。

## GET请求

* 请求行
  * 请求方式                    GET
  * 请求的资源路径 [+?+请求参数]
  * 请求协议的版本号     HTTP/1.1

* 请求头
  * key:value 键值对组成。
  * 不同的键值对所表示的含义不同。

![image-20210430172914444](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/GET%E8%AF%B7%E6%B1%82.png)

## POST请求

* 请求行
  * 请求方式                    POST
  * 请求的资源路径 [+?+请求参数]
  * 请求协议的版本号     HTTP/1.1

* 请求头
  * key:value 键值对组成。
  * 不同的键值对所表示的含义不同。

![image-20210430173426630](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/POST%E8%AF%B7%E6%B1%82.png)

## 常用请求头说明

| 请求头          | 描述                           |
| --------------- | ------------------------------ |
| Accept          | 表示客户端可接收的数据类型     |
| Accept-Language | 表示客户端可接受的语言类型     |
| User-Agent      | 表示客户端浏览器的信息         |
| Host            | 表示请求时的服务器的ip和端口号 |

## 常见的请求

* GET请求
  * form标签 method=“get”。
  * a标签。
  * link标签引入css。
  * Script标签引入js文件。
  * img标签引入图片。
  * iframe标签引入html页面。
  * 浏览器地址栏中输入地址后敲回车。

* POST请求
  * from标签 method=“post”。

# 响应的HTTP响应格式

## 格式

* 响应行
  * 响应的协议和版本号。
  * 协议状态码。
  * 协议状态描述符。

* 响应头
  * key:value 键值对组成。
  * 不同的键值对所表示的含义不同。

* 同行(在响应头和响应体之间有一个空行)。
* 响应体
  * 服务器回传给客户端的数据。

![image-20210430174544794](https://revenge-img.oss-cn-guangzhou.aliyuncs.com/img/%E5%93%8D%E5%BA%94.png)

## 常见的响应码

| 响应码 | 描述                                                   |
| ------ | ------------------------------------------------------ |
| 200    | 表示请求成功                                           |
| 302    | 表示请求重定向                                         |
| 404    | 表示请求服务器已收到，但你要的数据不存在(请求地址错误) |
| 500    | 表示请求服务器已收到，但服务器内部错误(代码错误)       |

# MIME类型说明

* MIME 是 HTTP 协议中数据类型。
* MIME 的英文全称是"Multipurpose Internet Mail Extensions" 多功能 Internet 邮件扩充服务。
* MIME 类型的格式是“大类型/小类型”，并与某一种文件的扩展名相对应。

常见的MIME类型：

| 文件               | 常规类型    | MIME类型                 |
| ------------------ | ----------- | ------------------------ |
| 超文本标记语言文本 | .html、.htm | text/html                |
| 普通文本           | .txt        | text/plain               |
| RTF文本            | .rtf        | application/rtf          |
| GIF图形            | .gif        | imager/gif               |
| JPEG图形           | .jpeg、.jpg | imager/jpeg              |
| AU声音文件         | .au         | audio/basic              |
| MIDI音乐文件       | .mid、midi  | audio/midi、audio/x-midi |
| RealAudio音乐文件  | .ra、ram    | audio/x-pn-realaudio     |
| MPEG文件           | .mpg、mpeg  | video/mpeg               |
| AVI文件            | .avi        | video/x-msvideo          |
| GZIP               | .gz         | application/x-gzip       |
| TAR文件            | .tar        | application/x-tar        |

