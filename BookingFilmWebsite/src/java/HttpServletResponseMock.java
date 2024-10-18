import java.io.ByteArrayOutputStream;
import java.io.OutputStream;

public class HttpServletResponseMock extends HttpServletResponse {
    private ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

    @Override
    public OutputStream getOutputStream() {
        return outputStream;
    }

    public byte[] getImageData() {
        return outputStream.toByteArray();
    }
    
    // Implement other methods from HttpServletResponse as necessary (or leave them empty)
}
