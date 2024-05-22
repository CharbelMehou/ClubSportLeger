<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.itextpdf.text.Document" %>
<%@ page import="com.itextpdf.text.pdf.PdfWriter" %>
<%@ page import="com.itextpdf.text.Image" %>
<%@ page import="com.itextpdf.text.Paragraph" %>
<%@ page import="com.itextpdf.text.Rectangle" %>
<%@ page import="com.itextpdf.text.PageSize" %>
<%@ page import="java.util.Base64" %>

<%
	String filename = new String(request.getParameter("fileName").getBytes("ISO-8859-1"), "UTF-8");

    String fileName = "export_" + filename + ".pdf";

    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

    //Pour Lire les données du formulaire envoyé
    String base64Image1 = request.getParameter("image1");
    String base64Image2 = request.getParameter("image2");
    String filters = new String(request.getParameter("filters").getBytes("ISO-8859-1"), "UTF-8");

    // Préparer les images
    byte[] imageBytes1 = Base64.getDecoder().decode(base64Image1.substring(base64Image1.indexOf(",") + 1));
    byte[] imageBytes2 = Base64.getDecoder().decode(base64Image2.substring(base64Image2.indexOf(",") + 1));
    
    Image img1 = Image.getInstance(imageBytes1);
    img1.scaleToFit(500, 500);
    Image img2 = Image.getInstance(imageBytes2);
    img2.scaleToFit(500, 500);

    Document document = new Document(new Rectangle(PageSize.A4));
    document.setMargins(50, 50, 50, 50);
    PdfWriter.getInstance(document, response.getOutputStream());

    document.open();
    document.add(new Paragraph("Filtres Appliqués: " + filters));
    document.add(img1);
    //document.add(new Paragraph("Graph 1"));
    document.add(img2);
    //document.add(new Paragraph("Graph 2"));
    document.close();
%>
