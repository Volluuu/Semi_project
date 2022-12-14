<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link
            href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap"
            rel="stylesheet"
    >
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <style type="text/css">
        div.usermain {
            width: 1500px;
            height: 90vh;
            /*border: 2px solid black;*/
            margin: 0 auto;
        }

        .user_main {
            width: 50%;
            /*border: 1px solid red;*/
            margin: 0 auto;
        }

        #useraddbtn {
            width: 100%;
            height: 50px;
            -webkit-font-smoothing: antialiased;
        }

        #useraddbtn span {
            position: relative;
            top: 5px;
            display: inline-block;
            animation: bounce .5s ease infinite alternate;
            font-size: 20px;
            color: #FFF;
            text-shadow: 0 1px 0 #CCC,
            0 2px 0 #CCC,
            0 3px 0 #CCC,
            0 4px 0 #CCC,
            0 5px 0 #CCC,
            0 6px 0 transparent,
            0 7px 0 transparent,
            0 8px 0 transparent,
            0 9px 0 transparent,
            0 10px 10px rgba(0, 0, 0, .4);
        }

        #useraddbtn span:nth-child(2) {
            animation-delay: .1s;
        }

        #useraddbtn span:nth-child(3) {
            animation-delay: .2s;
        }

        #useraddbtn span:nth-child(4) {
            animation-delay: .3s;
        }

        #useraddbtn span:nth-child(5) {
            animation-delay: .4s;
        }

        #useraddbtn span:nth-child(6) {
            animation-delay: .5s;
        }

        #useraddbtn span:nth-child(7) {
            animation-delay: .6s;
        }

        #useraddbtn span:nth-child(8) {
            animation-delay: .7s;
        }

        @keyframes bounce {
            100% {
                top: -10px;
                text-shadow: 0 1px 0 #CCC,
                0 2px 0 #CCC,
                0 3px 0 #CCC,
                0 4px 0 #CCC,
                0 5px 0 #CCC,
                0 6px 0 #CCC,
                0 7px 0 #CCC,
                0 8px 0 #CCC,
                0 9px 0 #CCC,
                0 50px 25px rgba(0, 0, 0, .2);
            }
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //????????? ?????? ???, .idsuccess ??? ??????
            $("#loginid2").keyup(function () {
                $("#idSuccess").text("");
                var id = $("#loginid2").val();
                if (!id.match(/^[a-zA-Z0-9]{2,10}$/)) {
                    $("#idSuccess").text("????????? ?????? ??????????????????");
                    return;
                }
            });//????????? ?????? event

            //ajax????????? url?????? ?????????(back????????? ???????????? ????????????)
            //???????????? ?????? ??? ????????? ??????
            $("#btnidcheck").click(function () {
                $("#idSuccess").text("");
                var id = $("#loginid2").val();
                if (!id.match(/^[a-zA-Z0-9]{2,10}$/)) {
                    $("#idSuccess").text("????????? ?????? ??????????????????");
                    return;
                }
                $.ajax({
                    type    : "GET",
                    dataType: "text",
                    url     : "loginidcheck?loginid=" + $("#loginid2").val(),
                    success : function (res) {
                        let json = JSON.parse(res);
                        if (json.count == 0) {
                            $("#idSuccess").text("??????????????? ??????????????????");
                        } else {
                            $("#idSuccess").text("?????? ???????????? ??????????????????");
                            alert("?????? ?????????");
                        }

                    }//success
                });//ajax
            });//idcheck
            //????????? ????????? ??????

            //1?????? ???????????? ?????? ??? ??????
            $("#pass").keyup(function () {
                var p1 = $("#pass").val();
                var p2 = $("#pass2").val();
                const regex = /^[a-zA-Z0-9]{8,20}$/;
                if (!regex.test(p1)) {
                    $("#passwordSuccess").text("????????? ?????? ?????????????????? [???????????? ??????] [8??? ?????? 20??? ??????]");

                } else if (p2 == '') {
                    $("#passwordSuccess").text("???????????? ???????????? ??????????????????.");
                } else if (!regex.test(p2) || p1 != p2) {
                    $("#passwordSuccess").text("??????????????? ???????????? ????????????");
                } else {
                    $("#passwordSuccess").text("??????????????? ?????????????????????");
                }
            });//pass2

            //2?????? ???????????? ?????? ??? ??????
            $("#pass2").keyup(function () {
                var p1 = $("#pass").val();
                var p2 = $("#pass2").val();
                const regex = /^[a-zA-Z0-9]{8,20}$/;
                if (!regex.test(p1)) {
                    $("#passwordSuccess").text("????????? ?????? ?????????????????? [???????????? ??????] [8??? ?????? 20??? ??????]");
                } else if (p2 == '') {
                    $("#passwordSuccess").text("????????? ?????? ???????????????.");
                } else if (!regex.test(p2) || p1 != p2) {
                    $("#passwordSuccess").text("??????????????? ???????????? ????????????");
                } else {
                    $("#passwordSuccess").text("??????????????? ?????????????????????");
                }
            });//pass2

            $('#emailSelect').change(function () {
                let emailSelect = $('#emailSelect option:selected').val();
                $('#emailDomain').val(emailSelect);
            });

            //2?????? ???????????? ?????? ??? ??????
            $("#nickname").keyup(function () {
                const regex = /^[???-???|???-???]{2,8}$/;
                var nickname = $('#nickname').val();
                if (regex.test(nickname)) {
                    $('#nicknameSuccess').text("??????????????? ??????????????????");
                } else {
                    $('#nicknameSuccess').text("????????? ?????? ????????????.");
                }
            });

            $("#btnNicknameCheck").click(function () {
                const regex = /^[???-???|???-???]{2,8}$/;
                if (!regex.test($('#nickname').val())) {
                    $('#nicknameSuccess').text("????????? ?????? ????????????.");
                    return;
                }
                $("#nicknameSuccess").text("");
                $.ajax({
                    type    : "GET",
                    dataType: "text",
                    url     : "loginNicknameCheck?nickname=" + $("#nickname").val(),
                    success : function (res) {
                        let json = JSON.parse(res);
                        if (json.count == 0) {
                            $('#nicknameSuccess').text("??????????????? ??????????????????");
                        } else {
                            $("#nicknameSuccess").text("?????? ???????????? ??????????????????");
                            alert("?????? ?????????");
                        }
                    }//success
                });//ajax
            });

            $("#btnRequstCheck").click(function () {
                let correctAuthNum = Math.floor(Math.random() * (999999 - 100000)) + 100000;
                $('#correctAuthNum').val(correctAuthNum);

                $.ajax({
                    type    : "POST",
                    dataType: "text",
                    url     : "send-one?hp=" + $("#hp").val() + "&correctAuthNum=" + correctAuthNum,
                    success : function (res) {
                        console.log(res);
                        let json = JSON.parse(res);
                        console.log(json);
                        if (json.statusCode == 2000) {
                            alert("?????? ????????? ??????????????????.");
                        } else {
                            alert("?????? ????????? ??????????????????.");
                        }
                    }//success
                });//ajax
            });

            $("#btnAuthNumCheck").click(function () {
                if ($('#correctAuthNum').val() == $('#authNum').val()) {
                    $('#hpSuccess').text('????????? ?????????????????????.');
                    alert("????????? ?????????????????????.");
                } else {
                    $('#hpSuccess').text('????????? ?????????????????????.');
                    alert("????????? ?????????????????????.");
                }
            });
        });//$function

        //submit ?????? ??????
        function check() {
            //
            if ($("#idSuccess").text() != '??????????????? ??????????????????') {
                alert("????????? ??????");
                return false;
            }

            if ($("#loginid2").val().includes(' ')) {
                alert("???????????? ????????? ????????????.");
                return false;
            }

            //???????????? ?????? ??????
            if ($("#passwordSuccess").text() != '??????????????? ?????????????????????') {
                alert("??????????????? ?????? ????????????");
                return false;
            }

            if ($("#pass").val().includes(' ') || $("#pass2").val().includes(' ')) {
                alert("??????????????? ????????? ????????????.");
                return false;
            }

            if ($("#nicknameSuccess").text() != '??????????????? ??????????????????') {
                alert("????????? ??????");
                return false;
            }

            if ($("#nickname").val().includes(' ')) {
                alert("???????????? ????????? ????????????.");
                return false;
            }

            let email = $('#email').val();
            let emailDomain = $('#emailDomain').val();
            $('#email').val(email + emailDomain);
            if ($("#email").val().includes(' ')) {
                alert("???????????? ????????? ????????????.");
                return false;
            }

            /*????????? ???????????? ??????*/
            if ($("#hpSuccess").text() != '????????? ?????????????????????.') {
                alert($('#hpSuccess').text());
                return false;
            }

        }//check()

    </script>

