<%--
  Created by IntelliJ IDEA.
  User: hyeongjoon
  Date: 2022/10/03
  Time: 3:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="<%=request.getContextPath()%>"/>
<link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/cafedetail.css">
<link rel="stylesheet" href="../css/star.css">
<link rel="stylesheet" href="../css/footer.css">
<style>

    * {
        font-size: 24px;
        font-family: Dongle;
    }

    html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p,
    blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em,
    img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u,
    i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption,
    tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure,
    figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time,
    mark, audio, video {
        margin: 0;
        padding: 0;
        border: 0;
        font-style: normal;
    }

    div {
        display: block;
    }

    section {
        display: block;
    }

    button.fr {
        float: right;
    }

    .dg_container {
        position: ;
        width: 100%;
        height: 200px;
    }
    .pointer{
        cursor: pointer;
    }

</style>
<script src="https://kit.fontawesome.com/93e75e33a3.js" crossorigin="anonymous"></script>
<html>
<head>
    <title>Title</title>
</head>
<script>
    var trip_num =${dto.trip_num};
    var root = "${root}";
    $(function () {
        triplist();
    });

    function triplist() {
        var loginok = '${sessionScope.loginok}';
        var user_num = '${sessionScope.user_num}';
        var s = "";
        $.ajax({
            type: "get",
            url: root + "/course/tripdetailanswer",
            dataType: "json",
            data: {"trip_num": trip_num, "user_num": user_num},
            success: function (res) {
                $("#answer").html("댓글 갯수 : " + res.list.length);
                $.each(res.list, function (i, elt) {
                    s += "<div class='cafestar'>";
                    s += "닉네임 : " + elt.nickname;
                    if (loginok == 'yes' && user_num == elt.user_num) {
                        s += '<button class="btn btn-outline-dark adel fr" course_num="' + elt.course_num + '">삭제</button>';
                        s += '<button class="btn btn-outline-dark aupd fr" course_num="' + elt.course_num + '">수정</button>';
                    }
                    s += "<p><pre class='cafecontent'>" + elt.content + "</pre>";
                    s += "<span class='day'> 작성일 : " + elt.writeday + "</span>";
                    s += "<span class='star'> 별점 : " + elt.star + "</span>";
                    s += "</p>";
                    s += "</div>";

                });
                if (res.subs == 0) {
                    $("span.subs").html("<i class='fa-regular fa-heart'></i>");
                } else {
                    $("span.subs").html("<i class='fa-solid fa-heart' style='color:red;'></i>");
                }
                $("#review").html(s);
            }
        });


    }
    function starcheck(){
        if($("input[name=star]:checked").length==0){
            alert("별점을 체크해주세요");
            return false;
        }

    }
</script>
<body>

