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

export default {
  name: 'App',
  components: {
  },
  setup() {
    const question = ref('');
    const textareaData = ref('');
    const isLoading = ref(false);
    
    // Hugging Face configuration
    const HF_API_URL = 'https://router.huggingface.co/v1';
    const HF_API_TOKEN = process.env.VUE_APP_HF_API_TOKEN; // Your token

    console.log('HF_API_TOKEN', HF_API_TOKEN);
    
    
    const loadOpenAi = async () => {
      if (question?.value) {
        isLoading.value = true;
        
        try {
          // Call Hugging Face Router API directly from frontend
          const response = await fetch(`${HF_API_URL}/chat/completions`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `Bearer ${HF_API_TOKEN}`
            },
            body: JSON.stringify({
              model: "Qwen/Qwen3-Next-80B-A3B-Instruct",
              messages: [
                {
                  role: "system",
                  content: "You are a friendly and supportive AI companion. Respond in a warm, helpful, and encouraging way. Keep responses conversational and positive."
                },
                {
                  role: "user", 
                  content: question.value
                }
              ],
              max_tokens: 200,
              temperature: 0.7
            })
          });
          
          const data = await response.json();
          
          if (data.choices && data.choices.length > 0) {
            textareaData.value = data.choices[0].message.content;
          } else if (data.error) {
            textareaData.value = `Error: ${data.error.message || data.error}`;
          } else {
            textareaData.value = "I'm here to chat! How can I help you today?";
          }
          
        } catch (error) {
          console.error('Error calling AI:', error);
          textareaData.value = `Sorry, I encountered an error: ${error.message}. Please try again.`;
        }
        
        isLoading.value = false;
        question.value = ''; // Clear the input after sending
      } else {
        alert('Please enter conversation in the text field!');
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
