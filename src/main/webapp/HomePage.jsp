<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.ArrayList, model.Item, model.Customer" %>
	<%
@SuppressWarnings("unchecked")
ArrayList<Item> menuList =
    (ArrayList<Item>) request.getAttribute("DispMenuList");
	if (menuList == null) {
	    menuList = new ArrayList<>();
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
<title>《メインメニュー》 KIDDA-LA 顧客用</title>
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

.menu-scroll-bg {
    position: relative;
    overflow-y: auto;
    height: 100%;
    background: url('<%= request.getContextPath() %>/css/concrete.jpg') repeat-y;
    background-size: cover;
}

.menu-scroll-bg > .row {
    position: relative;
    z-index: 1; 
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
					form="fm8">KIDDA-LA</button>
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

				<main class="container-fluid flex-grow-1"style="margin-top:80px;">
				 
		<div class="row"style="height: calc(100vh - 80px);">
		
			 <div class="col-12 col-lg-9 border-end menu-scroll-bg" style="overflow-y:auto;height:100%;">
			 
	<div class="row g-4">
<%
String lastCategory = "";
for(Item item : menuList) { 
    String category = "";
    if (item.getItemId().startsWith("P")) {
        category = "PIZZA";
    } else if (item.getItemId().startsWith("S")) {
        category = "SIDEMENU";
    } else if (item.getItemId().startsWith("D")) {
        category = "DRINK";
    }else {
        category = "その他";
    }
    if (!category.equals(lastCategory)) {
%>
    <div class="col-12">
        <h3 class="mt-4 mb-2 text-center"><%= category %></h3>
    </div>
<%
        lastCategory = category;
    }
%>
    <div class="col-6 col-sm-4 col-md-3">
      <button type="button" class="p-0 border-0 bg-transparent w-100 h-100"
        data-item-id="<%= item.getItemId() %>"
        data-item-name="<%= item.getItemName() %>"
        data-item-img="<%= request.getContextPath() %>/ImageServlet?itemId=<%= item.getItemId() %>"
        data-bs-toggle="modal"
        data-bs-target="#itemDetailModal">

        <div class="card shadow-sm rounded-3 h-100 " style="background-color: #a62828; border: none;">
          <div class="ratio ratio-4x3 rounded-top overflow-hidden">
            <img id="card-img-<%= item.getItemId() %>" 
                 src="<%= request.getContextPath() %>/ImageServlet?itemId=<%= item.getItemId() %>"
                 class="card-img-top" style="object-fit: cover;">
          </div>

          <div class="card-body text-center text-white py-2">
            <div class="fw-bold fs-6 mb-1"  id="card-name-<%= item.getItemId() %>">
              <%= item.getItemName() %>
            </div>
            <div class="fs-5 fw-bold" id="card-price-<%= item.getItemId() %>">
              ¥<%= item.getPrice()+"～" %>
            </div>
          </div>
        </div>
      </button>
    </div>
<% } %>
</div>

   
   </div>
   
  <div class="col-3 d-none d-lg-flex flex-column cart-box" style="height: 100%;">
  <div class="cart-title">あなたのカート</div>
  <div class="flex-grow-1" style="overflow-y: auto;">
  </div>
  
 <div class="fixed-box text-center">
  <p id="cartTax">内消費税　￥0</p>
  <p id="cartSubtotal">合計　　　￥0</p>
  <button class="btn btn-danger px-4">支払いに進む</button>
</div>
 
  
</div>
   </div>
   
		</main>
		
<div class="modal fade" id="itemDetailModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered" style="max-width: 500px;">
    <div class="modal-content">
      <div class="modal-body text-center p-2">
        <button type="button" class="btn-close position-absolute top-0 end-0 m-2" data-bs-dismiss="modal"></button>
        <img id="modalItemImage" class="img-fluid rounded mb-2">
        <h5 id="modalItemName" class="mb-1 fw-bolder modalItemName"></h5>
        <p id="modalItemDescription" class="mb-1"></p>
        <select id="modalItemSize" class="form-select mt-2" style="max-width:150px; margin:auto;">
  </select>
      </div>
     <div class="modal-footer d-flex justify-content-between align-items-center p-2">
  <div class="fw-bold fs-5 text-danger" style="flex: 1; text-align: center; display: block; font-size: 30px;">
    <span id="modalItemPrice">￥0</span>
  </div>
  <div class="d-flex gap-2">
    <button type="button" class="btn btn-danger px-3 fw-bolder" id="addToCartBtn">
      カートに追加
    </button>
  </div>
</div>
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
	<form action="KiddaLaController" method="post" id="fm8">
		<input type="hidden" name="command"
			value="CampaignPageDisplay">
	</form>
	<form id="cartForm" action="KiddaLaController" method="post">
    <input type="hidden" name="command" value="ProceedToCheckout">
    <input type="hidden" name="cartData" id="cartData">
</form>
	
	
<script>
document.addEventListener('DOMContentLoaded', function () {
    const modal = document.getElementById('itemDetailModal');
    const modalName = document.getElementById('modalItemName');
    const modalImage = document.getElementById('modalItemImage');
    const modalPrice = document.getElementById('modalItemPrice');
    const modalSize = document.getElementById('modalItemSize');
    const addToCartBtn = document.getElementById('addToCartBtn');
    const cartContainer = document.querySelector('.cart-box .flex-grow-1');
    const cartSubtotal = document.getElementById('cartSubtotal');
    const cartTax = document.getElementById('cartTax');

    let cart = [];

    const savedCart = sessionStorage.getItem('cart');
    if (savedCart) {
        try {
            cart = JSON.parse(savedCart);
        } catch (e) {
            cart = [];
        }
    }
    function saveCart() {
        sessionStorage.setItem('cart', JSON.stringify(cart));
    }
            

    modal.addEventListener('show.bs.modal', function (event) {
        const button = event.relatedTarget;
        const itemId = button.getAttribute('data-item-id');
        const itemName = button.getAttribute('data-item-name');
        const itemImg = button.getAttribute('data-item-img');

        modalName.textContent = itemName;
        modalImage.src = itemImg;
        modalName.dataset.itemId = itemId;
        

        fetch('<%= request.getContextPath() %>/GetItemSizes?itemId=' + itemId)
            .then(res => res.json())
            .then(data => {
                modalSize.innerHTML = '';
                if (!Array.isArray(data) || data.length === 0) {
                    modalPrice.textContent = '￥0';
                    return;
                }
                data.forEach(sizeObj => {
                    const option = document.createElement('option');
                    let price = Number(sizeObj.price) || 0;
                    option.value = sizeObj.size || '';
                    option.dataset.price = price;
                    option.textContent = sizeObj.size || 'M';
                    modalSize.appendChild(option);
                });
                modalSize.selectedIndex = 0;
                updateModalPrice();
            })
            .catch(err => {
                console.error(err);
                modalPrice.textContent = '￥0';
            });
    });

    modalSize.addEventListener('change', updateModalPrice);

    function updateModalPrice() {
        const selectedOption = modalSize.selectedOptions[0];
        let price = Number(selectedOption?.dataset.price) || 0;
        modalPrice.textContent = price > 0 ? '￥' + price : '￥0';
    }

    addToCartBtn.addEventListener('click', function () {
        const item = {
            itemId: modalName.dataset.itemId || modalName.textContent,
            name: modalName.textContent,
            size: modalSize.value,
            price: Number(modalSize.selectedOptions[0].dataset.price) || 0,
            quantity: 1
        };

        const existing = cart.find(c => c.itemId === item.itemId && c.size === item.size);
        if (existing) {
            existing.quantity++;
        } else {
            cart.push(item);
        }

        renderCart();
        const modalInstance = bootstrap.Modal.getInstance(modal);
        modalInstance.hide();
    });

    function renderCart() {
        cartContainer.innerHTML = '';
        let subtotal = 0;

        cart.forEach((c, idx) => {
            const div = document.createElement('div');
            div.className = 'mb-2 p-2';
            div.style.borderRadius = '5px';
            div.style.position = 'relative';
            div.style.textAlign = 'center';

            const btn = document.createElement('button');
            btn.className = 'btn btn-sm btn-link text-danger remove-btn';
            btn.textContent = '×';
            btn.dataset.idx = idx;
            btn.style.position = 'absolute';
            btn.style.top = '5px';
            btn.style.right = '5px';
            div.appendChild(btn);

            const nameDiv = document.createElement('div');
            nameDiv.style.fontWeight = 'bold';
            nameDiv.style.marginTop = '20px'; 
            nameDiv.textContent = c.name + ' ' + c.size + ' x' + c.quantity;
            div.appendChild(nameDiv);

            const priceDiv = document.createElement('div');
            priceDiv.className = 'text-danger fs-5';
            priceDiv.textContent = '￥' + (c.price * c.quantity);
            div.appendChild(priceDiv);

            cartContainer.appendChild(div);
        });
            

        subtotal = cart.reduce((sum, c) => sum + c.price * c.quantity, 0);
        const tax = Math.floor(subtotal * 0.1);
        if(cartSubtotal) cartSubtotal.textContent = '合計　￥' + subtotal;
        if(cartTax) cartTax.textContent = '内消費税　￥' + tax;

        saveCart();
        const removeBtns = cartContainer.querySelectorAll('.remove-btn');
        removeBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                const idx = Number(btn.dataset.idx);
                cart.splice(idx, 1);
                renderCart();
            });
        });
    }

    const checkoutBtn = document.querySelector('.fixed-box button');
    checkoutBtn.addEventListener('click', function() {
        if (cart.length === 0) {
            alert('カートが空です');
            return;
        }

        const cartForm = document.getElementById('cartForm');
        cartForm.innerHTML = '<input type="hidden" name="command" value="ProceedToCheckout">';

        cart.forEach((item, idx) => {
            ['itemId','name','size','price','quantity'].forEach(key => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key + '_' + idx;
                input.value = item[key];
                cartForm.appendChild(input);
            });
        });

        const countInput = document.createElement('input');
        countInput.type = 'hidden';
        countInput.name = 'cartCount';
        countInput.value = cart.length;
        cartForm.appendChild(countInput);

        cartForm.submit();
       
    });
        
    renderCart();
         
});
</script>



<style>
#modalItemImage {
  max-width: 300px;
  max-height: 300px;
  object-fit: contain;
  }
  
  #modalItemName {
  font-size: 1.5rem;
  font-weight: 700;
   border-bottom: 2px solid #333; 
}

#modalItemPrice {
  display: block;
  min-width: 80px;
  font-size: 30px;
  color: red;
  text-align: center;
}



</style>
</body>
</html>