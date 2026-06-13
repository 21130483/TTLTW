<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="model.Origin" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin sản phẩm</title>
    <link rel="stylesheet" href="../css/addEditProduct.css">
</head>
<body>
<div class="noi-dung">
    <%
        String active = request.getParameter("active");
        List<Category> categories = (List<Category>) request.getAttribute("getCategories");
        List<Origin> origins = (List<Origin>) request.getAttribute("getOrigins");
    %>
    <div class="them-sua-san-pham">
        <div class="thong-tin-san-pham">
            <h1 class="page-title"><%= active.equals("add") ? "Thêm sản phẩm mới" : "Cập nhật sản phẩm" %></h1>
            <p class="subtitle">Vui lòng điền đầy đủ các thông tin chi tiết dưới đây để hoàn tất.</p>
        </div>

        <%
            if (active.equals("add")) {
                int productIdAdd = (int) request.getAttribute("idAdd");
        %>
        <form action="add-edit-delete?active=add" method="post" enctype="multipart/form-data" class="product-form">
            <div class="dien-thong-tin">
                <div class="box">
                    <div class="form-group">
                        <label>Mã sản phẩm</label>
                        <input name="id" type="text" value="<%=productIdAdd%>" readonly class="form-control readonly">
                    </div>
                    
                    <div class="form-group">
                        <label>Tên sản phẩm</label>
                        <input name="name" type="text" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Nhà sản xuất</label>
                        <input name="trademark" type="text" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Loại sản phẩm (Danh mục)</label>
                        <select name="categoryID" class="form-control select-control">
                            <%
                                for (Category c : categories) {
                            %>
                            <option value="<%=c.getCategoryID()%>"><%=c.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="box">
                    <div class="form-group">
                        <label>Xuất xứ</label>
                        <select name="originID" class="form-control select-control">
                            <%
                                for (Origin o : origins) {
                            %>
                            <option value="<%=o.getOriginID()%>"><%=o.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Giá bán (VNĐ)</label>
                        <input name="price" type="number" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Số lượng kho</label>
                        <input name="quantity" type="number" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Giảm giá (%)</label>
                        <input name="sale" type="number" required class="form-control" min="0" max="100">
                    </div>
                </div>
            </div>

            <div class="hinh-anh form-group-full">
                <label>Hình ảnh sản phẩm</label>
                <div class="file-upload-wrapper">
                    <input name="images[]" type="file" accept="image/*" multiple required class="file-input">
                </div>
            </div>

            <div class="chi-tiet form-group-full">
                <label>Mô tả chi tiết sản phẩm</label>
                <textarea name="content" required class="form-control textarea-control" placeholder="Mô tả công dụng, thành phần, hướng dẫn sử dụng..."></textarea>
            </div>

            <div class="button-them-huy">
                <button type="submit" class="btn btn-primary">Lưu sản phẩm</button>
                <a href="admin?page=product" class="btn btn-secondary">Hủy bỏ</a>
            </div>
        </form>
        <%
            } else if (active.equals("edit")) {
                Product p = (Product) request.getAttribute("productEdit");
        %>
        <form action="add-edit-delete?active=edit" method="post" enctype="multipart/form-data" class="product-form">
            <div class="dien-thong-tin">
                <div class="box">
                    <div class="form-group">
                        <label>Mã sản phẩm</label>
                        <input name="id" type="text" value="<%=p.getProductID()%>" readonly class="form-control readonly">
                    </div>
                    
                    <div class="form-group">
                        <label>Tên sản phẩm</label>
                        <input name="name" type="text" value="<%=p.getName()%>" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Nhà sản xuất</label>
                        <input name="trademark" type="text" value="<%=p.getTrademark()%>" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Loại sản phẩm (Danh mục)</label>
                        <select name="categoryID" class="form-control select-control">
                            <%
                                for (Category c : categories) {
                            %>
                            <option value="<%=c.getCategoryID()%>" <%= c.getCategoryID() == p.getCategoryID() ? "selected" : "" %>><%=c.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="box">
                    <div class="form-group">
                        <label>Xuất xứ</label>
                        <select name="originID" class="form-control select-control">
                            <%
                                for (Origin o : origins) {
                            %>
                            <option value="<%=o.getOriginID()%>" <%= o.getOriginID() == p.getOriginID() ? "selected" : "" %>><%=o.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label>Giá bán (VNĐ)</label>
                        <input name="price" type="number" value="<%=p.getPrice()%>" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Số lượng kho</label>
                        <input name="quantity" type="number" value="<%=p.getQuantity()%>" required class="form-control">
                    </div>
                    
                    <div class="form-group">
                        <label>Giảm giá (%)</label>
                        <input name="sale" type="number" value="<%=p.getSale()%>" required class="form-control" min="0" max="100">
                    </div>
                </div>
            </div>

            <div class="hinh-anh form-group-full">
                <label>Hình ảnh sản phẩm</label>
                <div class="file-upload-wrapper">
                    <input name="images" id="fileInput" type="file" accept="image/*" multiple class="file-input">
                    <span id="fileLabel" class="file-label-info">Đang chọn <%=p.getNumberImg(request.getServletContext().getRealPath(""))%> ảnh</span>
                </div>
            </div>

            <div class="chi-tiet form-group-full">
                <label>Mô tả chi tiết sản phẩm</label>
                <textarea name="content" required class="form-control textarea-control" placeholder="Mô tả công dụng, thành phần, hướng dẫn sử dụng..."><%=p.getContent()%></textarea>
            </div>

            <div class="button-them-huy">
                <button type="submit" class="btn btn-primary">Cập nhật sản phẩm</button>
                <a href="admin?page=product" class="btn btn-secondary">Hủy bỏ</a>
            </div>
            <script>
                document.getElementById('fileInput').addEventListener('change', function() {
                    var fileInput = this;
                    var fileLabel = document.getElementById('fileLabel');

                    if (fileInput.files.length > 0) {
                        var fileName = fileInput.files.length;
                        fileLabel.innerHTML = "Đang chọn "+ fileName +" ảnh mới";
                    } else {
                        fileLabel.innerHTML = "Đang chọn <%=p.getNumberImg(request.getServletContext().getRealPath(""))%> ảnh";
                    }
                });
            </script>
        </form>
        <%
            }
        %>
    </div>
</div>
</body>
</html>