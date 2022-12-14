<%--
  Created by IntelliJ IDEA.
  User: hyeongjoon
  Date: 2022/10/06
  Time: 10:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="<%=request.getContextPath()%>"/>
<html>
<head>
    <!-- Custom fonts for this template-->
    <link href="../css/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">
    <!-- Custom styles for this template-->
    <link rel="stylesheet" href="../resources/css/admin.css">
    <link href="../css/sb-admin-02.css/sb-admin-2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/admin.css">
    <script src="https://kit.fontawesome.com/93e75e33a3.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <title>AdminPage</title>
</head>

<style>


    table {
        border: 1px #a39485 solid;
        font-size: .9em;
        box-shadow: 0 2px 5px rgba(0, 0, 0, .25);
        width: 100%;
        border-collapse: collapse;
        border-radius: 5px;
        overflow: hidden;
    }

    th {

    }

    thead {
        font-weight: bold;
        color: #fff;
        background: #00E1E3;
    }

    td, th {
        padding: 1em .5em;
        vertical-align: middle;

    }

    td {
        border-bottom: 1px solid rgba(0, 0, 0, .1);
        background: #fff;
    }

    a {
        color: #73685d;
    }

    @media all and (max-width: 768px) {

        table, thead, tbody, th, td, tr {
            display: block;
        }

        th {
            text-align: right;
        }

        table {
            position: relative;
            padding-bottom: 0;
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, .2);
        }

        thead {
            float: left;
            white-space: nowrap;
        }

        tbody {
            overflow-x: auto;
            overflow-y: hidden;
            position: relative;
            white-space: nowrap;
        }

        tr {
            display: inline-block;
            vertical-align: top;
            text-align: center;
        }

        th {
            border-bottom: 1px solid #a39485;
        }

        td {
            border-bottom: 1px solid #e5e5e5;

        }

    }

    .fa-trash {
        cursor: pointer;
        color: red;
    }
</style>
<script>
    var root="${root}";
    $(document).on("click",".fa-trash",function (){
       var user_num=$(this).attr("user_num");
       var name=$(this).attr("name");
       var yes=confirm(user_num+":"+name+"?????? ?????????????????????????");
       if(yes){
           $.ajax({
               type:"get",
               url:root+"/admin/userdelete",
               dataType:"text",
               data:{"user_num":user_num},
               success:function(res){
                   alert("?????????????????????");
                   location.reload();
               }
           });
       }
    });

