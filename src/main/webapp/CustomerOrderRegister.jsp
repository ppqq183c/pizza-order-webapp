<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
 
 
<%
String[][] cartList = (String[][]) session.getAttribute("cartList");
 
int totalPrice = 0;
%>
<%
String msgFlag = (String) request.getAttribute("msgFlag");
%>
 
 
<%
Customer customer = (Customer) session.getAttribute("customer");
boolean cusFlag;
String custName, custKana, tel, prefecture, city, town;
if (customer == null) {
	cusFlag = true;
	custName = "";
	custKana = "";
	tel = "";
	prefecture = "";
	city = "";
	town = "";
} else {
	cusFlag = false;
	custName = customer.getCustName();
	tel = customer.getTel();
	custKana = customer.getKana();
 
	String fullAddress = customer.getAddress();
	prefecture = "";
	city = "";
	town = "";
 
	Pattern p = Pattern.compile("^(..都|..道|..府|..県)(.+?[市区町村])(.+)$");
	Matcher m = p.matcher(fullAddress);
 
	if (m.matches()) {
		prefecture = m.group(1);
		city = m.group(2);
		town = m.group(3);
	}
}
%>
 
 
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>お支払い</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
 
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/option.css">
<link rel="stylesheet" href="css/payment.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
 
<script>
document.addEventListener("DOMContentLoaded", () => {
 
  document.querySelectorAll(".required-field").forEach(input => {
    const wrapper = input.closest(".position-relative");
    const icon = wrapper.querySelector(".check-icon");
 
    const updateState = () => {
      if (input.value.trim() !== "" && input.checkValidity()) {
        icon.style.display = "flex";
        input.classList.add("border-success");
      } else {
        icon.style.display = "none";
        input.classList.remove("border-success");
      }
    };
 
    input.addEventListener("input", updateState);
    updateState();
  });
 
  ["building", "room"].forEach(name => {
    const input = document.querySelector(`input[name="${name}"]`);
    if (!input) return;
 
    input.addEventListener("input", () => {
      if (input.value.trim() !== "") {
        input.classList.add("optional-filled");
      } else {
        input.classList.remove("optional-filled");
      }
    });
  });
});
 
function checkSubmit() {
  const form = document.getElementById("orderForm");
  if (!form.checkValidity()) {
    form.classList.add("was-validated");
    return false;
  }
  return true;
}
</script>
 
 
<style>
 
/* 注文行 */
.order-row {
	display: grid;
	grid-template-columns: 1fr 60px 80px 120px;
	align-items: center;
	margin-bottom: 8px;
}
 
/* 商品名 */
.item-name {
	overflow-wrap: break-word;
}
.item-size {
  text-align: right;
}
 
/* 数量 */
.item-qty {
	text-align: right;
}
 
 
/* 金額 */
.item-price {
	text-align: right;
	font-weight: 500;
}
 