<%---------------------------------------------------------------------------------body--%>
<div class="dPuFYu" id="contents" style="margin-bottom: 66px;" media="web">
    <section direction="vertical" class="hj_mainimg">
        <img src="${dto.photo}">
    </section>
    <div class="hj_bmain">
        <div class="hj_bhead">
            <div class="hj_bbody">
                <div id="title">
                    <h2>${dto.title}</h2>

                </div>
                <div id="topinfo" type="companion" class="iYZztd">
                    <div>
                        <div>
                            <p><img src="../image/location.png" style="width:16px;"> ${dto.addr}</p>
                        </div>
                    </div>
                    <div>
                        <p><img src="../image/coffee.png" style="width:23px;">${dto.content}</p>
                    </div>
                    <div>
                        <span class="subs"></span>
                        <br>
                        <b id="answer"></b>
                        <div id="review"></div>
                    </div>
                </div>
                <script type="text/javascript">
                    $("span.subs").click(function () {
                        var loginok = "${sessionScope.loginok}";
                        var user_num = "${sessionScope.user_num}";
                        var trip_num = "${dto.trip_num}";
                        if (loginok != "yes") {
                            alert("로그인 후 이용가능합니다");
                            return;
                        } else {
                            var heart = $(this).find("i").attr("class");
                            if (heart == 'fa-regular fa-heart') {
                                $(this).find("i").attr("class", "fa-solid fa-heart").css("color", "red");
                                $.ajax({
                                    type: "get",
                                    url: root + "/tripdetail/insertsubs",
                                    dataType: "text",
                                    data: {"user_num": user_num, "trip_num": trip_num},
                                    success: function (res) {
                                    }
                                });
                            } else {
                                $(this).find("i").attr("class", "fa-regular fa-heart").css("color", "black");
                                $.ajax({
                                    type: "get",
                                    url: root + "/tripdetail/deletesubs",
                                    dataType: "text",
                                    data: {"user_num": user_num, "trip_num": trip_num},
                                    success: function (res) {
                                    }
                                });
                            }
                        }
                        //ajax이용해서 좋아요 수 증가 후 출력
                    });
                </script>

                <%--------------------------------------------------------------------------- 별점--%>
                <c:if test="${sessionScope.loginok!=null}">
                    <form class="mb-3" id="myform">
                        <input type="hidden" name="user_num" value="${sessionScope.user_num}">
                        <input type="hidden" name="trip_num" value="${dto.trip_num}">
                        <fieldset>
                            <span class="text-bold">별점을 선택해주세요</span>
                            <input type="radio" name="star" value="5" id="rate1"><label
                                for="rate1">★</label>
                            <input type="radio" name="star" value="4" id="rate2"><label
                                for="rate2">★</label>
                            <input type="radio" name="star" value="3" id="rate3"><label
                                for="rate3">★</label>
                            <input type="radio" name="star" value="2" id="rate4"><label
                                for="rate4">★</label>
                            <input type="radio" name="star" value="1" id="rate5"><label
                                for="rate5">★</label>
                        </fieldset>
                        <div>
		                <textarea class="col-auto form-control" type="text" name="content" id="reviewContents"
                                  placeholder="댓글을 남겨보세요!"></textarea>
                        </div>
                        <button type="button" class="btn btn-outline-dark" id="tripstarbtn" onclick="starcheck()">등록</button>
                        <br>

                    </form>
                </c:if>


                <script>
                    // $(document).on("keyup","#reviewContents",function (e){
                    //     if(e.keyCode==13){
                    //         $("#cafestarbtn").trigger("click");
                    //     }
                    // })

                    $(document).on("click", "#tripstarbtn", function () {
                        var root = "${root}";
                        var user_num = "${sessionScope.user_num}";
                        var star = $("input[name='star']:checked").val();
                        var content = $("#reviewContents").val();
                        $.ajax({
                            type: "get",
                            url: root + "/commentcourse/tripstar",
                            dataType: "text",
                            data: {"user_num": user_num, "star": star, "content": content, "trip_num": trip_num},
                            success: function (res) {
                                triplist();

                                $("#reviewContents").val("");
                            }
                        });
                    });

                </script>
            </div>
        </div>
    </div>
</div>
<div class="dg_container">

</div>


<%--footer--%>
<footer id="footer" class="efLSbp">
    <div class="inner">
        <%--            ----------------logo--%>
        <h6 class="h_logo bjBbfw"><i class="fa-sharp fa-solid fa-car-side icons"></i> 오늘뭐해?</h6>
        <%--    ----------------------------info start--%>
        <div class="finfo info_wrap_horizontal big_gap grey_6A">
            <div>
                <p class="info_bold info_large grey_6A_only">
                    고객센터: 070-8835-2626

                </p>
            </div>
            <p class="info_regular grey_6A_only">
                <em>상담가능시간: 매일 9:00~24:00</em>
            </p>
        </div>
        <%--            -----------------------주식회사 Start--%>
        <div class="Footer__FoldWrapper-sc-190uiip-1 dRbhKq footer_info grey_6A">
                <span>
                    <em>주식회사: 오늘뭐해</em>
                </span>
            <span>
                    <em>대표: 이동건</em>
                </span>
            <span>
                    <em>개인정보보호책임자: 이동건</em>
                </span>
            <span>
                    <em>사업자 등록번호: 010-4154-8185</em>
                </span>
        </div>

        <%--            ----------------------------------------------개인정보Start--%>
        <div class="info_wrap_horizontal vertical_line info_regular grey_6A small_gap font_fix_320">
            <p class="info_bold">개인정보 처리방침</p>
            <p> | 이용약관</p>
            <p> | 취소 및 환불정책</p>
            <p> | 파트너 입점</p>
        </div>

        <%--            ------------------------------copyright--%>
        <div class="middle_gap">
            <p class="copyright">Copyright © 오늘뭐해 Inc. All Rights Reserved.</p>
        </div>
    </div>
</footer>


</body>
</html>
