<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="dao.OriginDAO" %>
<%@ page import="dao.CategoryDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>



    <div class="quan-ly">
        <div class="quan-ly-san-pham">
            <div class="title">
                <p>Quản lý sản phẩm</p>
            </div>

            <div class="them-san-pham">
                <a href="add-edit-delete?active=add">
                    <div class="a">
                        Thêm sản phẩm
                    </div>
                </a>
            </div>

            <div class="danh-muc-san-pham">
                <div class="ten-cot">
                    <input type="text" placeholder="Id sản phẩm">
                    <input type="text" placeholder="Tên sản phẩm">
                    <input type="text" placeholder="Loại sản phẩm">
                    <input type="text" placeholder="Ngày thêm sản phẩm">
                    <input type="text" placeholder="Xuất sứ">
                    <!-- <input type="text" placeholder="Ngày cập nhật"> -->

                    <div class="button">
                        <button>Tìm kiếm</button>
                    </div>
                </div>

                <ul>

                    <%
                        List<Product> list = (List) request.getAttribute("getAllProducts");
                        OriginDAO originDAO = new OriginDAO();
                        CategoryDAO categoryDAO = new CategoryDAO();
                    %>

                    <%
                        for (Product p : list) {
                    %>
                    <li class="box-san-pham" style="<%= p.isHidden() ? "opacity: 0.45;" : "" %>">
                        <div class="san-pham">
                            <p><%= p.getProductID() %>
                            </p>
                            <p style="overflow: hidden; text-overflow: ellipsis;  white-space: nowrap;">
                                <%= p.getName() %>
                                <% if (p.isHidden()) { %>
                                    <span style="font-size:11px; color:#e53e3e; font-weight:600; margin-left:6px;">[Đang ẩn]</span>
                                <% } %>
                            </p>
                            <p><%= categoryDAO.getCategoryById(p.getCategoryID()).getName() %>
                            </p>
                            <p><%= p.getDateAdded() %>
                            </p>
                            <p>
                                <%= originDAO.getOriginById(p.getOriginID()).getName() %>
                            </p>
                            <div class="sua-xoa">
                                <a href="add-edit-delete?active=edit&id=<%= p.getProductID() %>">
                                    <button class="sua">Sửa</button>
                                </a>
                                <a href="add-edit-delete?active=hide&id=<%= p.getProductID() %>" onclick="return confirm('<%= p.isHidden() ? "Hiện sản phẩm này?" : "Ẩn sản phẩm này?" %>')">
                                    <button class="<%= p.isHidden() ? "hien" : "xoa" %>"><%= p.isHidden() ? "Hiện" : "Ẩn" %></button>
                                </a>
                            </div>
                        </div>

                    </li>

                    <%

                        }
                    %>


                    <%--                    <li class="box-san-pham">--%>
                    <%--                        <div class="san-pham">--%>
                    <%--                            <p>123</p>--%>
                    <%--                            <p>Khẩu trang trắng</p>--%>
                    <%--                            <p>Khẩu trang</p>--%>
                    <%--                            <p>ABC</p>--%>
                    <%--                            <p>Việt Nam</p>--%>
                    <%--                            <!-- <p>11/1/2023</p> -->--%>
                    <%--                            <div class="sua-xoa">--%>
                    <%--                                <button class="sua">Sửa</button>--%>
                    <%--                                <button class="xoa">Xóa</button>--%>
                    <%--                            </div>--%>
                    <%--                        </div>--%>

                    <%--                    </li>--%>


                </ul>
            </div>
        </div>
    </div>