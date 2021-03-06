<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../layout/app.jsp">
    <c:param name="content">
        <c:if test="${flush != null}">
            <div id="flush_success">
                <c:out value="${flush}"></c:out>
            </div>
        </c:if>
        <h2>日報管理システムへようこそ</h2>
        <h3>【自分の日報 一覧】</h3>
        <p>
            <a href="<c:url value='/reports/new' />">新規日報の登録</a>
        </p>
        <table id="report_list">
            <tbody>
                <tr>
                    <th class="report_name">氏名</th>
                    <th class="report_date">日付</th>
                    <th class="syoudan_sts">商談状況</th>
                    <th class="report_title">タイトル</th>
                    <th class="report_action">操作</th>
                    <th class="employee_admin_flag">クラス</th>
                </tr>
                <c:forEach var="report" items="${reports}" varStatus="status">
                    <tr class="row${status.count % 2}">
                        <td class="report_name"><c:out
                                value="${report.employee.name}" /></td>
                        <td class="report_date"><fmt:formatDate
                                value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                        <td class="syoudan_sts"><c:out value="${report.syoudan_sts}" /></td>
                        <td class="report_title">${report.title}</td>
                        <td class="report_action"><a
                            href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>
                        <td class="employee_admin_flag"><c:out
                                value="${report.employee.admin_flag}" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagination">
            （全 ${reports_count} 件）<br />
            <c:forEach var="i" begin="1" end="${((reports_count - 1) / 5) + 1}"
                step="1">
                <c:choose>
                    <c:when test="${i == page}">
                        <c:out value="${i}" />&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <c:if test="${Ippan_reports.size() > 0}">

            <h3>【部下の日報 一覧】</h3>
            <table id="report_list">
                <tbody>
                    <tr>
                        <th class="report_name">氏名</th>
                        <th class="report_date">日付</th>
                        <th class="syoudan_sts">商談状況</th>
                        <th class="report_title">タイトル</th>
                        <th class="report_action">操作</th>
                        <th class="employee_admin_flag">クラス</th>
                    </tr>
                    <c:forEach var="report" items="${Ippan_reports}" varStatus="status">
                        <tr class="row${status.count % 2}">
                            <td class="report_name"><c:out
                                    value="${report.employee.name}" /></td>
                            <td class="report_date"><fmt:formatDate
                                    value='${report.report_date}' pattern='yyyy-MM-dd' /></td>
                            <td class="syoudan_sts"><c:out value="${report.syoudan_sts}" /></td>
                            <td class="report_title">${report.title}</td>
                            <td class="report_action"><a
                                href="<c:url value='/reports/show?id=${report.id}' />">詳細を見る</a></td>
                            <td class="employee_admin_flag"><c:out
                                    value="${report.employee.admin_flag}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <%--前回から追記した部分 ページネーションの追加 --%>

            <div id="pagination">
                （全 ${Ippan_reports_count} 件）<br />
                <c:forEach var="i" begin="1" end="${((Ippan_reports_count - 1) / 5) + 1}"
                    step="1">
                    <c:choose>
                        <c:when test="${i == page}">
                            <c:out value="${i}" />&nbsp;
                    </c:when>
                        <c:otherwise>
                            <a href="<c:url value='/?page=${i}' />"><c:out value="${i}" /></a>&nbsp;
                    </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>

            <%--前回から追記した部分 ページネーションの追加  --%>

        </c:if>

    </c:param>
</c:import>