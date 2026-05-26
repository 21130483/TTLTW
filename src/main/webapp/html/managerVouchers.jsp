<%@ page import="dao.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>



    <div class="quan-ly">
        <div class="quan-ly-voucher">
            <div class="title">
                <p>Quản lý loại sản phẩm</p>
            </div>

            <div  class="them-voucher">
                <a href="category?active=add">
                    <div class="a">
                        Thêm loại sản phẩm
                    </div>
                </a>
            </div>

            <div class="danh-muc-voucher">
                <div class="ten-cot">
                    <input type="text" placeholder="Id loại sản phẩm">
                    <input type="text" placeholder="loại sản phẩm">
                    <input type="text" placeholder="Số lượng sản phẩm">
                    <!-- <input type="text" placeholder="Ngày cập nhật"> -->

                    <div class="button">
                        <button>Tìm kiếm</button>
                    </div>
                </div>

                <ul>
                    <%
                        CategoryDAO categoryDAO = new CategoryDAO();
                        ProductDAO productDAO = new ProductDAO();
                        List<Category> categories = categoryDAO.getAllCategory();
                        for (Category c : categories){
                    %>
                    <li class="box-san-pham">
                        <div class="san-pham">
                            <p><%=c.getCategoryID()%></p>
                            <p><%=c.getName()%></p>
                            <p><%=productDAO.countProductByCategory(c.getCategoryID())%></p>
                            <!-- <p>11/1/2023</p> -->
                            <div class="sua-xoa">
                                <a href="category?active=edit&id=<%=c.getCategoryID()%>">
                                    <button class="sua">Sửa</button>
                                </a>

                                <a href="category?active=delete&id=<%=c.getCategoryID()%>">
                                    <button class="xoa">Xóa</button>
                                </a>



                            </div>
                        </div>

                    </li>
                    <%
                        }
                    %>





                </ul>
            </div>
        </div>

    </div>

