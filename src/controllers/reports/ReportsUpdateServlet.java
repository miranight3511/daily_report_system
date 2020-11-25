package controllers.reports;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import javax.persistence.EntityManager;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Report;
import models.validators.ReportValidator;
import utils.DBUtil;

/**
 * Servlet implementation class ReportsUpdateServlet
 */
@WebServlet("/reports/update")
public class ReportsUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReportsUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String _token = (String)request.getParameter("_token");
        if(_token != null && _token.equals(request.getSession().getId())) {
            EntityManager em = DBUtil.createEntityManager();

            // セッションスコープからメッセージのIDを取得して
            // 該当のIDのメッセージ1件のみをデータベースから取得
            Report r = em.find(Report.class, (Integer)(request.getSession().getAttribute("report_id")));

            // フォームの内容を各フィールドに上書き
            r.setReport_date(Date.valueOf(request.getParameter("report_date")));
            r.setSyoudan_sts(request.getParameter("syoudan_sts"));
            r.setTitle(request.getParameter("title"));
            r.setContent(request.getParameter("content"));

            // 更新日時のみ上書き
            r.setUpdated_at(new Timestamp(System.currentTimeMillis()));

            List<String> errors = ReportValidator.validate(r);
            if(errors.size() > 0) {
                em.close();

                request.setAttribute("_token", request.getSession().getId());
                request.setAttribute("report", r);
                request.setAttribute("errors", errors);

                RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/reports/edit.jsp");
                rd.forward(request, response);
            } else {

                // データベースを更新
                em.getTransaction().begin();
                em.getTransaction().commit();
                em.close();

                request.getSession().setAttribute("flush", "更新が完了しました。");

                // セッションスコープ上の不要になったデータを削除
                request.getSession().removeAttribute("report_id");

                // indexページへリダイレクト
                response.sendRedirect(request.getContextPath() + "/reports/index");
            }
        }
    }

}