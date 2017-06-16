package Presentation;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


@WebServlet(name = "uploadFile", urlPatterns = {"/uploadFile"})
public class FileUploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // location to store file uploaded
    // upload settings
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB
    // Set location where the images will be stored
        private static final String UPLOAD_PATH 
            = "/var/lib/tomcat8/webapps/POLYGON/BuildingImages/"; 

    /**
     * Upon receiving file upload submission, parses the request to read upload
     * data and saves the file on disk.
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Working Directory = " +
              System.getProperty("user.dir"));
//        File testFile = new File(System.getProperty("user.dir")+File.separator+"new");
//        if(testFile.exists()) System.out.println("it works!");
//        testFile.mkdirs();
//        File testFile2 = new File("./new/");
//        if(testFile2.exists()) System.out.println("it works!");
//        testFile2.mkdirs();
//        System.out.println("Upload Initiated server post!");
        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            PrintWriter writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }

        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);

        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);

        String location;
        String uploadPath = null;


        try {
            // parses the request's content to extract file data
            @SuppressWarnings("unchecked")
            List<FileItem> formItems = upload.parseRequest(request);

            if (formItems != null && formItems.size() > 0) {
                for (FileItem item : formItems) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString();
                        if (fieldName.equals("b_id")) {
                            location = fieldValue;
                            uploadPath = UPLOAD_PATH + location;
                            System.out.println(System.getProperty("user.dir"));
                            File uploadDir = new File(uploadPath);
                            // creates the directory if it does not exist
                            if (!uploadDir.exists()) {
                                System.out.println("Location Does Not Exist! Location is being created!");
                                System.out.println(uploadDir);
                                uploadDir.mkdirs();
                            }
                        } 
                        } else {

                            String fileName = new File(item.getName()).getName();
                            String filePath = uploadPath + File.separator + fileName;
                            File storeFile = new File(filePath);

                            // saves the file on disk
                            item.write(storeFile);
                            request.setAttribute("message",
                                    "Saved");
                        }
                    }
                }
            

        } catch (Exception ex) {
            request.setAttribute("message",
                    "Save Failed" + ex.getMessage());
        }
        // redirects client to message page
        getServletContext().getRequestDispatcher("/Buildings.jsp").forward(
                request, response);
    }
}
