<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ja" class="h-100 overflow-y-scroll">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《エラー》KIDDA-LA 業務システム</title>
<link rel="icon" href="css/favicon.ico">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/Error.css">
<script type="text/javascript" src="js/bootstrap.min.js"></script>
</head>

<body class="d-flex h-100 text-center text-dark">
	<div class="d-flex w-100 h-100 mx-auto flex-column">
		<div>
			<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
				<div class="container">
					<button class="navbar-brand fw-bold btn btn-link" type="submit"
						form="fm2">KIDDA-LA</button>
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navMenu">
						<span class="navbar-toggler-icon"></span>
					</button>
				</div>
			</nav>

			<header class="mb-auto">
				<p class="fs-1 mt-2 mb-1">KIDDA-LA 業務システム</p>
				<p class="fs-3 mt-1 mb-2">《エラー》</p>
			</header>

			<main class="container">
				<div class="d-flex flex-column w-100">
					<div class="row mb-5 justify-content-center">
						<div class="col-8 justify-content-center error-box">
							<p class="error-message mt-2 mb-1">${errorMsg}</p>
							<p class="error-guide mt-1 mb-2">恐れ入りますが，以下のボタンからやり直してください。</p>
						</div>
					</div>
					<div class="row mb-5 justify-content-center">
						<div class="col-4 justify-content-center">
							<button
								class="btn btn-secondary w-100 btn-lg rounded-pill error-btn"
								type="button" onClick="location.href='HomePage.jsp'">
								メニューへ戻る</button>
						</div>
					</div>
				</div>
			</main>

			<footer class="mt-auto" id="ftr">
				<p>&copy;Infotech Serve Inc.</p>
			</footer>
		</div>
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
		</footer>
	</div>
</body>
</html>