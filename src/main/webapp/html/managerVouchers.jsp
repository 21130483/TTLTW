<%@ page import="dao.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="dao.ProductDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <div class="quan-ly">
        <div class="quan-ly-voucher">

            <div class="ql-voucher-header">
                <div class="title">
                    <p>&#81;u&#7843;n l&#253; lo&#7841;i s&#7843;n ph&#7849;m</p>
                </div>

                <button class="btn-them-loai" id="btnOpenModal" onclick="openCategoryModal()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="12" y1="5" x2="12" y2="19"></line>
                        <line x1="5" y1="12" x2="19" y2="12"></line>
                    </svg>
                    Th&#234;m lo&#7841;i s&#7843;n ph&#7849;m
                </button>
            </div>

            <div class="danh-muc-voucher">
                <div class="ten-cot">
                    <span>ID</span>
                    <span>T&#234;n lo&#7841;i s&#7843;n ph&#7849;m</span>
                    <span>S&#7889; l&#432;&#7907;ng SP</span>
                    <span>Tr&#7841;ng th&#225;i</span>
                    <span>Thao t&#225;c</span>
                </div>

                <ul>
                    <%
                        CategoryDAO categoryDAO = new CategoryDAO();
                        ProductDAO productDAO = new ProductDAO();
                        List<Category> categories;
                        try {
                            categories = categoryDAO.getAllCategoryIncludingInactive();
                        } catch (Exception ex1) {
                            categories = categoryDAO.getAllCategory();
                        }

                        for (Category c : categories) {
                            boolean isActiveRow;
                            try {
                                isActiveRow = c.getIsActive() == 1;
                            } catch (Exception ex2) {
                                isActiveRow = true;
                            }
                            String rowCls  = isActiveRow ? "" : "row-inactive";
                            String bdgCls  = isActiveRow ? "badge-active" : "badge-inactive";
                    %>
                    <li class="box-san-pham <%= rowCls %>">
                        <div class="san-pham">
                            <p><%= c.getCategoryID() %></p>
                            <p><%= c.getName() %></p>
                            <p><%= productDAO.countProductByCategory(c.getCategoryID()) %></p>
                            <p>
                                <span class="badge-status <%= bdgCls %>">
                                    <%= isActiveRow ? "Ho&#7841;t &#273;&#7897;ng" : "Kh&#244;ng ho&#7841;t &#273;&#7897;ng" %>
                                </span>
                            </p>
                            <div class="sua-xoa">
                                <a href="category?active=edit&id=<%= c.getCategoryID() %>">
                                    <button class="sua">S&#7917;a</button>
                                </a>
                                <% if (isActiveRow) { %>
                                <button class="xoa"
                                    onclick="xacNhanXoa(<%= c.getCategoryID() %>, '<%= c.getName().replace("'", "\\'") %>')">
                                    V&#244; hi&#7879;u h&#243;a
                                </button>
                                <% } else { %>
                                <button class="khoi-phuc"
                                    onclick="khoiPhuc(<%= c.getCategoryID() %>)">
                                    Kh&#244;i ph&#7909;c
                                </button>
                                <% } %>
                            </div>
                        </div>
                    </li>
                    <%  } %>
                </ul>
            </div>
        </div>
    </div>

    <!-- Modal: Them loai san pham -->
    <div class="modal-overlay" id="categoryModal">
        <div class="modal-box">
            <div class="modal-header">
                <h2 class="modal-title">Th&#234;m lo&#7841;i s&#7843;n ph&#7849;m</h2>
                <button class="modal-close" onclick="closeCategoryModal()" title="&#272;&#243;ng">&times;</button>
            </div>
            <div class="modal-body">
                <form id="addCategoryForm" onsubmit="guiThemLoai(event)">
                    <div class="form-group">
                        <label for="categoryName">T&#234;n lo&#7841;i s&#7843;n ph&#7849;m <span class="required">*</span></label>
                        <input type="text" id="categoryName" name="name" class="form-input"
                               placeholder="Nh&#7853;p t&#234;n lo&#7841;i s&#7843;n ph&#7849;m..." autocomplete="off"/>
                        <span class="input-hint">V&#237; d&#7909;: Kh&#7849;u trang, N&#432;&#7899;c r&#7917;a tay, ...</span>
                    </div>
                    <div class="modal-error" id="modalError" style="display:none;"></div>
                    <div class="modal-footer">
                        <button type="button" class="btn-modal-huy" onclick="closeCategoryModal()">H&#7911;y</button>
                        <button type="submit" class="btn-modal-them" id="btnSubmitAdd">
                            <span id="btnSubmitText">Th&#234;m m&#7899;i</span>
                            <span id="btnSubmitLoading" style="display:none;">&#272;ang x&#7917; l&#253;...</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal: Xac nhan vo hieu hoa -->
    <div class="modal-overlay" id="confirmDeleteModal">
        <div class="modal-box modal-box-sm">
            <div class="modal-header modal-header-danger">
                <h2 class="modal-title">X&#225;c nh&#7853;n v&#244; hi&#7879;u h&#243;a</h2>
                <button class="modal-close" onclick="closeConfirmDelete()" title="&#272;&#243;ng">&times;</button>
            </div>
            <div class="modal-body">
                <p class="confirm-msg">B&#7841;n c&#243; ch&#7855;c mu&#7889;n v&#244; hi&#7879;u h&#243;a lo&#7841;i s&#7843;n ph&#7849;m
                    <strong id="deleteCategoryName"></strong>?</p>
                <p class="confirm-sub">Lo&#7841;i s&#7843;n ph&#7849;m s&#7869; b&#7883; &#7849;n nh&#432;ng d&#7919; li&#7879;u v&#7851;n &#273;&#432;&#7907;c gi&#7919; l&#7841;i.</p>
            </div>
            <div class="modal-footer">
                <button class="btn-modal-huy" onclick="closeConfirmDelete()">H&#7911;y</button>
                <button class="btn-modal-xoa" id="btnConfirmDelete">V&#244; hi&#7879;u h&#243;a</button>
            </div>
        </div>
    </div>

    <script>
        var _xoaId = null;

        /* ---------- Mo Modal Them ---------- */
        function openCategoryModal() {
            var m = document.getElementById('categoryModal');
            if (!m) return;
            m.classList.add('active');
            var inp = document.getElementById('categoryName');
            if (inp) { inp.value = ''; setTimeout(function(){ inp.focus(); }, 150); }
            var err = document.getElementById('modalError');
            if (err) err.style.display = 'none';
        }

        function closeCategoryModal() {
            var m = document.getElementById('categoryModal');
            if (m) m.classList.remove('active');
        }

        /* ---------- Submit Them ---------- */
        function guiThemLoai(e) {
            e.preventDefault();
            var inp  = document.getElementById('categoryName');
            var name = inp ? inp.value.trim() : '';
            var err  = document.getElementById('modalError');

            if (!name) {
                if (err) { err.textContent = 'Vui long nhap ten loai san pham.'; err.style.display = 'block'; }
                return;
            }

            var btn  = document.getElementById('btnSubmitAdd');
            var txt  = document.getElementById('btnSubmitText');
            var load = document.getElementById('btnSubmitLoading');
            if (txt)  txt.style.display  = 'none';
            if (load) load.style.display = 'inline';
            if (btn)  btn.disabled = true;

            var params = new URLSearchParams();
            params.append('active', 'add');
            params.append('name', name);

            fetch('category', {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(function(r) {
                if (r.ok) { closeCategoryModal(); window.location.href = 'admin?page=voucher'; }
                else { if (err) { err.textContent = 'Co loi xay ra.'; err.style.display = 'block'; } }
            })
            .catch(function() { if (err) { err.textContent = 'Loi ket noi.'; err.style.display = 'block'; } })
            .finally(function() {
                if (txt)  txt.style.display  = 'inline';
                if (load) load.style.display = 'none';
                if (btn)  btn.disabled = false;
            });
        }

        /* ---------- Xac nhan Xoa ---------- */
        function xacNhanXoa(id, name) {
            _xoaId = id;
            var el = document.getElementById('deleteCategoryName');
            if (el) el.textContent = name;
            var m = document.getElementById('confirmDeleteModal');
            if (m) m.classList.add('active');
        }

        function closeConfirmDelete() {
            var m = document.getElementById('confirmDeleteModal');
            if (m) m.classList.remove('active');
            _xoaId = null;
        }

        /* ---------- Khoi phuc ---------- */
        function khoiPhuc(id) {
            if (confirm('Ban co muon khoi phuc loai san pham nay khong?')) {
                window.location.href = 'category?active=restore&id=' + id;
            }
        }

        /* ---------- Bind su kien ---------- */
        (function bindEvents() {
            var btnOK = document.getElementById('btnConfirmDelete');
            if (btnOK) {
                btnOK.onclick = function() {
                    if (_xoaId !== null) window.location.href = 'category?active=delete&id=' + _xoaId;
                };
            }
            var mCat = document.getElementById('categoryModal');
            if (mCat) mCat.onclick = function(e){ if (e.target === mCat) closeCategoryModal(); };

            var mDel = document.getElementById('confirmDeleteModal');
            if (mDel) mDel.onclick = function(e){ if (e.target === mDel) closeConfirmDelete(); };
        })();
    </script>