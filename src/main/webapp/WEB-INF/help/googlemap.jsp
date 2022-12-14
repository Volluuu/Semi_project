<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Anton&family=Dancing+Script:wght@600&family=Dongle&family=Edu+VIC+WA+NT+Beginner:wght@500&family=Gamja+Flower&family=Indie+Flower&family=Jua&family=Merriweather:ital@1&family=Nabla&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@500&family=Palanquin:wght@200&display=swap"
          rel="stylesheet">
    <script type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=975192c3e707d21a2b0a6dda745636ec"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
    />
    <style type="text/css">

        /* 저장된 경로 */
        .mapandselect {
            width: 1500px;
            margin: 0 auto;
        }

        /* 지도 */

        #map {
            width : 730px;
            height: 750px;
        }

        /* 코스 제목 */
        #cos_title {
            width: 300px;
            margin: 0 auto;
            font-size: 15px;
        }

        /* 테마 선택 */
        .cosselect {
            width: 520px;
            position: relative;
            /*border: 1px solid black;*/
        }

        .cosselect_main {
            /*border: 1px solid red;*/
            width: 500px;
            margin-bottom: 10px;
            font-size: 10px;
            /* border-top: solid #ccc 1px; */
            margin-top: 10px;
            position: relative;
            padding-top: 10px;
            padding-bottom: 10px;
            padding-left: 20px;
            border-radius: 30px;
            margin-left: 10px;
            box-shadow: 5px 5px #ccc;
        }

        .cosselect_thema {
            /*border: 1px solid blue;*/
            width: 120px;
            display: inline-block;
            vertical-align: top;
        }

        #cossearch_insert {
            display: inline-block;
            vertical-align: top;
        }

        .searchlist {
           /* border: 1px solid crimson;*/
            width: 370px;
            max-height: 300px;
            display: none;
            position: absolute;
            z-index: 1;
            background-color: white;
            overflow-y: scroll;
        }

        input.in1 {
            width: 280px;
            display: inline-block;
            vertical-align: top;
        }

        button.insert_course_button {
            /*border: 1px solid orange;*/
            width: 50px;
            display: inline-block;
            vertical-align: top;
            justify-content: center;
        }

        .searchwordlist {
            list-style: none;
            margin-bottom: 5px;
        }

        .searchwordlist:hover {
            background-color: gray;
            cursor: pointer;
        }
        .coscnt {
            margin-bottom: 10px;
        }
        /* 버튼 */
        .cosselectadd {
            margin:auto;
            display:block;
            border-radius: 50%;
            background-color: #3db8fa;
            color: white;
            border : none;
            width:50px;
            height:50px;
            font-size: 20px;
            transition: all 0.05s linear;

        }
        .cosselectadd:hover {
            transform: scale(1.1);
        }
        .cosselectbtn {
            position: absolute;
            bottom: 0%;
            right:0%;
            transform:translate(-20%, -50%);
        }

        .cosselectsubstract {
            position: absolute;
            right: 3%;
            border : none;
            border-radius: 50% ;
            background-color: white;
            color: #ccc;
        }
        .cosbtnsave {
            display: inline-block;
            right:0%;
            width: 150px;
            border : none;
            background-color: #3db8fa;
            color: white;
            border-radius: 20px;
            transition: all 0.05s linear;
        }
        .cosbtnsave:hover {
            transform: scale(1.1);
        }

        .set_line {
            display: inline-block;
            left:0%;
            width: 150px;
            border : none;
            background-color: #3db8fa;
            color: white;
            border-radius: 20px;
            transition: all 0.05s linear;
        }
        .set_line:hover {
            transform: scale(1.1);
        }

    .delete_saved_course {
        border : 3px solid #ccc;
        border-left:none;
        background-color: white;
        color: #ccc;
        height: 50px;
        margin-left:-6px;
        font-size: 15px;
        width:40px;
        border-bottom-right-radius: 20px;
        border-top-right-radius: 20px;
        display: inline-block;
    }

        .call_course_button {
            border:none;
            width: 200px;
            background-color: #3db8fa;
            font-size: 15px;
            height:50px;
            color:white;
            border-bottom-left-radius: 20px;
            border-top-left-radius: 20px;
            margin-left:5px;
        }
        .save_course_list {
            margin-bottom: 10px;
            position: relative;
            transition: all 0.05s linear;
        }
        .save_course_list:hover {
            transform: scale(1.05);
        }
        .savehistory {
            border: none;
            width: 250px;
            border-radius: 20px;
            box-shadow: 5px 5px 5px 5px #ccc;
        }
    </style>
    <script>
        var cnt = 1;
        var s = "";
        var c = "";
        var stepArr = new Array(5);
        var customArr = new Array(5);
        var mapBound = new Array(5);
        var iwArr = new Array(5);
        var latArr = new Array(5);
        var lngArr = new Array(5);
        var isAdd = [false, false, false, false, false];
        let polyline;
        // 지도에 표시할 선을 생성합니다

        /* 더하기 버튼 추가 시, 입력창 추가 이벤트 */
        $(function () {
            /* +버튼 클릭 시, 경로 추가 이벤트 */
            $(document).on("click", ".cosselectadd", function () {
                if ($("div.cosselect_main").length >= 5) {
                    alert("경로 추가는 최대 5개까지만 가능합니다.");
                    btnChange();
                    return;
                }
                cnt++;
                btnChange();
                s="";
                cosSelectAdd();
                $("div.cos2").append(s);
                s = "";

                for (var i = 0; i < $(".cosselect_main").length; i++) {
                    $(".cosselect_main").eq(i).find(".coscnt").text("경로 " + (i + 1));
                    $(".cosselect_main").eq(i).find(".in1").attr("cnt", (i + 1));
                }
            });

            /* 빼기 버튼 클릭 시, 경로 삭제 이벤트 */
            $(document).on("click", ".cosselectsubstract", function () {
                if ($("div.cosselect_main").length < 2) {
                    alert("첫 경로는 삭제 할 수 없습니다.");
                    return;
                }

                if (confirm($(this).siblings(".coscnt").text() + " 를 삭제하시겠습니까?")) {
                    $(this).parents(".cosselect_main").remove();
                    cnt--;
                    btnChange();
                } else {
                    return;
                }

                for (var i = 0; i < $(".cosselect_main").length; i++) {
                    $(".cosselect_main").eq(i).find(".coscnt").text("경로 " + (i + 1));
                    $(".cosselect_main").eq(i).find(".in1").attr("cnt", (i + 1));
                    $("span.step").eq(i).text("step" + (i + 1));
                }
                var thiscnt = $(this).siblings("div.i").children("input.in1").attr("cnt");
                if (customArr[thiscnt - 1]) { //삭제하려는 경로가 아직 설정되어있지 않은 경우 에러 발생, 예외처리
                    customArr[thiscnt - 1].setMap(null);
                    console.log("set NULL : " + thiscnt);
                }
                customArr[thiscnt - 1] = null;
                stepArr[thiscnt - 1] = null;
                //customArr 배열의 순서를 삭제한것과 동일하게 설정
                let newCustomArr = new Array(5);
                let newStepArr = new Array(5);
                let n = 0;
                for (var i = 0; i < newCustomArr.length; i++) {
                    if (i == (thiscnt - 1)) {
                        continue;
                    }
                    if (!customArr[i]) {
                        n++;
                        continue;
                    }
                    newStepArr[n] = stepArr[i];
                    customArr[i].setContent('<span style="cursor:pointer; font-size: 10px" class="step" cnt=' + (n+1) + '>step' + (n + 1) + '<br><i class="bi bi-pin-fill" style="color:#3db8fa; font-size: 30px"></i></span>');
                    newCustomArr[n++] = customArr[i];
                }
                for (var i = 0; i < customArr.length; i++) {
                    customArr[i] = newCustomArr[i];
                }
                stepArr = newStepArr;
                //1. 위도경도 배열을 삭제한 순서에 맞게 초기화
                n = 0;
                for (var i = 0; i < latArr.length; i++) {
                    if (i == thiscnt - 1) {
                        latArr[i] = lngArr[i] = null;
                        continue;
                    }
                    latArr[n] = latArr[i];
                    lngArr[n++] = lngArr[i];
                }
                console.log(latArr);
                latArr[4] = lngArr[4] = null;
                n = 0;
                //2. 수정한 위도경도 배열을 이용하여 맵바운드, 폴리라인 초기화
                //맵바운드 초기화
                var bounds = new kakao.maps.LatLngBounds();
                for (var i = 0; i < mapBound.length - 1; i++) {
                    if (!latArr[i]) {
                        mapBound[i] = null;
                        continue;
                    }
                    mapBound[i] = new kakao.maps.LatLng(latArr[i], lngArr[i]);
                }
                for (var i = 0; i < mapBound.length - 1; i++) {
                    if (mapBound[i]) {
                        bounds.extend(mapBound[i]);
                        console.log("mapBound : " + i + " is extend");
                    }
                }
                console.log("delete after mapBound : ")
                console.log(mapBound);
                map.setBounds(bounds);
            });

            /* 검색 이벤트 */

            $(document).on("keyup", "input.in1", function () {
                var word = $(this); // parent, children, find 등을 사용하기 위해 #searchword를 특정 시켜준다.
                var txt = word.val();
                if (txt != '') {
                    $(this).next().children().remove();

                    $.ajax({
                        type    : "get",
                        url     : "../course/searchlist",
                        dataType: "json",
                        data    : {
                            "searchthema": word.parent().parent().find("select.sel1").val(),
                            "searchword" : word.val()
                        },
                        success : function (res) {

                            //테마를 3개로 나눠서 검색 시 테이블을 구분해서 가져옴
                            if (word.parent().parent().find("select.sel1").val() == "cafe") {
                                $.each(res, function (i, elt) {
                                    word.next().append(
                                        $('<div>').html("<i class='bi bi-geo-alt-fill'></i>" + elt.title).attr({'cafe_num': elt.cafe_num})
                                    );
                                });
                            }
                            if (word.parent().parent().find("select.sel1").val() == "trip") {
                                $.each(res, function (i, elt) {
                                    word.next().append(
                                        $('<div>').html("<i class='bi bi-geo-alt-fill'></i>" + elt.title).attr({'trip_num': elt.trip_num})
                                    );
                                });
                            }
                            if (word.parent().parent().find("select.sel1").val() == "food") {
                                $.each(res, function (i, elt) {
                                    word.next().append(
                                        $('<div>').html("<i class='bi bi-geo-alt-fill'></i>" + elt.title).attr({'food_num': elt.food_num})
                                    );
                                });
                            }

                            word.next().children().addClass("searchwordlist");
                        }//sucess
                    });//ajax

                } else {
                    $(this).next().children().remove();
                } // if end
            }); // input keyup end

            //검색목록 클릭 시 값이 input tag에 바인드되고 검색창이 꺼지게 하는 이벤트
            $(document).on("click", ".searchwordlist", function () {
                var selectedType = $(this).parent().parent().parent().find("select.sel1").val();
                var step = $(this).parent().siblings("input.in1").attr("cnt") - 1;
                // input tag에 선택한 목적지를 바인드
                $(this).parent().prev().val($(this).text());

                if (selectedType == "cafe") {
                    stepArr[step] = "cafe," + $(this).attr("cafe_num");
                    $(this).parent().siblings("input.in1").attr("isSelect", "yes");
                    $(this).parent().siblings("input.in1").attr("course_num", $(this).attr("cafe_num"));
                }
                if (selectedType == "trip") {
                    stepArr[step] = "trip," + $(this).attr("trip_num");
                    $(this).parent().siblings("input.in1").attr("isSelect", "yes");
                    $(this).parent().siblings("input.in1").attr("course_num", $(this).attr("trip_num"));
                }
                if (selectedType == "food") {
                    stepArr[step] = "food," + $(this).attr("food_num");
                    $(this).parent().siblings("input.in1").attr("isSelect", "yes");
                    $(this).parent().siblings("input.in1").attr("course_num", $(this).attr("food_num"));
                }
                //검색목록이 닫히게 하는 이벤트
                $(this).parent().hide().empty();
            });

            //테마를 선택하지 않고 검색창 클릭시 테마선택으로 이동
            $(document).on("click", "input.in1", function () {
                if ($(this).parent().parent().find("select.sel1 option:selected").text() == "테마 선택") {
                    alert("테마를 먼저 선택해 주세요");
                    $(this).parent().parent().find("select.sel1").focus();
                    return;
                }
                $(this).next().show();
            }); // $(document).on("click", "input.in1", function end

            //마커에 넣을 위도와 경도를 가져오는 이벤트
            // 추가했을 때 추가된 경로인것을 나타내는 문구 추가 하면 좋을 듯 *****************************************************
            $(document).on("click", ".insert_course_button", function () {
                var button = $(this);
                var thiscnt = button.siblings("input.in1").attr("cnt");
                if ($(this).parent().parent().find("select.sel1 option:selected").text() == "테마 선택") {
                    alert("테마를 먼저 선택해 주세요");
                    $(this).parent().parent().find("select.sel1").focus();
                    return;
                }
                if (button.siblings("input.in1").attr("isSelect") == "no" && button.siblings("input.in1").val() == "") {
                    alert("목적지를 먼저 선택해 주세요");
                    button.siblings("input.in1").focus();
                    return;
                }

                if (customArr[thiscnt - 1]) {
                    if (!confirm("해당 경로의 마커가 이미 존재합니다. 기존의 마커를 삭제하고 마커를 새로 생성하시겠습니까?")) {
                        return;
                    }
                    customArr[thiscnt - 1].setMap(null);
                }
                var course_type = button.parent().siblings("div.cosselect_thema").find("select.sel1").val();
                var course_num = button.siblings("input.in1").attr("course_num");
                var step = button.siblings("input.in1").attr("cnt");

                for (var i = 0; i < stepArr.length; i++) {
                    if (i == (step - 1)) {
                        continue;
                    }
                    if (stepArr[i] == (course_type + "," + course_num)) {
                        alert("이미 추가한 경로입니다");
                        button.siblings("input.in1").val("");
                        return;
                    }
                }
                $.ajax({
                    type    : "get",
                    url     : "../course/getlatlon",
                    dataType: "json",
                    data    : {
                        "course_type": course_type,
                        "course_num" : course_num
                    },
                    success : function (res) {
                        //인포 윈도우 생성
                        var iwContent =
                                '<div style="padding:5px; width:200px;">' + res.title + ' <br><a href="https://map.kakao.com/link/map/' + res.title + ',' + res.lat + ',' + res.lon + '" style="color:blue; font-size: 12px;" target="_blank; ">큰지도보기</a>' +
                                '<br><a href="https://map.kakao.com/link/to/' + res.title + ',' + res.lat + ',' + res.lon + '" style="color:blue; font-size: 12px;" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                            iwPosition = new kakao.maps.LatLng(res.lat, res.lon); //인포윈도우 표시 위치입니다
                        iwRemoveable = true;
                        var customContent = '<span style="cursor:pointer; font-size: 10px;" class="step" cnt=' + thiscnt + '>step' + thiscnt + '<br><i class="bi bi-pin-fill" style="color:#3db8fa; font-size: 30px"></i></span>'
                        // 인포윈도우를 생성합니다
                        var custom = new kakao.maps.CustomOverlay({
                            position: iwPosition,
                            content : customContent
                        });
                        customArr[thiscnt - 1] = custom;
                        var detailInfowindow = new kakao.maps.InfoWindow({
                            position : iwPosition,
                            content  : iwContent,
                            removable: iwRemoveable
                        });
                        // *************************스텝1에서 지정한 위치에 커스텀오버레이가 있을 때 다른 스텝에서 해당 장소를 추가하면 이미 경로에 등록되어있다는 alert 출력***************
                        iwArr[thiscnt - 1] = detailInfowindow;
                        custom.setMap(map);

                        //마커가 생성될 때 마다 지도의 범위를 수정
                        var bounds = new kakao.maps.LatLngBounds();
                        var latlng = new kakao.maps.LatLng(res.lat, res.lon);
                        mapBound[thiscnt - 1] = latlng;
                        for (var i = 0; i < mapBound.length; i++) {
                            if (!mapBound[i]) {
                                continue;
                            }
                            bounds.extend(mapBound[i]);
                        }
                        map.setBounds(bounds);

                        $(document).on("click", "span.step", function () {
                            if ($(this).attr("cnt") == thiscnt) {
                                iwArr[thiscnt - 1].open(map);
                            }
                        });
                        //위도 경도 값을 배열에 저장
                        latArr[thiscnt - 1] = res.lat;
                        lngArr[thiscnt - 1] = res.lon;
                        isAdd[thiscnt - 1] = true;
                    }//sucess
                });//ajax
            }); // insert_course_button end
            //목록창이 입력되어 있는 상태에서 테마를 바꾸면 검색목록이 초기화되는 이벤트
            $(document).on("change", "select.sel1", function () {
                var find_in1 = $(this).parent().parent().find("input.in1");
                find_in1.val("");
                find_in1.attr("isSelect", "no");
            });

            //코스를 저장하는 이벤트 : 저장 시 경로들 사이에 null이 있으면 채워달라는 alert 문구 출력
            $(".cosbtnsave").click(function () {
                for (var i = 0; i < stepArr.length; i++) {
                    if (!stepArr[i]) {
                        for (var j = i + 1; j < stepArr.length; j++) {
                            if (stepArr[j]) {
                                alert((i + 1) + "번째 경로가 비어있습니다. 경로삭제 혹은 경로를 추가해주세요.")
                                $("select.sel1").eq(i).focus(); //헤더 바뀐부분 수정완료
                                return;
                            }
                        }

                    }
                }
                console.log($("#cos_title").val().length);
                if ($("#cos_title").val().length > 10) {
                    alert("코스 제목을 10글자 이하로 입력해주세요.")
                    $("#cos_title").focus();
                    return;
                }
                if (!$("#cos_title").val()) {
                    alert("코스 제목을 입력해주세요")
                    $("#cos_title").focus();
                    return;
                }
                for(var i = 0; i < cnt; i++) {
                    if(!stepArr[i]) {
                        alert("추가된 경로가 없습니다. 경로를 추가해 주세요.");
                        return;
                    }
                }
                console.log($(".call_course_button").length);
                for(var i = 0; i < $(".call_course_button").length; i++) {
                    if($(".call_course_button").eq(i).attr("title") ==$("#cos_title").val()) {
                        alert("똑같은 이름의 경로는 등록할 수 없습니다.");
                        return;
                    }
                }
                if (confirm("경로를 [나만의 경로]에 추가하시겠습니까?")) {
                    //페이지 이동하는 부분
                    $.ajax({
                        type    : "post",
                        url     : "../course/insertcourse",
                        dataType: "text",
                        data    : {
                            "step1"   : stepArr[0],
                            "step2"   : stepArr[1],
                            "step3"   : stepArr[2],
                            "step4"   : stepArr[3],
                            "step5"   : stepArr[4],
                            "user_num": ${user_num},
                            "cnt"     : cnt,
                            "title"   : $("#cos_title").val()
                        },
                        success : function (res) {
                            alert("경로가 저장되었습니다.");
                            location.reload();
                            //똑같은 제목을 가진 장바구니 목록이 있으면 return *********************************
                        }//sucess
                    });//ajax
                } else {
                    alert("저장이 취소되었습니다.");
                }
            });

            $(document).on("click", ".call_course_button", function () {
                if(!confirm("["+$(this).attr("title") + "]에 저장된 경로들을 불러올까요?")) {
                    return;
                }
                //불러오기전 초기화
                $(".cos2").empty();
                cnt = 1;
                for (var i = 0; i < customArr.length; i++) {
                    if (customArr[i]) {
                        customArr[i].setMap(null);
                    }
                    customArr[i] = stepArr[i] = latArr[i] = lngArr[i] = null;
                }
                //초기화 끝
                var thiscnt = Number($(this).attr("cnt"));
                for (var i = 1; i < $(this).attr("cnt"); i++) {
                    s = "";
                    cosSelectAdd();
                    cnt++;
                    btnChange();
                    $("div.cos2").append(s);
                }
                $("#cos_title").val($(this).attr("title"));
                let course_type;
                let course_num;
                for (let j = 1; j < thiscnt + 1; j++) { // 헤더 부분 수정되면 변경 **************************************
                    stepArr[j-1] = $(this).attr("step"+j);
                    course_type = $(this).attr("step" + j).substr(0, 4);
                    course_num = Number($(this).attr("step" + j).substr(5));
                    console.log("thiscnt : " + thiscnt);
                    console.log(j + "번째 : " + "course_type : " + course_type + " course_num : " + course_num);
                    if (course_type == "cafe") {
                        $("select.sel1").eq(j - 1).val("cafe");
                        console.log($("select.sel1").eq(j - 1).val());
                    }
                    if (course_type == "food") {
                        $("select.sel1").eq(j - 1).val("food");
                        console.log($("select.sel1").eq(j - 1).val());
                    }
                    if (course_type == "trip") {
                        $("select.sel1").eq(j - 1).val("trip");
                        console.log($("select.sel1").eq(j - 1).val());
                    }
                    $.ajax({
                        type    : "get",
                        url     : "../course/getlatlon",
                        dataType: "json",
                        async   : false,
                        data    : {
                            "course_type": course_type,
                            "course_num" : course_num
                        },
                        success : function (res) {
                            $(".cosselect_main").eq(j - 1).find(".coscnt").text("경로 " + j);
                            $("input.in1").eq(j - 1).val(res.title);
                            $("input.in1").eq(j - 1).attr("isSelect", "yes");
                            $("input.in1").eq(j - 1).attr("course_num", course_num);
                            $("input.in1").eq(j - 1).attr("cnt", j);
                            console.log($("input.in1").eq(j - 1).val());
                            $("button.insert_course_button").eq(j - 1).trigger("click");
                            for (var i = 0; i < mapBound.length; i++) {
                                if (!latArr[i]) {
                                    mapBound[i] = null;
                                    continue;
                                }
                                mapBound[i] = new kakao.maps.LatLng(latArr[i], lngArr[i]);
                            }
                            for (var i = 0; i < mapBound.length; i++) {
                                if (mapBound[i]) {
                                    bounds.extend(mapBound[i]);
                                }
                            }
                        }//sucess
                    });//ajax
                }

            });
        }); //$function end
        $(document).on("click", "button.delete_saved_course", function (){
            var cos_num = Number($(this).siblings(".call_course_button").attr("cos_num"));
            if(confirm("저장되어있는 경로를 삭제하시겠습니까?")) {
                $.ajax({
                    type    : "post",
                    url     : "../course/deletecourse",
                    dataType: "text",
                    data    : {
                        "course_num" : cos_num
                    },
                    success : function (res) {
                        alert("저장된 경로가 삭제되었습니다.");
                        location.reload();
                    }//sucess
                });//ajax
            }
        });
        //경로 그리기
       $(document).on("mouseover", "button.set_line", function (){
           var linePath = new Array(5);
           for(var i = 0; i < lngArr.length; i++) {
               if(lngArr[i]) {
                   linePath[i] = new kakao.maps.LatLng(latArr[i], lngArr[i]);
               }
           }
          polyline = new kakao.maps.Polyline({
               path: linePath, // 선을 구성하는 좌표배열 입니다
               strokeWeight: 6, // 선의 두께 입니다
               strokeColor: '#3c9f47', // 선의 색깔입니다
               strokeOpacity: 1.0, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
               strokeStyle: 'solid' // 선의 스타일입니다
           });

           polyline.setMap(map);
       });
       $(document).on("mouseout", "button.set_line", function (){
           polyline.setMap(null);
       });
        /* 더하기 버튼 추가 시, 입력창 추가 메서드 */
        function cosSelectAdd() {
            s += "<div class='cosselect_main'>";
            s += "<span class='coscnt'></span>";
            s += "<button type='button' class='cosselectsubstract'><i class='fas fa-minus'></i></button>";
            s += "<br>";
            s += "<div class='cosselect_thema'>";
            s += "<select class='form-control sel1' cnt=" + cnt + " name='searchthema'>";
            s += "<option selected='' disabled='' hidden='' class=op1'>테마 선택</option>";
            s += "<option class='op1' value='cafe'>카페</option>";
            s += "<option class='op1' value='food'>음식점</option>";
            s += "<option class='op1' value='trip'>놀거리</option>";
            s += "</select>";
            s += "</div>";
            s += "<div class='i' id='cossearch_insert'>";
            s += "<input type='text' class='form-control in1' placeholder='검색어를 입력' name='searchword' cnt='" + cnt + "' isSelect='no'>";
            s += "<div class='searchlist'></div>";
            s += "<button class='form-control insert_course_button'><i class='fas fa-plus' aria-hidden='true'></i></button>";
            s += "</div>";
            s += "</div>";
        }
        function btnChange() {
            let btn = $("button.cosselectadd");
            if (cnt >=5) {
                btn.css("background-color", "#ccc");
            } else {
                btn.css("background-color", "#3bd8fa");
            }

        }

    </script>
