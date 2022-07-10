<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc.jsp"%>
<script type="text/javascript"
	src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>

<script type="text/javascript">
	$(function() {

		$('#frmWrite').submit(function() {

			var chk = CKEDITOR.instances['editor1'].getData();

			if ($.trim($("#Title").val()).length == 0) {
				alert("제목을 입력하세요");
				$("#Title").focus();
				event.preventDefault();
				return;

			} else if (chk == '' || chk.length == 0) {

				alert("내용을 입력하세요");
				$("#editor1").focus();
				event.preventDefault();
				return;
			}
			location.href = "<c:url value='/portal/board/write'/>";
		});
		$('#btCancel').click(function() {
			location.href = "<c:url value='/portal/board/list'/>";
		});

	}); //ready()
</script>
<div class="container-xxl flex-grow-1 container-p-y">
	<div class="row">
		<div class="card-body">
			<form name="frmWrite" method="post" enctype="multipart/form-data"
				id="frmWrite" action="<c:url value='/portal/board/edit'/>">
				 <input type="hidden" name="btNo" value="${vo.btNo}"/>
				 <input type="hidden" name="fName" value="${vo.FName}"/>
				<div class="col-12"></div>
				<div class="card mb-4">
					<h5 class="card-header">자유게시판 글쓰기</h5>
					<input type="hidden" name="divBdNo" value="1" />
					<div class="card-body">
						<div>
							<label for="defaultFormControlInput" class="form-label">Title</label>
							<input name="title" type="text" class="form-control"
								id="Title" placeholder="제목을 입력해주세요"
								aria-describedby="defaultFormControlHelp"
								value="${vo.title }" />
						</div><br/>
						<div class="page-wrapper compact-wrapper modern-type"
							id="pageWrapper">
							<!-- Container-fluid starts-->
							<div class="col-12">
								<div class="row">

									<div class="col-12">
										<div class="row">
											<div class="col-12">
												<div class="card">
													<div class="card-body">
														<!-- <form class="theme-form mega-form"> -->

														<textarea name="content" id="editor1" cols="30" rows="15">${vo.content }</textarea>
														<!-- </form> -->

													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- Container-fluid Ends-->


							<!--room detail start-->
							<div class="col-12">
								<div class="col-12">
									<div class="row">
										<div class="col-sm-12">
											<div class="card">
												<div class="card-header">
													<h5>첨부파일</h5>
													<c:if test="${!empty vo.FOrigine }">
													<span style="color: green">첨부 파일을 새로 지정할 경우 기존 파일 
            										<img src="<c:url value='/image/file.gif'/>">${vo.FOrigine }는 삭제됩니다.</span>
													</c:if>
												</div>
												<div class="card-body">
													<!-- <form class="theme-form mega-form"> -->
													<div class="animate-chk">

														<div class="mb-3">
															<input type="file" id="upfile" name="upfile" />

														</div>

														<div class="card-footer text-end">
															<button class="btn btn-primary me-3" type="submit">수정</button>
															<input type="button" class="btn btn-outline-primary"
																id="btCancel" value="취소" />
														</div>

													</div>
												</div>

											</div>
										</div>

									</div>
									<!--room detail end-->
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="<c:url value='/assets/js/ckeditor/ckeditor.js'/>"></script>
<script src="<c:url value='/assets/js/ckeditor/styles.js'/>"></script>
<script src="<c:url value='/assets/js/ckeditor/ckeditor.custom.js'/>"></script>
<%@ include file="../footer.jsp"%>