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

String[] memInfo = (String[]) request.getAttribute("memInfo");
if (memInfo == null) {
	String[] change = {null, "", "", "", "", ""};
	memInfo = change;
}
String msgFlag = (String) request.getAttribute("msgFlag");
String errorMsg = (String) request.getAttribute("errorMsg");
String checkErrorMsg = (String) request.getAttribute("checkErrorMsg");
%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>会員情報変更</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/payment.css">
<link rel="stylesheet" href="css/option.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
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

function showConfirm(custName, kana, accountName, tel, address) {
	modal = new bootstrap.Modal(document.getElementById('modalConfirm'));
	document.getElementById('modalConfirm_custName').value = custName;
	document.getElementById('modalConfirm_kana').value = kana;
	document.getElementById('modalConfirm_accountName').value = accountName;
	document.getElementById('modalConfirm_tel').value = tel;
	document.getElementById('modalConfirm_address').value = address;
	document.getElementById('modalConfirm_custName_text').textContent = custName;
	document.getElementById('modalConfirm_kana_text').textContent = kana;
	document.getElementById('modalConfirm_accountName_text').textContent = accountName;
	document.getElementById('modalConfirm_tel_text').textContent =tel;
	document.getElementById('modalConfirm_address_text').textContent = address;
	modal.show();
}

/* ===== submit時 ===== */
function checkSubmit() {
  const form = document.getElementById("orderForm");
  if (!form.checkValidity()) {
    form.classList.add("was-validated");
    return false;
  } else{
	  custName = document.getElementById('custName').value;
		kana = document.getElementById('kana').value;
		accountName = document.getElementById('accountName').value;
		tel = document.getElementById('tel').value;
		address = document.getElementById('address').value;
		showConfirm(custName, kana, accountName, tel,address);
	  }
  return false;
}

function showModalConfirm(message, kind) {
	if (kind == "error") {
		modal = new bootstrap.Modal(document.getElementById('modalError'));
		document.getElementById('modalError_text').textContent=message;
	} else if (kind == "warning") {
		modal = new bootstrap.Modal(document.getElementById('modalWarning'));
		document.getElementById('modalWarning_text').textContent=message;
	} else {
		modal = new bootstrap.Modal(document.getElementById('modalInfo'));
	}
	modal.show();
}

