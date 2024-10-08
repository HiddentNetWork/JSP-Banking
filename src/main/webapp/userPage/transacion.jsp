<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 8/26/2024
  Time: 3:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>

<head>
    <title>Bank Transaction</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/JSP_Banking_war/assets/css/userCss/transaction.css"/>
    <script>
      function showPasswordModal() {
        var accountNumber = document.getElementById("accountNumber").value;
        var recipientName = document.getElementById("recipientName").value;
        var amount = document.getElementById("amount").value;
        var description = document.getElementById("description").value;

        if (accountNumber.trim() !== "" && recipientName.trim() !== "" && amount.trim() !== "" && description.trim() !== "") {
          var modal = document.getElementById("passwordModal");
          modal.classList.add("show");
        } else {
          alert("Vui lòng điền đầy đủ thông tin trước khi thực hiện giao dịch.");
        }
      }

      function closeModal() {
        var modal = document.getElementById("passwordModal");
        modal.classList.remove("show");
      }

      function confirmTransaction() {
        var password = document.getElementById("password_transaction").value;
        if (password.trim() === "") {
          alert("Vui lòng nhập mật khẩu");
        } else {
          document.getElementById("transactionForm").submit();
        }
      }
    </script>
</head>

<body>
<%@include file="headerUserPage.jsp"%>
<%
    String baoLoi = request.getAttribute("baoLoi") + "";
    baoLoi = (baoLoi != null) ? "" : baoLoi;

    String account_number = request.getAttribute("account_number") + "";
    account_number = (account_number != null) ? "" : account_number;

    String account_name = request.getAttribute("account_name") + "";
    account_name = (account_name != null) ? "" : account_name;

    String account_amount = request.getAttribute("account_amount") + "";
    account_amount = (account_amount != null) ? "" : account_amount;

    String description = request.getAttribute("description") + "";
    description = (description != null) ? "" : description;
%>
<div class="transaction-container">
    <h2>Bank Transaction</h2>
    <%
        if (a != null && a.getBalance() != null && !a.getBalance().trim().isEmpty()) {
            try {
                BigDecimal balance = new BigDecimal(a.getBalance().trim());

                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                String formattedBalance = currencyFormatter.format(balance);
    %>
    <div class="form-group">
        <label>Số Tài Khoản Nguồn: <%=a.getAccount_number()%></label>
    </div>

    <div class="form-group">
        <label>Số Dư: <%=formattedBalance%> </label>
    </div>
    <form id="transactionForm" action="<%=url%>/khach-hang" method="post">
        <input type="hidden" name="hanhDong" value="giao-dich">
        <div class="red"><%=baoLoi%></div>
        <div class="form-group">
            <label for="bankName"><i class="fa-solid fa-building"></i>Tên Ngân Hàng</label>
            <label class="form-control" id="bankName">JSP-Banking</label>
        </div>
        <div class="form-group">
            <label for="accountNumber"><i class="fa-solid fa-hashtag"></i>Số Tài Khoản</label>
            <input type="text" class="form-control" id="accountNumber" name="account_number" placeholder="Enter account number" required value="<%=account_number%>">
        </div>
        <div class="form-group">
            <label for="recipientName"><i class="fa-solid fa-user"></i>Tên Người Hưởng Thụ</label>
            <input type="text" class="form-control" id="recipientName" name="account_name" placeholder="Enter recipient name" required value="<%=account_name%>">
        </div>
        <div class="form-group">
            <label for="amount"><i class="fa-solid fa-dollar-sign"></i>Số Tiền</label>
            <input type="text" class="form-control" id="amount" name="account_amount" placeholder="Enter amount" required value="<%=account_amount%>">
        </div>
        <div class="form-group">
            <label for="description"><i class="fa-solid fa-comments"></i>Nội dung</label>
            <input type="text" class="form-control" id="description" name="description" placeholder="Enter description" required value="<%=description%>">
        </div>
        <!-- Nút Submit -->
        <button type="button" class="btn btn-primary" onclick="showPasswordModal()">
            <i class="fa-solid fa-paper-plane"></i> Giao Dịch
        </button>
        <!-- Modal nhập mật khẩu -->
        <div id="passwordModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeModal()">&times;</span>
                <h3>Nhập mật khẩu của bạn</h3>
                <input type="password" name="password_transaction" class="form-control" id="password_transaction" placeholder="Nhập mật khẩu" required>
                <button type="button" class="btn btn-primary" onclick="confirmTransaction()">Xác Nhận</button>
                <button type="button" class="btn btn-secondary" onclick="closeModal()">Hủy</button>
            </div>
        </div>
    </form>
    <%
            } catch (NumberFormatException e) {
                System.out.println("Số dư không hợp lệ");
            }
        } else {
            System.out.println("Không tìm thấy thông tin tài khoản. Vui lòng đăng nhập lại.");
        }
    %>
</div>

</body>
</html>

