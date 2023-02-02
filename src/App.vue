<template>
  <div class="center">
    <input type="text" name="" id="" v-model="question" class="input-question">
    <input type="button" value="JM Button Inquiry" @click="loadOpenAi" class="button-input">
    <div v-if="isLoading" class="loading"></div>
    <textarea v-if="!isLoading" name="" id="" cols="80" rows="30" v-model="textareaData" disabled></textarea>
  </div>
</template>

<script>
import { ref } from 'vue';
const { Configuration, OpenAIApi } = require("openai");
export default {
  name: 'App',
  components: {
  },
  setup() {
    const question = ref('');
    const textareaData = ref('');
    const isLoading = ref(false);
    const configuration = new Configuration({
      apiKey: process.env.VUE_APP_CHATGPT_API_KEY,
    });
    const openai = new OpenAIApi(configuration);
    const loadOpenAi = async () => {
      if (question?.value) {
        isLoading.value = true;
        const response = await openai.createCompletion({
          model: "text-davinci-003",
          prompt: question?.value,
          temperature: 0.7,
          max_tokens: 256,
          top_p: 1,
          frequency_penalty: 0,
          presence_penalty: 0,
        });
        isLoading.value = false;
        textareaData.value = response?.data?.choices?.[0]?.text;
      } else {
        alert('Please enter your inquiry in the text field!');
      }
    }
  

    return {
      textareaData,
      question,
      loadOpenAi,
      isLoading,
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
.center {
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.loading {
  background: transparent url('https://miro.medium.com/max/882/1*9EBHIOzhE1XfMYoKz1JcsQ.gif') center no-repeat;
  height: 400px;
  width: 400px;
}
.input-question {
  padding: 15px;
  width: 220px;
}
.button-input {
  width: 220px;
}
</style>