window.onload = function() {

<%if (errorMsg != null) {%>
  showModalConfirm("<%=errorMsg%>", "error");
<%} else if (checkErrorMsg != null) {%>
  showModalConfirm("<%=checkErrorMsg%>", "warning");
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
		<h2 class="text-center fw-bold mb-4">会員情報の変更</h2>

		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">

				<div class="card shadow-sm">
					<div class="card-body p-4">

						<form id="orderForm" novalidate onsubmit="return checkSubmit();">

							<div class="row mb-3">
								<div class="position-relative">
									<label class="form-label">氏名 <span class="text-danger">*</span></label>
									<input type="text" id="custName" placeholder="例：山田太郎"
										value="<%=memInfo[1]%>"
										class="form-control form-control-lg required-field" required>
									<span class="check-icon">✓</span>
								</div>
							</div>

							<div class="row mb-3">
								<div class="position-relative">
									<label class="form-label">氏名カナ<span class="text-danger">*</span></label>
									<input type="text" id="kana" placeholder="例：ヤマダタロウ"
										value="<%=memInfo[2]%>"
										class="form-control form-control-lg required-field" required
										pattern="^[ァ-ヶー]+$"> <span class="check-icon">✓</span>
								</div>
							</div>

							<div class="row mb-3">
								<div class="position-relative">
									<label class="form-label">アカウント名<span
										class="text-danger">*</span></label> <input type="text"
										id="accountName" placeholder="例：Taro123（半角英数字のみ）"
										value="<%=memInfo[3]%>"
										class="form-control form-control-lg required-field" required
										pattern="^[A-Za-z0-9]+$"> <span class="check-icon">✓</span>
								</div>
							</div>

							<div class="row mb-3">
								<div class="position-relative">
									<label class="form-label">電話番号 <span
										class="text-danger">*</span></label> <input type="tel" id="tel"
										placeholder="電話番号は0から始まり、6桁から11桁までの数字を入力してください"
										value="<%=memInfo[4]%>"
										class="form-control form-control-lg required-field"
										pattern="[0-9]{10,11}" required> <span
										class="check-icon">✓</span>
								</div>
							</div>

							<div class="row mb-4">
								<div class="position-relative">
									<label class="form-label">住所 <span class="text-danger">*</span></label>
									<input type="text" id="address"
										placeholder="例：東京都千代田区神田小川町１－８－５" value="<%=memInfo[5]%>"
										class="form-control form-control-lg required-field" required>
									<span class="check-icon">✓</span>
								</div>
							</div>

							<div class="row g-3 my-2">
								<div class="col-3">
									<button type="button"
										class="btn btn-outline-secondary btn-lg w-100"
										onclick="location.href='MemberInfomation.jsp'">戻る</button>
								</div>

								<div class="col-9">
									<button type="submit" class="btn btn-danger btn-lg w-100">
										変更する</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- モーダル -->
		<div class="modal fade" id="modalConfirm" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content position-relative border-0 bg-transparent">
					<!-- 上に重ねるカード -->
					<div class="card shadow-lg mx-auto"
						style="width: 100%; z-index: 10;">
						<div class="card-body p-4">

							<div class="section-title fs-4" style="margin-top: 0;">
								<span>会員情報確認</span>
							</div>

							<div class="row mb-2 align-items-center">
								<div class="col-4 fw-bold text-end">氏名：</div>
								<div class="col-8">

									<span id="modalConfirm_custName_text"
										class="form-control-plaintext"></span>
								</div>
							</div>
							<div class="row mb-2 align-items-center">
								<div class="col-4 fw-bold text-end">氏名カナ：</div>
								<div class="col-8">

									<span id="modalConfirm_kana_text"
										class="form-control-plaintext"></span>
								</div>
							</div>
							<div class="row mb-2 align-items-center">
								<div class="col-4 fw-bold text-end">アカウント名：</div>
								<div class="col-8">
									<span id="modalConfirm_accountName_text"
										class="form-control-plaintext"></span>
								</div>
							</div>
							<div class="row mb-2 align-items-center">
								<div class="col-4 fw-bold text-end">電話番号：</div>
								<div class="col-8">

									<span id="modalConfirm_tel_text" class="form-control-plaintext"></span>
								</div>
							</div>
							<div class="row mb-3 align-items-center">
								<div class="col-4 fw-bold text-end">住所：</div>
								<div class="col-8">

									<span id="modalConfirm_address_text"
										class="form-control-plaintext"></span>
								</div>
							</div>

							<div class="row mb-2">
								<div class="alert alert-warning d-flex align-items-center"
									role="alert">
									<div>この内容でよろしければ、〔確定〕ボタンを押してください。</div>
								</div>
							</div>

							<div class="row g-4">
								<div class="col-6">
									<button type="button" class="btn btn-white-gray w-100"
										data-bs-dismiss="modal">取消</button>
								</div>

								<div class="col-6">
									<button type="submit" class="btn btn-white-red w-100"
										form="fm8">確定</button>
								</div>
							</div>
						</div>
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
							<h5 class="fw-bold mb-2">更新完了</h5>

							<!-- メッセージ -->
							<p class="text-muted mb-4">
								会員情報の変更が<br class="d-sm-none"> 正常に完了しました。
							</p>

							<!-- ボタン -->
							<button type="submit" class="btn btn-primary w-100 py-2"
								data-bs-dismiss="modal" form="fm6">閉じる</button>

						</div>
					</div>

				</div>
			</div>
		</div>

		<div class="modal fade" id="modalWarning" tabindex="-1"
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
							<h5 class="fw-bold text-danger mb-2">更新に失敗しました</h5>

							<!-- メッセージ -->
							<p id="modalWarning_text" class="text-muted mb-4"></p>

							<!-- ボタン -->
							<button type="button" class="btn btn-outline-danger w-100 py-2"
								data-bs-dismiss="modal">閉じる</button>

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
							<h5 class="fw-bold text-danger mb-2">エラーが発生しました</h5>

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
	<form action="KiddaLaController" method="post" id="fm8">
		<input type="hidden" name="custName" id="modalConfirm_custName">
		<input type="hidden" name="kana" id="modalConfirm_kana"> <input
			type="hidden" name="accountName" id="modalConfirm_accountName">
		<input type="hidden" name="tel" id="modalConfirm_tel"> <input
			type="hidden" name="address" id="modalConfirm_address"> <input
			type="hidden" name="command" value="MemberInfomationChange">
	</form>
</body>
</html>