</head>
<body>
<div class="mapandselect">
    <div class="input-group" style="margin-top:10px;">
        <!-- map -->
        <div id="map"></div>

        <script>
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.499442, 127.029023),
                level : 3
            };

            var map = new kakao.maps.Map(container, options);
        </script>
        <!-- 경로설정 -->
        <div class="cosselect">
            <h2 style="text-align: center;">경로설정</h2>
            <input type="text" class="form-control" id="cos_title" placeholder="코스 제목을 10글자 이하로 입력해주세요" name="title"
                   required="required">
            <div class="cosselect_main">
                <span class="coscnt">경로 1</span>
                <button type="button" class="cosselectsubstract"><i class='fas fa-minus'></i></button>
                <br>
                <div class="cosselect_thema">
                    <select class="form-control sel1" required="required" name="searchthema">
                        <option selected="" disabled="" hidden="" class="op1">테마 선택</option>
                        <option class="op1" value="cafe">카페</option>
                        <option class="op1" value="food">음식점</option>
                        <option class="op1" value="trip">놀거리</option>
                    </select>
                </div>
                <div class="i" id="cossearch_insert">
                    <input type="text" class="form-control in1" placeholder="검색어를 입력" required="required" name="searchword" cnt="1" isSelect="no">
                    <div class="searchlist"></div>
                    <button class="form-control insert_course_button"><i class="fas fa-plus" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
            <div class="cos2"></div>
            <button type="button" class="cosselectadd"><i class='fas fa-angle-down'></i></button>


            <!-- 경로설정 버튼 -->
            <div class="cosselectbtn">
                <button type="button" class="set_line">경로보기</button>
                <button type="button" class="cosbtnsave">경로저장</button>
            </div>
        </div>

        <!-- 저장된 경로 -->
        <div class="savehistory">
            <p style="text-align: center; font-size: 18px; margin-top:10px;">저장된 경로들이에요</p>
            <c:forEach var="dto" items="${list}" varStatus="i">
                <div class="save_course_list">
                    <button class="call_course_button" cos_num="${dto.cos_num}" cnt="${dto.cnt}" title="${dto.title}"
                            user_num="${dto.user_num}"
                            step1="${dto.step1}" step2="${dto.step2}" step3="${dto.step3}" step4="${dto.step4}"
                            step5="${dto.step5}"
                            writeday="${dto.writeday}">${dto.title}
                    </button>
                    <button class="delete_saved_course" style="display:inline-block">X</button>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>

</script>
</body>
</html>