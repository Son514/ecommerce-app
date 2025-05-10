<template>
  <div class="container">
    <h1>Simple E-Commerce Apps</h1>
    <div v-if="products.length">
      <div v-for="product in products" :key="product.id" class="product">
        <h3>{{ product.name }}</h3>
        <p>Price: ${{ product.price }}</p>
        <button @click="addToCart(product)">Add to Cart</button>
      </div>
    </div>
    <p v-else>Loading products...</p>
    <h2>Cart</h2>
    <ul>
      <li v-for="item in cart" :key="item.id">{{ item.name }} - ${{ item.price }}</li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      products: [],
      cart: []
    };
  },
  async created() {
    try {
      const response = await axios.get('http://localhost:5000/api/products');
      this.products = response.data;
    } catch (error) {
      console.error('Error fetching products:', error);
    }
  },
  methods: {
    addToCart(product) {
      this.cart.push(product);
    }
  }
};
</script>

<style>
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}
.product {
  border: 1px solid #ccc;
  padding: 10px;
  margin: 10px 0;
}
</style>