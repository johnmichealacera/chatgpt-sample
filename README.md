# **Happy Chat app with FREE AI**
## This is a serverless happy chat app with integration of FREE AI using Hugging Face Router API

## **Features**
- Respond to conversation in a very friendly manner and might offer some advice and comfort
- **100% FREE** - No API costs using Hugging Face Router API
- **Serverless** - No backend server needed, runs entirely in the browser
- Deployable to Vercel, Netlify, or any static hosting platform
- Uses powerful Qwen AI model for intelligent responses

## Installation

1. Clone the repository: `git clone https://github.com/johnmichealacera/chatgpt-sample.git`
2. Navigate to the project directory: `cd chatgpt-sample`
3. Install dependencies: `npm install`

### Get Your Free Hugging Face Token
1. Go to [Hugging Face Settings](https://huggingface.co/settings/tokens)
2. Create a new token (it's free!)
3. Update the token in `src/App.vue` on line 27:
   ```javascript
   const HF_API_TOKEN = 'your_token_here';
   ```

## Usage

### Local Development
```bash
npm run serve
```
Navigate to `http://localhost:8080/` in your browser

### Production Deployment
1. **Update your token** in `src/App.vue`
2. **Deploy to Vercel/Netlify:**
   - Push to GitHub
   - Connect your repository to Vercel/Netlify
   - Deploy! (No additional configuration needed)

## How to Find and Test Different AI Models

### 1. Browse Available Models
- Go to [Hugging Face Models](https://huggingface.co/models)
- Filter by "Text Generation" or "Conversational"
- Look for models with the "Inference Providers" section

### 2. Check if Model is Available
- On the model page, scroll down to find "Inference Providers"
- If you see providers like "nscale", "serverless", etc., the model is available
- Copy the model name (e.g., `Qwen/Qwen2.5-72B-Instruct`)

### 3. Test the Model
- Replace the model name in `src/App.vue` line 42:
  ```javascript
  model: "YOUR_MODEL_NAME_HERE",
  ```

### 4. Popular Free Models to Try
- `Qwen/Qwen2.5-72B-Instruct` - Very capable, good for conversations
- `microsoft/DialoGPT-medium` - Designed for dialogue
- `meta-llama/Llama-3.2-11B-Vision-Instruct` - Supports vision
- `mistralai/Mistral-7B-Instruct-v0.3` - Fast and efficient

### 5. Test with curl (Optional)
```bash
curl -X POST "https://router.huggingface.co/v1/chat/completions" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "Qwen/Qwen2.5-72B-Instruct",
    "messages": [{"role": "user", "content": "Hello!"}],
    "max_tokens": 100
  }'
```

## Built With
- [Vue.js](https://vuejs.org/v2/guide/) - The web framework used
- [Hugging Face Router API](https://huggingface.co/docs/inference-api) - FREE AI API
- [Qwen AI Model](https://huggingface.co/Qwen) - Powerful language model
- [Vercel](https://vercel.com/) - Deployment platform
## Contributing
1. Fork the repository
2. Create a new branch: `git checkout -b feature-name`
3. Make changes and commit: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature-name`
5. Submit a pull request
## License
This project is licensed under the MIT License - see the [LICENSE.md](https://opensource.org/license/mit/) file for details.

## Acknowledgments
- [Vue.js](https://vuejs.org/v2/guide/) documentation
- [OpenAIApi](https://github.com/openai/openai-cookbook#readme) documentation