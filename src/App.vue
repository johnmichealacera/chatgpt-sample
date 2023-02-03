<template>
  <div class="center">
    <h3>I am a friend you can talk to anytime. Just type what you want and I will be here.</h3>
    <div class="text-and-button">
      <input type="text" name="" id="" v-model="question" class="input-question" @keyup.enter="loadOpenAi()">
      <input type="button" value="Enter friendly conversation" @click="loadOpenAi" class="button-input">
    </div>
    <div v-if="isLoading" class="loading"></div>
    <textarea v-if="!isLoading" name="" id="" cols="80" rows="30"  class="robot-response" v-model="textareaData" disabled></textarea>
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
        const chatgptPrompt = process.env.VUE_APP_CHATGPT_PROMPT;
        const response = await openai.createCompletion({
          model: "text-davinci-003",
          prompt: `${chatgptPrompt} ${question?.value}`,
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
  margin: 0;
  padding: 0;
}
.center {
  background: transparent url('./assets/robot1.png') left no-repeat;
  height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-end;
}
.loading {
  background: transparent url('https://miro.medium.com/max/882/1*9EBHIOzhE1XfMYoKz1JcsQ.gif') center no-repeat;
  height: 400px;
  width: 400px;
  margin-right: 100px;
}
.input-question {
  flex-grow: 2;
  padding: 15px;
  width: 220px;
}
.text-and-button {
  width: 400px;
  display: flex;
  margin-right: 100px;
  justify-content: center;
}
.robot-response {
  width: 400px;
  margin-right: 100px;
}
@media only screen and (max-width: 600px) {
  .center {
    background: transparent url('./assets/robot1.png') center no-repeat;
    background-size: 100% 100%;
    height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-end;
  }
  .input-question {
    flex-grow: 2;
    padding: 15px;
    width: 120px;
  }
  .text-and-button {
    width: 200px;
    display: flex;
    justify-content: center;
  }
  .robot-response {
    width: 200px;
  }
  .loading {
    background: transparent url('https://miro.medium.com/max/882/1*9EBHIOzhE1XfMYoKz1JcsQ.gif') center no-repeat;
    height: 200px;
    width: 200px;
    margin-right: 100px;
  }
}
</style>
