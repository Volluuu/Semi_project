<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="root" value="<%=request.getContextPath()%>"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
  <style type="text/css">
    .qna_main{
      width: 1500px;
      height: 80vh;
      border: 1px solid crimson;
      margin: 0 auto;
    }
    .qna_info{
      width: 200px;
      height: 80vh;
      border: 1px solid black;
      float: left;
    }
    .qna_info a {
      float: right;
      text-decoration: none;
      color: gray;
      font-size: 15px;
    }
    .qna_list{
      width: 1200px;
      border: 1px solid orange;
      display: inline-block;
    }
    .qna_list ul{
    }
    .qna_list li{
      list-style: circle;
    }
  </style>
</head>
<body>
<div class="qna_main">
  <div class="qna_info">
    <h1>고객센터</h1>
    <a href="${root}/qna/noticelist"><p>공지사항</p></a>
    <a href="${root}/qna//faqlist"><p>자주묻는 질문</p></a>
    <a href="${root}/qna/qnalist"><p>1:1 문의사항</p></a>
  </div>
  <div class="qna_list">
    <ul class="qna_title">
      <h3>1:1 문의사항</h3>
      <h3>${subject}</h3>
      <span><fmt:formatDate value="${dto.writeday}" pattern="yyyy-MM-dd"/></span>
      <li class="qna_context">
        ${content}
      </li>
    </ul>
  </div>
</div>
</body>
</html>