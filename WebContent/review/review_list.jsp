<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    %>
<%
	String ctxPath =request.getContextPath();
	System.out.println("+"+ctxPath);
%>
<%--jstl 을 사용하기 위해 추가 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

<%--${fn:length(rl)} 를 사용하기 위해 추가 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
	<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap&subset=korean" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=ctxPath %>/assets/css/index.css">
  
	<title>당신의 쓰레기는 안녕하수깡?</title>
	<link rel="struct icon" href="<%=ctxPath %>/assets/img/brsg.ico">
	<style>
	
	.form-control{
	margin-left : 30px; 
	text-align : center;
	}
	.modal-header{
        	background-color:#ADCB00;
            color:#1C4220;
        }  
	
	*{
	    margin: 0;
	    padding: 0;
	}
	.rate {
	    float: left;
	    height: 46px;
	    padding: 0 10px;
	}
	.rate:not(:checked) > input {
	    position:absolute;
	    top:-9999px;
	}
	.rate:not(:checked) > label {
	    float:right;
	    width:1em;
	    overflow:hidden;
	    white-space:nowrap;
	    cursor:pointer;
	    font-size:30px;
	    color:#ccc;
	}
	.rate:not(:checked) > label:before {
	    content: '★ ';
	}
	.rate > input:checked ~ label {
	    color: #ffc700;    
	}
	.rate:not(:checked) > label:hover,
	.rate:not(:checked) > label:hover ~ label {
	    color: #deb217;  
	}
	.rate > input:checked + label:hover,
	.rate > input:checked + label:hover ~ label,
	.rate > input:checked ~ label:hover,
	.rate > input:checked ~ label:hover ~ label,
	.rate > label:hover ~ input:checked ~ label {
	    color: #c59b08;
	}
	/* Modified from: https://github.com/mukulkant/Star-rating-using-pure-css */
	
	th, td { /*안댐*/
		text-overflow:ellipsis; !important
		overflow:hidden; !important
		white-space:nowrap; !important
	}
	.row{
        	padding:10px
        
        }
        
	.gul{
        	padding:8px;
          
        }
        
	#selector {
		width: 100px; !important
	}
	#search {
		width: 200px; !important
	}
	</style>
	
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

	<script>
		// 추가,수정부분에 필요함.
		function ChkRating(n)
		{
			var rating = 'star'.concat(n);
			rating = document.getElementById(rating).value
			alert(rating);
		}
		function fnChkByte(obj, maxByte) 
		{
		    var str = obj.value;
		    var str_len = str.length;
		    
		    var rbyte = 0;
		    var rlen = 0;
		    var one_char = "";
		    var str2 = "";
	
		    for(var i=0; i<str_len; i++)
		    {
		        one_char = str.charAt(i);
		        if(escape(one_char).length > 4)
		        {
		            rbyte += 2;                                         //한글2Byte
		        }
		        else
		        {
		            rbyte++;                                            //영문 등 나머지 1Byte
		        }
		        if(rbyte <= maxByte)
		        {
		            rlen = i+1;                                          //return할 문자열 갯수
		        }
		     }
		     if(rbyte > maxByte)
		     {
			  alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
			  str2 = str.substr(0,rlen);                                  //문자열 자르기
			  obj.value = str2;
			  fnChkByte(obj, maxByte);
		     }
		     else
		     {
		        document.getElementById('byteInfo').innerText = rbyte;
		     }
		}
		function form_submit() {
			alert("등록완료");
		}
		
		//
		var l_serialNo = $("#l_serialNo").text();
		var l_helperID = $("#l_helperID").text();
		var l_reviewTitle = $("#l_reviewTitle").text();
		var l_rating = $("#l_rating").text();
		
		// review list에서만 가능함.
		var mode = 0;
		$(document).ready(function(){
			// 수정 버튼 클릭
			$("button[name='modify']").click(function(){
				var mode = 1; 
				//window.location.href = "#review_Modal_view${vo.serialNo}"
				$('#review_Modal_view').modal('hide');
		   	 	$('#review_Modal_modify').modal('show');	
			});
			
			// 삭제 버튼 클릭
			$("button[name='delete']").click(function(){
				var mode = 0;
				$('#review_Modal_view').modal('hide');
				window.location.href="/GarbageCollector/review_delete.do?serialNo="+$('#info_serialNo').val();
			});
		});
		//rating 선택하지 않았을때 null point오류뜸. 에러잡아야함

	</script>
</head>
<body>
<%@include file="/header.jsp"%>
<main>
<!-- YOUR Content -->
<div class="container" style="padding: 50px 0;">
	<div class="list_header">
		<div class="col-xs-7" style="">
			<h2>소중한 <font style="font-weight: bold;">리뷰</font>를 확인하세요.</h2>
		</div>
		<div class="form-inline col-xs-5"  style="margin: 20px 0 0 0;">
			<div class="form-group">
				<!-- <label for="sel1">필터조건</label> <select class="form-control" id="sel1">-->
				<select class="form-control" id="selector" name="selector">
                  <option value="제목" placeholder="제목">제목</option>
                  <option value="대행자ID">대행자ID</option>
                </select>
            </div>
            <div class="form-group">
                <input type="text" class="form-control" id="search" name="search" placeholder="통합검색" onkeydown="enterSearch()"/><!--검색 텍스트박스-->
                <button type="submit" class="btn"><i class="fa fa-search" href="http://naver.com/">></i></button> <!--검색 버튼-->
			</div>
		</div>
	</div>
		<div class="list_body">
			<div class="review_list">
				<table class="table table-bordered text-center table-hover">
					<thead>
						<tr class="bg-success" style="font-weight: bold;">
							<th class="text-center col-xs-1">신청번호</th>
							<th class="text-center col-xs-2">대행자ID</th>
							<th class="text-center col-xs-5">제목</th>
							<th class="text-center col-xs-2">작성일</th>
							<th class="text-center col-xs-2">평점</th>
						</tr>
					</thead>
					<tbody>
						
						<c:forEach var="vo" items="${rl}">
							<tr>
								<td id="l_serialNo">${vo.serialNo}</td>
								<td id="l_helperID">${vo.helperID}</td>
								<td id="l_reviewTitle"><a data-toggle="modal" id="gul" href="#review_Modal_view${vo.serialNo}">${vo.reviewTitle}</a></td>
								<td id="l_reviewDay">${vo.reviewDay}</td>
								<td id="l_rating">${vo.rating}</td>
								
								<%@include file="/review/review_modal_view.jsp"%>
								<%@include file="/review/review_modal_modify.jsp"%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>


	<!-- Modal -->
		
		
	<!--< %@include file="/review/review_modal_view.jsp"%> -->
	<!-- < %@include file="/review/review_modal_modify.jsp"%> -->
</div>
</main>
	<!-- include 써주기(모달뺴서) -->
<%@include file="/footer.jsp"%>
<%@include file="/script.jsp"%>

</body>
</html>