</head>
<body>
<div class="usermain">
    <div class="user_main">
        <h1>????????????</h1>
        <input type="hidden" id="correctAuthNum">
        <form action="insert" method="post" enctype="multipart/form-data" onsubmit="return check()">
            <table class="table table-hover">
                <%
                    Object loginChannelObj = session.getAttribute("login_channel");
                    if (loginChannelObj != null) {
                        String loginChannel = (String) loginChannelObj;
                        switch (loginChannel) {
                            case "kakao_id":
                                out.println("<h2 style='font-size: 1em; color: red;'>????????? ID??? ???????????? ????????????.</h2>");
                                break;
                            case "naver_id":
                                out.println("<h2 style='font-size: 1em; color: red;'>????????? ID??? ???????????? ????????????.</h2>");
                                break;
                            default:
                                break;
                        }
                    }
                %>
                <tr>
                    <td>
                        <div>?????????</div>
                        <div class="input-group">
                            <input placeholder="???????????????, ?????? 2-10???" id="loginid2" name="loginid"
                                   class="form-control" required="required"
                                <%
                                if (loginChannelObj != null) {
                                 String loginChannel = (String) loginChannelObj;
                                 switch (loginChannel) {
                                      case "kakao_id":
                                          out.println("value=\"kakao" + (int)(Math.random() * 100000) + "\"");
                                          break;
                                      case "naver_id":
                                          out.println("value=\"naver" + (int)(Math.random() * 100000) + "\"");
                                          break;
                                     default:
                                          break;
                                    }
                                 }
                               %>
                            >
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    id="btnidcheck">????????????
                            </button>
                        </div>
                        <div id="idSuccess"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>????????????</div>
                        <%
                            boolean randomPassword = false;
                            String randomPasswordValue = "rnd";
                            if (loginChannelObj != null) {
                                String loginChannel = (String) loginChannelObj;
                                switch (loginChannel) {
                                    case "kakao_id":
                                    case "naver_id":
                                        randomPassword = true;
                                        for (int i = 0; i < 10; ++i) {
                                            randomPasswordValue += (int) (Math.random() * 10);
                                        }
                                        break;
                                    default:
                                        break;
                                }
                            }
                        %>

                        <input type="password" style="font-family: 'Jua';" class="form-control"
                               name="password" id="pass" placeholder="??????, ?????? 8-20???" maxlength="20"
                               required="required"
                            <%
                                    if (randomPassword) {
                                        out.println("value=\"" + randomPasswordValue + "\"");
                                    }
                               %>
                        >
                        <br>
                        <div>???????????? ??????</div>
                        <input type="password" style="font-family: 'Jua';" class="form-control"
                               id="pass2" placeholder="???????????? ??????" maxlength="20"
                               required="required"
                            <%
                                    if (randomPassword) {
                                        out.println("value=\"" + randomPasswordValue + "\"");
                                    }
                                %>
                        >
                        <div id="passwordSuccess"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>??????</div>
                        <input type="text" name="name" class="form-control"
                               placeholder="??????" required="required"
                            <%
                            Object nameObj = session.getAttribute("loginname");
                            if (nameObj != null) {
                                String name = (String) nameObj;
                                out.println("value=\"" + org.springframework.web.util.HtmlUtils.htmlEscapeHex(name) + "\"");
                            }
                            %>
                        >
                    </td>
                </tr>

                <tr>
                    <td>
                        <div>?????????</div>
                        <div class="input-group">
                            <%
                                Object emailObj = session.getAttribute("email");
                                String[] emailSplitted = null;
                                boolean emailValid = false;
                                if (emailObj != null) {
                                    String email = (String) emailObj;
                                    emailSplitted = email.split("@");
                                    if (emailSplitted.length == 2) {
                                        emailValid = true;
                                    }
                                }
                            %>
                            <input id="email" name="email" class="form-control"
                                   placeholder="?????????" required="required"
                                <%
                                if (emailValid)
                                    out.println("value=\"" + org.springframework.web.util.HtmlUtils.htmlEscapeHex(emailSplitted[0]) + "\"");
                                %>
                            >
                            <input id="emailDomain" name="emailDomain" class="form-control"
                                   placeholder="ex) @naver.com" required="required"
                                <%
                                if (emailValid)
                                    out.println("value=\"" + org.springframework.web.util.HtmlUtils.htmlEscapeHex(emailSplitted[1]) + "\"");
                                %>
                            >
                            <select id="emailSelect" class="form-select">
                                <option value="">????????????</option>
                                <option value="@naver.com">@naver.com</option>
                                <option value="@daum.net">@daum.net</option>
                                <option value="@gmail.com">@gmail.com</option>
                                <option value="@nate.com">@nate.com</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div>????????? ??????</div>
                        <div class="input-group">
                            <input type="text" id="hp" name="hp" placeholder="????????? ?????? (-) ???????????? ??????"
                                   class="form-control" required="required"
                                <%
                                Object loginHpObj = session.getAttribute("loginhp");
                                if (loginHpObj != null) {
                                    String loginHp = (String) loginHpObj;
                                    out.println("value=\"" + org.springframework.web.util.HtmlUtils.htmlEscapeHex(loginHp) + "\"");
                                }
                                %>
                            >
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    id="btnRequstCheck">????????????
                            </button>
                        </div>
                        <br>
                        <div class="input-group">
                            <input type="text" id="authNum"
                                   class="form-control" placeholder="???????????? ??????" required="required">
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    id="btnAuthNumCheck">??????
                            </button>
                        </div>
                        <div id="hpSuccess"></div>

                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div>?????????</div>
                        <div class="input-group">
                            <input type="text" id="nickname" name="nickname" placeholder="?????? 2-8???"
                                   class="form-control" required="required"
                                <%
                                Object nicknameObj = session.getAttribute("nickname");
                                if (nicknameObj != null) {
                                    String nickname = (String) nicknameObj;
                                    out.println("value=\"" + org.springframework.web.util.HtmlUtils.htmlEscapeHex(nickname) + "\"");
                                }
                                %>
                            >
                            <button type="button" class="btn btn-outline-secondary btn-sm"
                                    id="btnNicknameCheck">????????????
                            </button>
                        </div>
                        <div id="nicknameSuccess"></div>
                    </td>
                </tr>
                <tr>
                    <td>
                        ??????
                        <select name="gender" class="form-select">
                            <%
                                Object genderObj = session.getAttribute("gender");
                                String gender = "";
                                if (genderObj != null) {
                                    gender = (String) genderObj;
                                }
                            %>
                            <option value="F"
                                    <%
                                        if (gender.equalsIgnoreCase("F") || gender.equalsIgnoreCase("female")) {
                                            out.println("selected");
                                        }
                                    %>
                            >??????
                            </option>
                            <option value="M"
                                    <%
                                        if (gender.equalsIgnoreCase("M") || gender.equalsIgnoreCase("male")) {
                                            out.println("selected");
                                        }
                                    %>
                            >??????
                            </option>
                        </select>
                        <br>
                        ?????????
                        <select name="age" class="form-select">
                            <%
                                Object ageObj = session.getAttribute("age");
                                String age = "10";
                                if (ageObj != null) {
                                    age = (String) ageObj;
                                }
                            %>
                            <option value="10" <% if (age.length() >= 2 && age.substring(0, 2).equals("10"))
                                out.println("selected"); %> >10???
                            </option>
                            <option value="20" <% if (age.length() >= 2 && age.substring(0, 2).equals("20"))
                                out.println("selected"); %> >20???
                            </option>
                            <option value="30" <% if (age.length() >= 2 && age.substring(0, 2).equals("30"))
                                out.println("selected"); %> >30???
                            </option>
                            <option value="40" <% if (age.length() >= 2 && age.substring(0, 2).equals("40"))
                                out.println("selected"); %> >40???
                            </option>
                        </select>
                    </td>

                </tr>

                <tr>
                    <td colspan="2">
                        <button type="submit" class="btn btn-secondary" id="useraddbtn">
                            <span>???</span>
                            <span>???</span>
                            <span>???</span>
                            <span>???</span>
                            <span>G</span>
                            <span>O</span>
                            <span>!</span>
                        </button>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>
<script>
    <%
    if (loginChannelObj != null) {
        String loginChannel = (String) loginChannelObj;
        if (loginChannel.equals("kakao_id") || loginChannel.equals("naver_id")) {
            out.println(
                    "window.addEventListener('load', function (e) {" +
                    "let checkSecondPassword = function () {" +
                    "var p1 = $('#pass').val();" +
                    "var p2 = $('#pass2').val();" +
                "const regex = /^[a-zA-Z0-9]{8,20}$/;" +
                "if (!regex.test(p1)) { " +
                "    $('#passwordSuccess').text('????????? ?????? ??????????????????'); "+
                "} else if (p2 == '') { " +
                "    $('#passwordSuccess').text('????????? ?????? ???????????????.');" +
                "} else if (!regex.test(p2) || p1 != p2) {" +
                "    $('#passwordSuccess').text('??????????????? ???????????? ????????????');"+
                "} else {"+
                "    $('#passwordSuccess').text('??????????????? ?????????????????????');"+
                "}"+
            "}; checkSecondPassword();"+
            "document.getElementById('btnidcheck').click();"+
            "document.getElementById('btnNicknameCheck').click();"+
                    "});"
            );
        }
    }
    %>
</script>
</body>
</html>