const clientId = "your cognito client id";  
const domain = "cognito domain without https://"; 
const redirectUri = "path of your callback page"; 

const apiUrl = "your url of stage/orders";

const loginBtn = document.getElementById('loginBtn');
const logoutBtn = document.getElementById('logoutBtn');
const orderForm = document.getElementById('orderForm');

function isLoggedIn() {
  return !!localStorage.getItem('access_token');
}

function showUI() {
  if (isLoggedIn()) {
    loginBtn.style.display = "none";
    logoutBtn.style.display = "inline-block";
    orderForm.style.display = "block";
  } else {
    loginBtn.style.display = "inline-block";
    logoutBtn.style.display = "none";
    orderForm.style.display = "none";
  }
}

loginBtn.addEventListener('click', () => {
  const loginUrl = `https://${domain}/login?response_type=token&client_id=${clientId}&redirect_uri=${encodeURIComponent(redirectUri)}`;
  window.location.href = loginUrl;
});

logoutBtn.addEventListener('click', () => {
  localStorage.removeItem('access_token');
  localStorage.removeItem('id_token');
  showUI();
});

orderForm.addEventListener('submit', async (e) => {
  e.preventDefault();
  const customer = document.getElementById("customer").value;
  const items = JSON.parse(document.getElementById("items").value || "[]");
  const accessToken = localStorage.getItem('access_token');

  if (!accessToken) {
    alert("You must be logged in to send orders.");
    return;
  }

  try {
    const res = await fetch(apiUrl, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${accessToken}`
      },
      body: JSON.stringify({ customer, items })
    });

    if (!res.ok) {
      throw new Error(`Server error: ${res.status}`);
    }

    const data = await res.json();
    alert("Order Created: " + data.orderId);
  } catch (error) {
    alert("Failed to send order: " + error.message);
  }
});

showUI();
