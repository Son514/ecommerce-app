<template>
  <div class="products">
    <h2>Our Products</h2>
    <div class="product-grid">
      <div v-for="product in products" :key="product.id" class="product-card">
        <img :src="product.image" :alt="product.name" class="product-image" />
        <h3>{{ product.name }}</h3>
        <p>{{ product.description }}</p>
        <p class="price">${{ product.price }}</p>
        <button @click="addToCart(product)">Add to Cart</button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Products',
  data() {
    return {
      products: [
        {
          id: 1,
          name: 'Laptop',
          description: 'High-performance laptop for work and gaming.',
          price: 999.99,
          image: 'https://placehold.co/600x400'
        },
        {
          id: 2,
          name: 'Headphones',
          description: 'Wireless headphones with noise cancellation.',
          price: 199.99,
          image: 'https://placehold.co/600x400'
        },
        {
          id: 3,
          name: 'Smartphone',
          description: 'Latest smartphone with advanced features.',
          price: 699.99,
          image: 'https://placehold.co/600x400'
        }
      ]
    }
  },
  methods: {
    addToCart(product) {
      alert(`Added ${product.name} to cart!`)
    }
  }
}
</script>

<style scoped>
.products {
  padding: 20px;
}
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 20px;
}
.product-card {
  border: 1px solid #e0e0e0;
  padding: 15px;
  text-align: center;
  border-radius: 8px;
  background: #fff;
}
.product-image {
  max-width: 100%;
  height: auto;
  border-radius: 4px;
}
.price {
  color: #42b983;
  font-weight: bold;
  margin: 10px 0;
}
button {
  background: #42b983;
  color: white;
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}
button:hover {
  background: #2c3e50;
}
</style>