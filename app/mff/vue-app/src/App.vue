<script setup>
import { ref } from 'vue'

const msg = ref('Vue, Hello World!')
</script>

<template>
  <h1>{{ msg }}</h1>
  <input v-model="msg" />
</template>
