<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>



    <div class="quan-ly-thanh-vien">
        <div class="title">
            <p>Quản lý thành viên</p>
        </div>

        <div class="danh-sach-block">
            <a href="">
                <div class="a">
                    Danh sách Block
                </div>
            </a>
        </div>

        <div class="danh-muc-thanh-vien">
            <div class="ten-cot">
                <input type="text" placeholder="Id thành viên">
                <input type="text" placeholder="Email">
                <input type="text" placeholder="Họ và tên">
                <input type="text" placeholder="Số điện thoại">
                <input type="text" placeholder="Chức vụ">

                <!-- <p>Id thành viên</p>
                <p>Email</p>
                <p>Số điện thoại</p>
                <p>Chức vụ</p> -->
                <div class="button">
                    <button>Tìm kiếm</button>
                </div>
            </div>

            <ul>
                <%
                    List<User> users = (List) request.getAttribute("getAllUsers");
                %>

                <%
                    if (users != null) {
                        for (User u : users) {
                %>

                <li class="box-thanh-vien">
                    <div class="thanh-vien">
                        <p><%=u.getUserID()%>
                        </p>
                        <p><%=u.getEmail()%>
                        </p>
                        <p><%=u.getFullName()%>
                        </p>
                        <p><%=u.getPhoneNumbers()%>
                        </p>
                        <p>
                            <%
                                String role;
                                if (u.getRole()) {
                                    role = "Admin";
                                } else {
                                    role = "Khách hàng";
                                }
                            %>
                            <%=role%>
                        </p>
                        <div class="sua-block">
                            <a href="edituser?id=<%=u.getUserID()%>">
                                <button class="sua">Sửa</button>
                            </a>

<%--                            <button class="block">Block</button>--%>
                        </div>
                    </div>

                </li>
                <%
                        }
                    }
                %>


            </ul>


        </div>
    </div>