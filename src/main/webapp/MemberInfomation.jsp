<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>

<%
Customer customer = (Customer) session.getAttribute("customer");
boolean cusFlag;
if (customer == null) {
	cusFlag = true;
} else {
	cusFlag = false;
}

String[] memInfo = (String[]) session.getAttribute("memInfo");
if (memInfo == null) {
	String[] change = { null, "", "", "", "", "" };
	memInfo = change;
}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>会員情報</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/payment.css">
<link rel="stylesheet" href="css/option.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<style>


body {
    background-color: #f8f9fa;
	padding-top: 70px;
}

.card {
    border-radius: 3px;
}

/* ===== セクション見出し ===== */
.section-title {
    display: flex;
    align-items: center;
    margin: 2.5rem 0 1.5rem;
    font-weight: bold;
}
.section-title::before,
.section-title::after {
    content: "";
    flex: 1;
    border-top: 1px solid #dee2e6;
}
.section-title span {
    padding: 0 1rem;
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



/* ===== 必須未入力 ===== */
.was-validated .form-control:invalid {
    border-color: #dc3545;
}

/* ===== 任意入力：入力時のみ緑枠 ===== */
.optional-filled {
    border-color: #198754 !important;
}

/* ===== Bootstrap標準valid無効 ===== */
.was-validated .form-control:valid,
.form-control.is-valid {
    background-image: none !important;
    box-shadow: none !important;
}

/* placeholder の文字を小さくする */
.form-control::placeholder {
    font-size: 1.2rem;   /* 好みで調整（0.8〜0.9remが一般的） */
    color: #adb5bd;       /* Bootstrapの薄いグレー */
	line-height: 150;
}

.form-control:focus {
    border-width: 1px;
    border-color: rgb(128, 128, 128); /* Bootstrapのinfo色 */
    box-shadow: none;
}


.btn-white-red {
    background-color: white;        /* 中は白 */
    color: #dc3545;                 /* 文字を赤（Bootstrapのdangerカラー） */
    border: 2px solid #dc3545;      /* 赤い枠線 */
    border-radius: 4px;             /* 角の丸み */
    padding: 0.5rem 1rem;           /* ボタン内の余白 */
    font-weight: 500;               /* 少し太めで引き締め */
    transition: all 0.2s;
}

.btn-white-red:hover {
    background-color: #dc3545;      /* ホバーで赤背景 */
    color: white;                   /* ホバーで文字を白に */
    transform: translateY(-1px);    /* 少し浮かせる */
}

/* グレー文字・グレー枠・白背景ボタン */
.btn-white-gray {
    background-color: white;        /* 中は白 */
    color: #6c757d;                 /* 文字をグレー */
    border: 2px solid #6c757d;      /* グレーの枠線 */
    border-radius: 4px;
    padding: 0.5rem 1rem;
    font-weight: 500;
    transition: all 0.2s;
}

.btn-white-gray:hover {
    background-color: #6c757d;      /* ホバーでグレー背景 */
    color: white;                   /* ホバーで文字を白に */
    transform: translateY(-1px);
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
					<li class="nav-item"><button class="nav-link menu-button"
							type="submit" form="fm2">メニュー</button></li>
					<li class="nav-item dropdown">
						<button class="nav-link dropdown-toggle" type="button"
							id="myPageDropdown" data-bs-toggle="dropdown"
							aria-expanded="true">マイページ</button>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="myPageDropdown">
							<%
							if (cusFlag) {
							%>
							<li><button class="dropdown-item" type="submit" form="fm3">ログイン</button></li>
							<li><button class="dropdown-item" type="submit" form="fm1">新規登録</button></li>
							<%
							} else {
							%>
							<li><button class="dropdown-item" type="submit" form="fm6">会員情報</button></li>
							<li><button class="dropdown-item" type="submit" form="fm5">ログアウト</button></li>
							<%
							}
							%>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<main class="container my-5 pt-2">
		<h2 class="text-center fw-bold mb-4">会員情報</h2>

		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">

				<div class="card shadow-sm">
					<div class="card-body p-4">

						<div class="row mb-3">
							<div class="col-3 fw-bold text-end">氏名：</div>
							<div class="col-9"><%=memInfo[1]%></div>
						</div>

						<div class="row mb-3">
							<div class="col-3 fw-bold text-end">カナ：</div>
							<div class="col-9"><%=memInfo[2]%></div>
						</div>

						<div class="row mb-3">
							<div class="col-3 fw-bold text-end">アカウント名：</div>
							<div class="col-9"><%=memInfo[3]%></div>
						</div>

						<div class="row mb-3">
							<div class="col-3 fw-bold text-end">電話番号：</div>
							<div class="col-9"><%=memInfo[4]%></div>
						</div>

						<div class="row mb-5">
							<div class="col-3 fw-bold text-end">住所：</div>
							<div class="col-9"><%=memInfo[5]%></div>
						</div>

						<div class="row g-4">
							<div class="col-6">
								<button type="submit" class="btn btn-white-gray w-100"
									form="fm2">戻る</button>
							</div>

							<div class="col-6">
								<button type="submit" class="btn btn-white-red w-100" form="fm7">
									会員情報の変更</button>
							</div>
						</div>

					</div>
				</div>


			</div>
		</div>
	</main>
	<footer class="mt-auto text-center" id="ftr">
		<p>&copy;Infotech Serve Inc.</p>
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
	<form action="KiddaLaController" method="post" id="fm7">
		<input type="hidden" name="command" value="MemberInfomationChangeDisplay">
	</form>
</body>
</html>
