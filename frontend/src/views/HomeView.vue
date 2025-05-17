<template>
  <div class="home">
    <h2>Welcome to Our eCommerce Store</h2>
    <p>Discover our amazing products and start shopping today!</p>
    <RouterLink to="/products">
      <button>Shop Now</button>
    </RouterLink>
  </div>
</template>

<script>
export default {
  name: 'Home'
}
</script>

<style scoped>
.home {
  text-align: center;
  padding: 40px;
}
button {
  background: #42b983;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}
button:hover {
  background: #2c3e50;
}
</style>