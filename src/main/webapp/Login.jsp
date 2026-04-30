<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.Customer"%>
<%
Customer customer = (Customer) session.getAttribute("customer");
boolean cusFlag;
if (customer == null) {
	cusFlag = true;
} else {
	cusFlag = false;
}
String msgFlag = (String) request.getAttribute("msgFlag");
String errorMsg = (String) request.getAttribute("errorMsg");
String accountName = (String) request.getAttribute("accountName");
if (accountName == null) {
	accountName = "";
}
%>

<!DOCTYPE html>
<html lang="ja" class="h-100 overflow-y-scroll">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ログイン</title>
<link rel="icon" href="css/favicon.ico">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/payment.css">
<link rel="stylesheet" href="css/option.css">
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", () => {

	  /* ===== 必須項目：チェックマーク制御 ===== */
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

	  // ユーザーが入力したとき
	  input.addEventListener("input", updateState);

	  // ★ ページ表示時（自動入力対応）
	  updateState();
	});

	  /* ===== 任意項目：緑枠のみ ===== */
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
	}
	function showModalConfirm(message, kind) {
		if (kind == "error") {
			modal = new bootstrap.Modal(document.getElementById('modalError'));
			document.getElementById('modalError_text').textContent=message;
		} else {
			modal = new bootstrap.Modal(document.getElementById('modalInfo'));
		}
		modal.show();
	}
	window.onload = function() {

		<%if (errorMsg != null) {%>
		  showModalConfirm("<%=errorMsg%>", "error");
		<%} else if (msgFlag != null) {%>
		  showModalConfirm("会員情報の更新が正常に完了しました。", "info");
		<%}%>

		};
</script>
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

.section-title::before, .section-title::after {
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
.was-validated .form-control:valid, .form-control.is-valid {
	background-image: none !important;
	box-shadow: none !important;
}

/* placeholder の文字を小さくする */
.form-control::placeholder {
	font-size: 1.2rem; /* 好みで調整（0.8〜0.9remが一般的） */
	color: #adb5bd; /* Bootstrapの薄いグレー */
	line-height: 150;
}

.form-control:focus {
	border-width: 1px;
	border-color: rgb(128, 128, 128); /* Bootstrapのinfo色 */
	box-shadow: none;
}

.btn-white-red {
	background-color: white; /* 中は白 */
	color: #dc3545; /* 文字を赤（Bootstrapのdangerカラー） */
	border: 2px solid #dc3545; /* 赤い枠線 */
	border-radius: 4px; /* 角の丸み */
	padding: 0.5rem 1rem; /* ボタン内の余白 */
	font-weight: 500; /* 少し太めで引き締め */
	transition: all 0.2s;
}

.btn-white-red:hover {
	background-color: #dc3545; /* ホバーで赤背景 */
	color: white; /* ホバーで文字を白に */
	transform: translateY(-1px); /* 少し浮かせる */
}

/* グレー文字・グレー枠・白背景ボタン */
.btn-white-gray {
	background-color: white; /* 中は白 */
	color: #6c757d; /* 文字をグレー */
	border: 2px solid #6c757d; /* グレーの枠線 */
	border-radius: 4px;
	padding: 0.5rem 1rem;
	font-weight: 500;
	transition: all 0.2s;
}

.btn-white-gray:hover {
	background-color: #6c757d; /* ホバーでグレー背景 */
	color: white; /* ホバーで文字を白に */
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
		<h2 class="text-center fw-bold mb-4">ログイン</h2>

		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">

				<div class="card shadow-sm">
					<div class="card-body p-4">

						<form id="orderForm" action="KiddaLaController" method="post"
							novalidate onsubmit="return checkSubmit();">
							<input type="hidden" name="command" value="Login">

							<div class="row mb-3">
								<div class="position-relative">
									<label class="form-label">アカウント名<span
										class="text-danger">*</span></label> <input type="text"
										id="accountName" value="<%=accountName%>" name="accountName"
										class="form-control form-control-lg required-field" required
										pattern="^[A-Za-z0-9]+$"> <span class="check-icon">✓</span>
								</div>
							</div>

							<div class="row mb-3">
								<div class="position-relative">
									<label class="form-label">パスワード <span
										class="text-danger">*</span></label> <input type="password"
										id="password" name="password"
										class="form-control form-control-lg required-field" required
										minlength="8" pattern="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$">
									<span class="check-icon">✓</span>
								</div>
							</div>

							<div class="row g-3 my-2">
								<div class="col-3">

									<button type="button"
										class="btn btn-outline-secondary btn-lg w-100" form="fm2"
										onclick="document.getElementById('fm2').submit();">戻る</button>
								</div>

								<div class="col-9">
									<button type="submit" class="btn btn-danger btn-lg w-100">
										ログインする</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="modalInfo" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content border-0 bg-transparent">

					<div class="card shadow-lg text-center mx-auto modal-card">
						<div class="card-body p-2 p-md-4">

							<!-- アイコン -->
							<div class="mb-3">
								<div class="success-icon mx-auto">✓</div>
							</div>

							<!-- タイトル -->
							<h5 class="fw-bold mb-2">ログイン完了</h5>

							<!-- メッセージ -->
							<p class="text-muted mb-4">
								ログインが<br class="d-sm-none"> 正常に完了しました。
							</p>

							<!-- ボタン -->
							<button type="submit" class="btn btn-primary w-100 py-2"
								data-bs-dismiss="modal" form="fm2">閉じる</button>

						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="modal fade" id="modalError" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content border-0 bg-transparent">

					<div class="card shadow-lg text-center mx-auto modal-card">
						<div class="card-body p-3 p-md-4">

							<!-- アイコン -->
							<div class="mb-3">
								<div class="error-icon mx-auto">!</div>
							</div>

							<!-- タイトル -->
							<h5 class="fw-bold text-danger mb-2">ログイン失敗</h5>

							<!-- メッセージ -->
							<p id="modalError_text" class="text-muted mb-4"></p>

							<!-- ボタン -->
							<button type="button" class="btn btn-outline-danger w-100 py-2"
								data-bs-dismiss="modal">閉じる</button>

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
		<input type="hidden" name="command"
			value="MemberInfomationChangeDisplay">
	</form>

</body>
</html>