</script>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

    <!-- Sidebar -->
    <ul class="navbar-nav sidebar sidebar-dark accordion" id="accordionSidebar" style="background-color: #38B6FF">

        <!-- Sidebar - Brand -->
        <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${root}/home">
            <img src="${root}/image/logo1.jpg" style="width: 80px;height: 80px">
            <%--<div class="sidebar-brand-icon rotate-n-15">
                <i class="fas fa-laugh-wink"></i>
            </div>
            <div class="sidebar-brand-text mx-3">?????? ?????? <sup>!?</sup></div>--%>
        </a>

        <!-- Divider -->
        <hr class="sidebar-divider my-0">

        <!-- Nav Item - Dashboard -->
        <li class="nav-item active">
            <a class="nav-link" href="${root}/admin/list">
                <i class="fa-solid fa-table-columns"></i>
                <span>Dashboard</span></a>
        </li>

        <!-- Divider -->
        <hr class="sidebar-divider">

        <!-- Heading -->
        <div class="sidebar-heading">
            Menu
        </div>

        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${root}/admin/userinfo" data-target="#collapseTwo"
               aria-expanded="true" aria-controls="collapseTwo">
                <i class="fa-solid fa-user"></i>
                <span>????????????</span>
            </a>
        </li>

        <!-- Nav Item - Utilities Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${root}/admin/cafecourse" data-target="#collapseUtilities"
               aria-expanded="true" aria-controls="collapseUtilities">
                <i class="fa-solid fa-mug-hot"></i>
                <span>????????????</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="${root}/admin/foodcourse" data-target="#collapseUtilities"
               aria-expanded="true" aria-controls="collapseUtilities">
                <i class="fa-solid fa-bowl-food"></i>
                <span>????????????</span>
            </a>
        </li>

        <li class="nav-item">
            <a class="nav-link collapsed" href="${root}/admin/tripcourse" data-target="#collapseUtilities"
               aria-expanded="true" aria-controls="collapseUtilities">
                <i class="fa-solid fa-plane"></i>
                <span>????????????</span>
            </a>
        </li>


        <!-- Nav Item - Pages Collapse Menu -->
        <li class="nav-item">
            <a class="nav-link collapsed" href="${root}/qna/qnalist" data-target="#collapsePages"
               aria-expanded="true" aria-controls="collapsePages">
                <i class="fa-solid fa-question"></i>
                <span>????????????</span>
            </a>
        </li>


    </ul>
    <!-- End of Sidebar -->

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

        <!-- Main Content -->
        <div id="content">

            <!-- Topbar -->
            <nav class="navbar navbar-expand navbar-light topbar mb-4 static-top shadow"
                 style="background-color: #38B6FF">

                <!-- Sidebar Toggle (Topbar) -->
                <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                    <i class="fa fa-bars"></i>
                </button>


                <ul class="navbar-nav ml-auto">

                    <div class="topbar-divider d-none d-sm-block"></div>

                    <!-- Nav Item - User Information -->
                    <li class="nav-item dropdown no-arrow">
                        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class="fa-solid fa-address-card"></i>&nbsp;
                            <span class="mr-2 d-none d-lg-inline text-gray-600 large">?????????</span>
                        </a>
                    </li>
                </ul>

            </nav>
            <br>
            <div class="searcharea" style="width:100%;text-align:center;">
                <!-- ????????? -->
                <form action="${root}/admin/userinfo">
                    <div class="input-group" style="width:450px; margin-left: 12px;">
                        <select class="form-select" name="searchcolumn" style="border: 1px solid lightgray; font-size: 12px; height: 38px;">
                            <option value="loginid">?????????</option>
                            <option value="name">??????</option>
                            <option value="nickname">?????????</option>
                            <option value="hp">?????????</option>
                            <option value="email">?????????</option>
                        </select>
                        <input type="text" name="searchword" class="form-control" style="width:140px;" placeholder="?????? ??????" value="${param.searchword}">
                        <button type="submit" class="btn btn-success" style="margin-left:10px;">??????</button>
                        <button type="button" class="btn btn-primary" style="margin-left:10px;" onclick="location.href='${root}/admin/userinfo'">????????????</button>
                    </div>
                </form>
            </div>
            <%--10????????? ????????? ??????~!~!~!~!~!~!~!~!~!~!~~#@$@#%#$@^$#&#$*#%^*%^#*$--%>
            <div class="container-fluid">


                <%--??????????????? ????????? ?????????????????????~~~~~~~~~~~~~~~~~~~~~~~~!--%>
                <div class="row">
                    <h7>??? ${totalCount}??? ?????????????????????</h7>
                    <table>
                        <thead>
                        <tr>
                            <th>?????????</th>
                            <th>??????</th>
                            <th>?????????</th>
                            <th>?????????</th>
                            <th>?????????</th>
                            <th>?????????</th>

                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="dto" items="${list}" varStatus="i">
                            <tr>
                                <td>${dto.loginid}</td>
                                <td>${dto.name}</td>
                                <td>${dto.nickname}</td>
                                <td>${dto.hp}</td>
                                <td>${dto.email}</td>
                                <td>${dto.gaipday}&emsp;<i class="fa-sharp fa-solid fa-trash" user_num="${dto.user_num}" name="${dto.name}"></i></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="paging" style="float: right; padding-top: 8px;">
                        <ul class="pagination">
                            <c:if test="${startPage>1}">
                                <li class="page-item"><a href="${root}/admin/userinfo?currentPage=${startPage-1}&searchcolumn=${searchcolumn}&searchword=${searchword}" class="page-link">??????</a></li>
                            </c:if>
                            <!-- ????????? ?????? -->
                            <c:forEach var="pp" begin="${startPage}" end="${endPage}">
                                <c:if test="${pp==currentPage}">
                                    <li class="page-item active"><a class="page-link" href="${root}/admin/userinfo?currentPage=${pp}&searchcolumn=${searchcolumn}&searchword=${searchword}">${pp}</a></li>
                                </c:if>
                                <c:if test="${pp!=currentPage}">
                                    <li class="page-item"><a class="page-link" href="${root}/admin/userinfo?currentPage=${pp}&searchcolumn=${searchcolumn}&searchword=${searchword}">${pp}</a></li>
                                </c:if>

                            </c:forEach>

                            <c:if test="${totalPage>endPage}">
                                <li class="page-item"><a href="${root}/admin/userinfo?currentPage=${endPage+1}&searchcolumn=${searchcolumn}&searchword=${searchword}" class="page-link">??????</a></li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
