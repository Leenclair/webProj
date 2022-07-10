<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc.jsp"%>
<script type="text/javascript">
$(function(){
	$('.table tbody tr').hover(function(){
		$(this).css('background','lightblue');
	}, function(){
		$(this).css('background','');
	});
});

function pageProc(curPage){
	$('input[name=currentPage]').val(curPage);
	$('form[name=frmPage]').submit();
}

function chk_form(){
	$('form[name=frmSearch]').submit();
}

function delChk(){
	alert("해당 글을 삭제하시겠습니까?");
}
	
</script>

<!-- 페이징 처리위한 form -->
<form action="<c:url value='/portal/board/list'/>" method="post" name=frmPage>
	<input type="hidden" name="searchKeyword" value="${param.searchKeyword }">
	<input type="hidden" name="searchCondition" 
		value="${param.searchCondition }">
	<input type="hidden" name="currentPage" >	
</form>

<!-- Content -->

<div class="container-xxl flex-grow-1 container-p-y">
	<h4 class="fw-bold py-3 mb-4">
		자유게시판<span class="text-muted fst-italic fs-6"> / 자유롭게 글을 남겨주세요</span>
	</h4>

	<!-- Basic Bootstrap Table 리스트 반복문 시작 -->
	<div class="card">
		<div class="table-responsive text-nowrap">
			<table class="table">
				<thead>
					<tr>
						<th>Title</th>
						<th>Posted by</th>
						<th>Hit</th>
						<th>Regdate</th>
						<th>enc</th>
					</tr>
				</thead>
				<tbody class="table-border-bottom-0">
				<c:forEach var="vo" items="${list }">
					<tr>
						<td>
							<strong><a href="<c:url value='/portal/board/detail?btNo=${vo.btNo }'/>">${vo.title }</a></strong>
							<c:if test="${vo.FName!=null}">&nbsp;<img alt="파일" src="<c:url value='/image/file.gif'/>"></c:if>
						</td>
						<td>${vo.userid }</td>
						<td><span class="badge bg-label-primary me-1">${vo.hit }</span></td>
						<td><fmt:formatDate value="${vo.regdate }" pattern="yyyy/MM/dd"/></td>
						<td>
						<c:if test="${sessionScope.userid==vo.userid }">
                          <div class="dropdown">
                            <button type="button" class="btn p-0 dropdown-toggle hide-arrow" data-bs-toggle="dropdown">
                              <i class="bx bx-dots-vertical-rounded"></i>
                            </button>
                            <div class="dropdown-menu">
                              <a class="dropdown-item" href="<c:url value='/portal/board/edit?btNo=${vo.btNo }'/>">
                              <i class="bx bx-edit-alt me-1"></i> Edit</a>
                              <a class="dropdown-item" href="<c:url value='/portal/board/delete?btNo=${vo.btNo }'/>"
                              onclick="javascript:delChk()"
                                ><i class="bx bx-trash me-1"></i> Delete</a
                              >
                            </div>
                          </div>
                        </c:if>
                        </td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!--/ Basic Bootstrap Table 리스트 반복문 끝-->

	<!-- 검색form 시작 -->
	<br>
	<nav class="navbar navbar-example navbar-expand-lg bg-light">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbar-ex-4">
				<div class="navbar-nav me-auto"></div>

				<form class="d-flex" name="frmSearch" method="post" 
   					action='<c:url value="/portal/board/list"/>'>
					<select id="selectTypeOpt" class="form-select color-dropdown"
						name="searchCondition">
						<option value="title"
							<c:if test="${param.searchCondition=='title' }">
            		selected="selected"
            	</c:if>>제목</option>
						<option value="content"
							<c:if test="${param.searchCondition=='content' }">
            		selected="selected"
            	</c:if>>내용</option>
						<option value="name"
							<c:if test="${param.searchCondition=='name' }">
            		selected="selected"
            	</c:if>>작성자</option>
					</select>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search..."
							name="searchKeyword" value="${param.searchKeyword}" /> <span
							class="input-group-text">
							<a href="javascript:chk_form()"><i class="tf-icons bx bx-search"></i></a>
							<!-- <button class="tf-icons bx bx-search"></button> -->
							</span>
					</div>
				</form>
			</div>
		</div>
	</nav>
	<!-- 검색form 끝 -->
	<!-- 페이징처리 시작 -->
	<div class="container row" style="float: none; margin:100 auto;">
        <div class="col-md-1" style="float: none; margin:0 auto;">
	<div class="divPage">
		<!-- Basic Pagination -->
		<nav aria-label="Page navigation" class="pagination-section mt-3">
			<ul class="pagination">
				<!-- 이전블록 표시 -->
				<c:if test="${pagingInfo.firstPage>1 }">
					<li class="page-item prev"><a class="page-link" href="#"
						onclick="pageProc(${pagingInfo.firstPage-1})"> <i
							class="tf-icon bx bx-chevron-left"></i>
					</a></li>
				</c:if>
				<!-- 페이지 번호추가 -->
				<c:forEach var="i" begin="${pagingInfo.firstPage}"
					end="${pagingInfo.lastPage }">
					<c:if test="${i==pagingInfo.currentPage }">
						<li class="page-item active"><a class="page-link" href="#"">${i}</a></li>
					</c:if>
					<c:if test="${i!=pagingInfo.currentPage }">
						<li class="page-item"><a class="page-link" href="#"
							onclick="pageProc(${i})">${i}</a></li>
					</c:if>
				</c:forEach>
				<!-- 번호처리 끝 -->

				<!-- 다음블럭 이미지 표시 -->
				<c:if test="${pagingInfo.lastPage < pagingInfo.totalPage }">
					<li class="page-item next"><a class="page-link" href="#" onclick="pageProc(${pagingInfo.lastPage+1})">
							<i class="tf-icon bx bx-chevron-right"></i>
					</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
	</div></div>
	<!-- 페이징처리 끝 -->
	<!-- / Content -->


	<%@ include file="../footer.jsp"%>