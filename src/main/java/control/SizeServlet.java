
package control;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;

@WebServlet("/GetItemSizes")
public class SizeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ItemDAO dao = new ItemDAO();

            // 文字列のまま取得
            String itemId = request.getParameter("itemId");
            System.out.println("GetItemSizes called, itemId=" + itemId);

            // DBから取得（itemIdを文字列で検索）
            List<Map<String, Object>> sizes = dao.getSizesByItemId(itemId);
            System.out.println(sizes);
            response.setContentType("application/json;charset=UTF-8");

            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < sizes.size(); i++) {
                Map<String, Object> s = sizes.get(i);
                json.append("{");
                json.append("\"size\":\"").append(s.get("size")).append("\",");
                json.append("\"price\":").append(s.get("price"));
                json.append("}");
                if (i != sizes.size() - 1) json.append(",");
            }
            json.append("]");
            response.getWriter().write(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}



