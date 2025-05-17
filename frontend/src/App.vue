<template>
  <div class="container">
    <header>
      <h1>eCommerce Store</h1>
      <nav>
        <RouterLink to="/">Home</RouterLink>
        <RouterLink to="/products">Products</RouterLink>
      </nav>
    </header>
    <main>
      <RouterView />
    </main>
    <footer>
      <p>&copy; 2025 eCommerce Store</p>
    </footer>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style scoped>
.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif;
}
header {
  text-align: center;
  padding: 20px 0;
}
nav {
  margin: 20px 0;
}
nav a {
  margin: 0 15px;
  text-decoration: none;
  color: #2c3e50;
  font-weight: bold;
}
nav a:hover {
  color: #42b983;
}
footer {
  text-align: center;
  padding: 20px 0;
  margin-top: 40px;
  border-top: 1px solid #e0e0e0;
}
</style>