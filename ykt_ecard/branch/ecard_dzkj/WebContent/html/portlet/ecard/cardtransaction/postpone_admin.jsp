<%@ include file="/html/portlet/ecard/cardtransaction/init.jsp" %>
<%@ include file="/html/portlet/ecard/cardtransaction/permission.jsp" %>
<%
	int pageR = ParamUtil.get(request, "page", 0);
	int pageNum = 1;
	if (pageR==0){
		pageNum = 1;
	}else{
		pageNum = pageR;
	}

ResultPage curpage = PostponeUtil.list(EcardConstants.POSTPONE_STATUS_UNACCEPTED, 
										pageNum, 
										EcardConstants.ADMIN_SIZE);
List list = curpage.getList();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>

<table width="719" height="29"  border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td background="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/top_menu.jpg">
        <table width="100%"  border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="2%">&nbsp;</td>
            <td width="72%" class="text_blue_12_c"><bean:message key="ecardtransaction.tab.carddeplayprocess" /></td>
            <td width="11%" valign="bottom"><table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="13" align="right">   
                <c:if test="<%=curpage.isPreviousPage()%>">                   
                  <a href="javascript:goto('<%=curpage.getPage() - 1%>')">
                  <img align="middle" src="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/left.gif" width="13" height="9" border="0">
                  </a>
		  					</c:if>				                   
                </td>
                <td width="40" align="center" class="text_brown">
                <%= curpage.getPage() + 1%>/<%= curpage.getTotalPage()%></td>
                <td width="13">
                <c:if test="<%=curpage.isNextPage()%>">
                  <a href="javascript:goto('<%=curpage.getPage() + 1%>')">
                  <img align="middle" src="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/right.gif" width="13" height="9" border="0"></a>
               </c:if>
                </td>
              </tr>
            </table></td>
            <td width="15%" align="right" valign="middle" nowrap class="text_brown">
		<bean:message key="ecard.goto" />
              <select name="select2" onchange="goto(this.options[this.selectedIndex].value)">
              	<%for (int i = 1; i <= curpage.getTotalPage(); i++) {%>
                <option value="<%= i - 1%>" 
                <c:if test="<%= i == (curpage.getPage() + 1)%>">
                	selected
                </c:if>
                ><%= i%></option>
                	<%}%>
              </select>
              <bean:message key="ecard.page" /></td>
          </tr>
        </table></td>
      </tr>
    </table>
      <table width="100"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="5"></td>
        </tr>
      </table>
<table width="719"  border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="9" height="7"><img src="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_l_1.jpg" width="9" height="7"></td>
          <td height="7" background="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_top.jpg"></td>
          <td width="6" height="7"><img src="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_r_1.jpg" width="6" height="7"></td>
        </tr>
        <tr>
          <td background="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_l_2.jpg">&nbsp;</td>
          <td valign="top" bgcolor="#FFFFFF">
          <!-- content table -->
          <form name=PostponeProcessForm action="<portlet:actionURL><portlet:param name="struts_action" value="/ecardtransaction/postponeProcess" /></portlet:actionURL>" method="POST"
	onSubmit="javascript:submitForm(this); return false;">
					<input type=hidden name=status>
          <table border="0" cellpadding="0" cellspacing="0" width="100%">
       <c:if test="<%= SessionErrors.contains(request, EcardConstants.CHOOSE_PROCESS_CONTENT) %>">		
		<tr>
			<td>				
					<font class="portlet-msg-error" style="font-size: 11;">
					<bean:message key="ecard.errors.processitem" />
					</font>
			</td>
		</tr>
		</c:if>  
		<c:if test="<%= SessionErrors.contains(request, EcardConstants.PROCESS_DELAY_SUCCESS) %>">		
		<tr>
			<td>				
					<font class="portlet-msg-success" style="font-size: 11;">
					<bean:message key="ecard.errors.processdelaysuccess" />
					</font>
			</td>
		</tr>
		</c:if> 
		<tr>
			<td>				
					<input type="submit" name="agree" class="button_blank" value='<%=LanguageUtil.get(pageContext, "ecard.agree")%>' 
					onClick="setProcessType('1')">
					<input type="submit" name="disagree" class="button_blank" value='<%=LanguageUtil.get(pageContext, "ecard.disagree")%>' 
					onClick="setProcessType('2')">
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		</table>
       <table width="100%" class="inside_table">
      <tr class="list_tr">
        <td width=10>
			<input name="ids_allbox" type="checkbox"
				onClick="
					for (var i = 0; i < PostponeProcessForm.elements.length; i++) {
						var e = document.PostponeProcessForm.elements[i];

						if ((e.name == 'ids') && (e.type == 'checkbox')) {
							e.checked = this.checked;
						}
					}"
			>
		</td>
		<td align=center>
			<a class=text_blue_12_c><bean:message key="ecardtransaction.cardpostpone.reason" /></a>
		</td>
		<td align=center>
			<a class=text_blue_12_c><bean:message key="ecardtransaction.cardpostpone.date" /></a>
		</td>
		<td align=center>
			<a class=text_blue_12_c><bean:message key="ecardtransaction.cardpostpone.applytime" /></a>
		</td>
		<td align=center>
			<a class=text_blue_12_c><bean:message key="ecardtransaction.cardpostpone.applyer" /></a>
		</td>		
      </tr>
      <%java.util.Iterator it = list.iterator();
      				int count = 0;
					while(it.hasNext()) {
						EcardPostponeApply apply = (EcardPostponeApply) it.next();
						count++;
						int classId = count % 2 + 1;
					%>
	<tr class="tr_<%= classId%>" style="font-size: x-small;">
		<td width=10>
		<input type="checkbox" name="ids" value="<%= String.valueOf(apply.getId())%>" 
						onClick="javascript:checkAllBox(document.PostponeProcessForm, 'ids', document.PostponeProcessForm.ids_allbox)" />
		
		</td>		
		<td align=center>
			<a class=blue_link_line href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" portletMode="<%= PortletMode.VIEW.toString() %>"><portlet:param name="struts_action" value="/ecardtransaction/postpone_edit" /></portlet:renderURL>&id=<%= apply.getId()%>">
			<%= apply.getReason()%>
			</a>
		</td>
		<td align=center>
			<a class=text_blue_12>
			<%= DateFormatUtil.format(apply.getPostponeTime())%>
			</a>
		</td>
		<td align=center>
			<a class=text_blue_12>
			<%= format.format(apply.getApplyTime())%>
			</a>
		</td>
		<td align=center>
			<a class=text_blue_12>
			<%= apply.getStuempno()%>
			</a>
		</td>
	</tr>
	<%}%>

	</table>
</form>
            <!-- content table -->
            </td>
          <td background="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_r_2.jpg">&nbsp;</td>
        </tr>
        <tr>
          <td width="9" height="7"><img src="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_l_3.jpg" width="9" height="7"></td>
          <td height="7" background="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_foot.jpg"></td>
          <td width="6" height="7"><img src="<%= themeDisplay.getPathThemeRoot() %>/images/ecard/portlet/k_r_3.jpg" width="6" height="7"></td>
        </tr>
      </table>
<script>
function goto(page) {
	self.location = '<portlet:renderURL><portlet:param name="struts_action" value="/ecardtransaction/postpone_admin" /></portlet:renderURL>&page=' + page;
}
function setProcessType(status) {
	document.PostponeProcessForm.status.value = status;
}
</script>