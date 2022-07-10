<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc.jsp"%>
<script type="text/javascript">
	
	function reply(idx, btNo,groupno,step,sortno){
		var insReply = '';
		insReply += '<form name="ReplyRe" method="post" action="<c:url value='/portal/comments/comments_reply'/>">';
		insReply += '<input type="hidden" name="btNo" value='+btNo+'>';
		insReply += '<input type="hidden" name="groupno" value='+groupno+'>';
		insReply += '<input type="hidden" name="step" value='+step+'>';
		insReply += '<input type="hidden" name="sortno" value='+sortno+'>';
		insReply += '<textarea name="cContent" class="form-control" id="reReplyTa" placeholder="Leave a Comment" rows="4"></textarea>';
		insReply += '<br><button type="submit">등록</button>';
		insReply += '<input type="button" value="취소" onclick="javascript:replyCancel('+idx+')">';
		insReply += '</form>';

		$("#replyBox"+idx).slideDown(500);
		$("#replyBox"+idx).html(insReply);
		
		$('form[name=ReplyRe]').submit(function(){
			if($.trim($('#reReplyTa').val()) == ""){
				alert("내용을 입력해주세요");
				$('#reReplyTa').focus();
				event.preventDefault();
			}
		});
	}
	
	function replyCancel(idx){
		$("#replyBox"+idx).slideUp(500);
	}
	
	
	
</script>
<section class="section">
<div class="container-xxl flex-grow-1 container-p-y">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
						<div class="col-12 col-md-6 order-md-1 order-last">
							<h3>${vo.title }</h3>
						</div>
						<div class="media d-flex align-items-center">
                            <div class="avatar me-3">
                                <img src="<c:url value='/assets/img/avatars/1.png'/>" alt class="w-px-40 h-auto rounded-circle" />
                                <span class="avatar-status bg-success"></span>
                            </div>
                            <div class="name flex-grow-1">
                                <h6 class="mb-0">${memVo.userid }</h6>
                                <span class="text-xs">${vo.regdate }</span><span>&nbsp;ㅣ&nbsp;조회 : ${vo.hit }</span>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="card-body pt-4 bg-grey">
                    	<div style="float:right;"><img alt="파일" src="<c:url value='/image/file.gif'/>">&nbsp;첨부파일 : <a href="<c:url value='/portal/board/download?btNo${vo.btNo}&fName=${vo.FName}'/>">${vo.FOrigine }</a></div><br><br>
                    	<div>${vo.content }<br><br></div>
					<%@ include file="comments.jsp" %>
                    </div>
				</div>
            </div>
        </div>
	</div>
    </section>
<%@ include file="../footer.jsp"%>