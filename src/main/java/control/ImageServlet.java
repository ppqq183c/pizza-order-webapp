package control;
import java.io.IOException;

import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GetImageDBAcess;

@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        GetImageDBAcess dao = new GetImageDBAcess();
        String itemId = request.getParameter("itemId");
        byte[] image = null;

        try {
            image = dao.getImage(itemId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (image != null) {
            response.setContentType("image/jpeg");
            response.setContentLength(image.length);
            ServletOutputStream out = response.getOutputStream();
            out.write(image);
            out.flush();
            out.close();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
