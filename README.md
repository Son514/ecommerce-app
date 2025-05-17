eCommerce Vue.js Application
A simple eCommerce web application built with Vue.js, containerized with Docker, and hosted on GitHub.
Prerequisites

Node.js (LTS version)
Docker Desktop
Git

Setup Instructions

Clone the Repository:
git clone https://github.com/your-username/ecommerce-vue.git
cd ecommerce-vue


Install Dependencies:
npm install


Run Locally:
npm run dev

Open http://localhost:5173 in your browser.

Run with Docker:
docker build -t ecommerce-vue .
docker run -p 5173:5173 ecommerce-vue

Open http://localhost:5173.


Project Structure

src/App.vue: Main app component with navigation.

src/views/Home.vue: Homepage with a "Shop Now" button.

src/views/Products.vue: Product listing page with sample products.

src/router/index.js: Vue Router configuration.

Dockerfile: Docker configuration for containerization.


Features

Displays a product page with sample products (Laptop, Headphones, Smartphone).
Responsive grid layout for products.
"Add to Cart" button with an alert.
Simple navigation between Home and Products pages.

Troubleshooting

Port Conflict: If port 5173 is in use, stop other processes or use a different port (e.g., docker run -p 8080:5173 ecommerce-vue).
Docker Issues: Ensure Docker Desktop is running and you have sufficient memory.
Git Push Errors: Verify your GitHub credentials and Personal Access Token.

License
MIT License