.order-separator {
	border: none;
	border-top: 1px dashed rgba(0, 0, 0, 0.25);
	margin: 6px 0 10px;
}
/* ===== チェックマーク（必須・入力済みのみ） ===== */
.check-icon {
	position: absolute;
	top: 70%;
	right: 14px;
	transform: translateY(-50%);
	color: rgb(0, 128, 64);
	font-size: 20px;
	font-weight: bold;
	display: none;
	align-items: center;
	justify-content: center;
	pointer-events: none;
}
</style>
</head>
 
 
 
 
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<button class="navbar-brand fw-bold btn btn-link" type="submit"
				form="fm2">KIDDA-LA</button>
 
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navMenu">
				<span class="navbar-toggler-icon"></span>
			</button>
 
			<div class="collapse navbar-collapse" id="navMenu">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item">
						<button class="nav-link menu-button" type="submit" form="fm2">
							メニュー</button>
					</li>
 
					<li class="nav-item dropdown">
						<button class="nav-link dropdown-toggle" type="button"
							id="myPageDropdown" data-bs-toggle="dropdown"
							aria-expanded="false">マイページ</button>
 
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="myPageDropdown">
							<%
							if (cusFlag) {
							%>
							<li>
								<button class="dropdown-item" type="submit" form="fm3">
									ログイン</button>
							</li>
							<li>
								<button class="dropdown-item" type="submit" form="fm1">
									新規登録</button>
							</li>
							<%
							} else {
							%>
							<li>
								<button class="dropdown-item" type="submit" form="fm6">
									会員情報</button>
							</li>
							<li>
								<button class="dropdown-item" type="submit" form="fm5">
									ログアウト</button>
							</li>
							<%
							}
							%>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
 
	<main class="container my-5 pt-4">
 
		<%
		if ("registered".equals(msgFlag)) {
		%>
 
		<div class="container my-5">
			<div class="card shadow-sm text-center">
				<div class="card-body py-5">
 
					<h4 class="fw-bold mb-3">注文が完了しました</h4>
					<p class="text-muted mb-4">ご注文ありがとうございます。</p>
                     <script>
                     sessionStorage.removeItem("cart");
                     </script>
					<form action="KiddaLaController" method="post" class="d-inline">
						<input type="hidden" name="command" value="HomePage">
						<button type="submit" class="btn btn-danger px-4" form="fm2"
										onclick="document.getElementById('fm2').submit();">
							メインメニューへ戻る</button>
					</form>
 
				</div>
			</div>
		</div>
 
		<%
		} else {
		%>
 
		<h2 class="text-center fw-bold mb-4">お支払い</h2>
 
 
 
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
 
				<form id="orderForm" action="KiddaLaController" method="post"
					novalidate onsubmit="return checkSubmit();">
 
					<input type="hidden" name="command" value="CustomerOrderRegister">
 
					<div class="card shadow-sm">
						<div class="card-body p-4">
 
							<div class="section-title">
								<span>お客様の情報</span>
							</div>
 
							<div class="row mb-3">
								<div class="col position-relative">
									<label class="form-label">お名前 <span class="text-danger">*</span></label>
									<input type="text" name="custName" placeholder="例：山田太郎"
										value="<%=custName%>"
										class="form-control form-control-lg required-field"
										<%=(!cusFlag ? "readonly" : "")%> required> <span
										class="check-icon">✓</span>
								</div>
 
								<div class="col position-relative">
									<label class="form-label">カナ <span class="text-danger">*</span></label>
									<input type="text" name="custKana" placeholder="例：ヤマダタロウ"
										value="<%=custKana%>"
										class="form-control form-control-lg required-field"
										<%=(!cusFlag ? "readonly" : "")%> required pattern="^[ァ-ヶー]+$">
									<span class="check-icon">✓</span>
								</div>
							</div>
 
							<div class="mb-3 position-relative">
								<label class="form-label">電話番号 <span class="text-danger">*</span></label>
								<input type="tel" name="tel"
									placeholder="電話番号は0から始まり、6桁から11桁までの数字を入力してください"
									value="<%=tel%>"
									class="form-control form-control-lg required-field"
									pattern="0[0-9]{9,10}" <%=(!cusFlag ? "readonly" : "")%>
									required> <span class="check-icon">✓</span>
							</div>
 
							<div class="section-title">
								<span>配達先住所</span>
							</div>
 
							<div class="row mb-3">
								<div class="col position-relative">
									<label class="form-label">都道府県 <span
										class="text-danger">*</span></label> <input type="text"
										name="prefecture" placeholder="例：東京都" value="<%=prefecture%>"
										class="form-control form-control-lg required-field"
										<%=(!cusFlag ? "readonly" : "")%> required> <span
										class="check-icon">✓</span>
								</div>
 
								<div class="col position-relative">
									<label class="form-label">市区町村 <span
										class="text-danger">*</span></label> <input type="text" name="city"
										placeholder="例：千代田区" value="<%=city%>"
										class="form-control form-control-lg required-field"
										<%=(!cusFlag ? "readonly" : "")%> required> <span
										class="check-icon">✓</span>
								</div>
							</div>
 
							<div class="row mb-4">
								<div class="col-md-12 position-relative">
									<label class="form-label">町域番地 <span
										class="text-danger">*</span></label> <input type="text" name="town"
										placeholder="例：神田小川町１－８－５" value="<%=town%>"
										class="form-control form-control-lg required-field"
										<%=(!cusFlag ? "readonly" : "")%> required> <span
										class="check-icon">✓</span>
								</div>
 
							</div>
 
						</div>
					</div>
 
					<!-- ご注文内容 -->
					<div class="card shadow-sm mb-4 mt-3">
						<div class="card-body p-4">
							<div class="section-title mt-1">
								<span>ご注文内容</span>
							</div>
 
							<div class="order-row order-header">
								<span>商品名</span><span class="item-size">サイズ</span> <span class="item-qty">数量</span>
								<span class="item-price">金額</span>
							</div>
							<hr>
 
 
							<%
							if (cartList != null) {
								for (int i = 0; i < cartList.length; i++) {
									int quantity = Integer.parseInt(cartList[i][4]);
									if (quantity > 0) {
								int price = Integer.parseInt(cartList[i][3].replace(",", ""));
								int subtotal = price * quantity;
								totalPrice += subtotal;
							%>
							<div class="order-row">
								<span class="item-name"><%=cartList[i][1]%></span> <span class="item-size"><%=cartList[i][2]%></span>
								<span class="item-qty"><%=quantity%></span> <span
									class="item-price"> ¥<%=String.format("%,d", subtotal)%>
								</span>
							</div>
							<%-- 2件目以降の前に線を表示 --%>
							<%
							if (i < cartList.length - 1) {
							%>
							<hr class="order-separator">
							<%
							}
							}
							}
							}
							%>
 
							<div class="d-flex justify-content-end fw-bold mt-3">
								合計：¥<%=String.format("%,d", totalPrice)%>
							</div>
 
						</div>
					</div>
 
					<div class="row g-3">
						<div class="col-3">
							<button type="button"
								class="btn btn-outline-secondary btn-lg w-100"
								onclick="history.back();">戻る</button>
						</div>
 
						<div class="col-9">
							<button type="submit" class="btn btn-danger btn-lg w-100">
								支払いを行う</button>
						</div>
					</div>
 
				</form>
 
			</div>
		</div>
		<%
		}
		%>
	</main>
	<footer class="mt-auto text-center" id="ftr">
		<p>&copy; Infotech Serve Inc.</p>
	</footer>
 
	<form action="KiddaLaController" method="post" id="fm1">
		<input type="hidden" name="command" value="CustomerRegisterDisplay">
	</form>
 
	<form action="KiddaLaController" method="post" id="fm2">
		<input type="hidden" name="command" value="HomePageDisplay">
	</form>
 
	<form action="KiddaLaController" method="post" id="fm3">
		<input type="hidden" name="command" value="LoginDisplay">
	</form>
 
	<form action="KiddaLaController" method="post" id="fm4">
		<input type="hidden" name="command"
			value="CustomerOrderRegisterDisplay">
	</form>
	<form action="KiddaLaController" method="post" id="fm5">
		<input type="hidden" name="command" value="Logout">
	</form>
	<form action="KiddaLaController" method="post" id="fm6">
		<input type="hidden" name="command" value="MemberInfomation">
	</form>
 
 
</body>
</html>
 
 