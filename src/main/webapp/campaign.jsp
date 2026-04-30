<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.ArrayList, model.Campaign, model.Customer" %>
	<%
@SuppressWarnings("unchecked")
ArrayList<Campaign> campaignList =
    (ArrayList<Campaign>) request.getAttribute("DesignList");
	if (campaignList == null) {
	    campaignList = new ArrayList<>();
	}
String errorMsg = (String) request.getAttribute("errorMsg");
Customer customer = (Customer) session.getAttribute("customer");
boolean cusFlag;
if (customer == null) {
	cusFlag = true;
} else {
	cusFlag = false;
}
%>
<!DOCTYPE html>
<html lang="ja" class="h-100 overflow-y-scroll">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《メインメニュー》 KIDDA-LA 業務システム</title>
<link rel="icon" href="css/favicon.ico">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/option.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js">
	
</script>
<style> 
.cart-box {
    font-family: "游ゴシック体", "Yu Gothic", "Hiragino Kaku Gothic Pro", sans-serif;
    font-weight: bold;
    text-align: center;
    color: #333;
    font-size: 1rem;
}

.cart-box .cart-title {
    border-bottom: 2px solid #333; 
    display: inline-block;        
    padding-bottom: 0.3rem;       
    margin-bottom: 1rem;          
    font-size: 1.1rem;              
}
.card {
  border-radius: 0.5rem;   /* 角を少し丸める（お好みで調整） */
  transition: transform .15s ease, box-shadow .15s ease;
}

.card:hover {
  transform: scale(1.03);
  box-shadow: 0 .5rem 1rem rgba(0,0,0,.3);
}
.fixed-box {
  position: sticky;
  bottom: 0;
  background: white;
  padding: 1rem 0;
}
.hero {
  width: 100%;
  height: 400px;
  background-image: url('<%= request.getContextPath() %>/ImageServlet_Campaign?campaignId=999');
  background-size: cover;
  background-position: center;
}

.menu-scroll-bg {
    position: relative;
    overflow-y: auto;
    height: 100%;
    background: url('<%= request.getContextPath() %>/css/concrete.jpg') repeat-y;
   
}

.menu-scroll-bg > .row {
    position: relative;
    z-index: 1; 
}
.under-hero-img {
  width: 200px;        /* ← 小さくする */
  height: auto;
  display: block;     /* ← 左詰めの基本 */
  margin: 0;          /* ← 左寄せ */
}


@media (max-width: 768px) {
    .cart-box {
        font-size: 0.9rem;
    }
}
</style>
</head>

<body>
	<div>
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

		<main>
		<div>
		<div class="hero"></div>
		</div>
<div class="container my-2">
  <img
    src="<%= request.getContextPath() %>/css/topic.jpeg"
    class="under-hero-img"
    alt="背景イメージ"
  >
</div>
		
		
		<div class="container my-1">
    <div class="row g-4">
        <%
        for (Campaign campaign : campaignList) {
        %>
        <div class="col-md-4 col-sm-6">
        <button type="button" class="p-0 border-0 bg-transparent w-100 h-100"
        data-campaign-img="<%= request.getContextPath() %>/ImageServlet_Campaign?campaignId=<%= campaign.getCampaignId() %>"
        data-campaign-title="<%=campaign.getCampaign_Title() %>"
        data-campaign-text="<%=campaign.getText() %>"
        data-bs-toggle="modal"
        data-bs-target="#CampaignModal"
        >
            <div class="card h-100">
                <img
                    src="<%= request.getContextPath() %>/ImageServlet_Campaign?campaignId=<%= campaign.getCampaignId() %>"
                    class="card-img-top"
                    alt="<%= campaign.getCampaign_Title() %>"
                >
            </div>
            </button>
        </div>
        <%
        }
        %>
    </div>
</div>
		
		
		
		</main>

	</div>
	
	<div class="modal fade" id="CampaignModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="campaignModalTitle"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <img id="campaignModalImg" class="img-fluid mb-3 d-block mx-auto " style="max-height: 400px;">
        <p id="campaignModalText" class="cart-box"></p>
      </div>
    </div>
  </div>
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
		<input type="hidden" name="command"
			value="MemberInfomation">
	</form>
	<form action="KiddaLaController" method="post" id="fm7">
		<input type="hidden" name="command"
			value="MemberInfomation">
	</form>
	<form id="cartForm" action="KiddaLaController" method="post">
    <input type="hidden" name="command" value="ProceedToCheckout">
    <input type="hidden" name="cartData" id="cartData">
</form>
<script>
document.addEventListener('DOMContentLoaded', function () {
const modal = document.getElementById('CampaignModal');

modal.addEventListener('show.bs.modal', function (event) {
  const button = event.relatedTarget;

  const img = button.getAttribute('data-campaign-img');
  const title = button.getAttribute('data-campaign-title');
  const text = button.getAttribute('data-campaign-text');

  modal.querySelector('#campaignModalImg').src = img;
  modal.querySelector('#campaignModalTitle').textContent = title;
  modal.querySelector('#campaignModalText').textContent = text;
});
});
</script>

</body>
</html>