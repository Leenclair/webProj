<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript"
	src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
<script type="text/javascript">
$(function() {

	$('form[name=replyFrm]').submit(function(){
		if($.trim($('#replyTa').val()) == ""){
			alert("내용을 입력해주세요");
			$('#replyTa').focus();
			event.preventDefault();
		}
	});

	$('form[name=replyEditFrm]').submit(function(){
		if($.trim($('#replyEditTa').val()) == ""){
			alert("내용을 입력해주세요");
			$('#replyEditTa').focus();
			event.preventDefault();
		}
	});
});
</script>

<hr />
<h4 class="comment">comments:</h4>
<div class="comment-wrapper">
	<div class="comment-box">
		<!-- 댓글리스트 반복 시작 -->
		<c:forEach var="vo" items="${commentsList }">
		<c:if test='${vo.CDelflag=="Y" }'>
		삭제된 댓글입니다.<hr>
		</c:if>
			<c:if test='${vo.CDelflag=="N" }'>
			<div class="media">
				<div class="media-body">
					<div class="title">
						<div class="comment-user">
							<div class="media d-flex align-items-center">
							<c:if test="${vo.step>0 }">
					<c:forEach var="i" begin="1" end="${vo.step }">
						<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
					</c:forEach>
				</c:if>
								<div class="avatar me-3">
									<img src="<c:url value='/assets/img/avatars/1.png'/>" alt
										class="w-px-40 h-auto rounded-circle" /> <span
										class="avatar-status bg-success"></span>
								</div>
								<div class="name flex-grow-1">
									<h6 class="mb-0">${memVo.userid }
										<c:if test="${vo.CId==memVo.userid }">
											<a href="<c:url value='/portal/comments/ReplyEditFlag?cNo=${vo.CNo }'/>"
												name="replyEdit">수정 </a>&nbsp;/								
											<a href="<c:url value='/portal/comments/replyDelete?cNo=${vo.CNo }&btNo=${vo.btNo }'/>">
												삭제 </a>
										</c:if>
									</h6>
									<span class="text-xs">${vo.CRegdate }</span>
									<a href="javascript:reply(${vo.CNo },${vo.btNo },
									${vo.groupno },${vo.step },${vo.sortno });">
										&nbsp;답글쓰기</a>
									<!-- 대댓글 form -->
									<div id="replyBox${vo.CNo }"></div>
									<!-- 대댓글 form 끝-->
								</div>
							</div>
						</div>
					</div>
					<c:choose>
						<c:when test="${vo.editflag == 'N' }">
							<div class="comment-detail">
								<p><br><c:if test="${vo.step>0 }">
					<c:forEach var="i" begin="1" end="${vo.step }">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</c:forEach>
				</c:if>${vo.CContent }</p>
								<hr />
							</div>
						</c:when>
						<c:otherwise>
							<form name="replyEditFrm" action="<c:url value='/portal/comments/replyEdit'/>" method="post">
								<input type="hidden" name="btNo" value="${vo.btNo }"> <input
									type="hidden" name="cNo" value="${vo.CNo }"> <input
									type="hidden" name="editflag" value="${vo.editflag }">
								<input type="textarea" name="cContent" id="replyEditTa" value="${vo.CContent }" />
								<button type="submit">등록</button>
								&nbsp;
								<button type="submit">취소</button>
							</form>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			</c:if>
		</c:forEach>

	</div>
</div>
<form name="replyFrm" method="post" action="<c:url value='/portal/comments/write'/>">
	<input type="hidden" name="btNo" value="${vo.btNo }">
	<div class="row">
		<div class="form-group col-md-6">
			<span>Posted by : <strong>${memVo.userid }</strong></span>
			<input name="cId" class="form-control" type="hidden" value="${memVo.userid }">
		</div>
		<div class="form-group col-md-12">
			<textarea name="cContent" class="form-control" id="replyTa"
				placeholder="Leave a Comment" rows="4"></textarea>
		</div>
	</div>
	<div class="card-footer text-end">
		<input type="submit" class="btn btn-primary" value="등록">
	</div>
</form>