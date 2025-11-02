from openai import OpenAI

# 注意：请将 YOUR_API_KEY 替换为您自己的API密钥
# 此文件仅作为示例，实际应用中API密钥应通过应用设置配置
client = OpenAI(
    base_url='https://api-inference.modelscope.cn/v1',
    api_key='YOUR_API_KEY', # 请替换为您的ModelScope Token
)

response = client.chat.completions.create(
    model='Qwen/Qwen3-30B-A3B-Instruct-2507', # ModelScope Model-Id
    messages=[
        {
            'role': 'system',
            'content': 'You are a helpful assistant.'
        },
        {
            'role': 'user',
            'content': '你好'
        }
    ],
    stream=True
)

for chunk in response:
    print(chunk.choices[0].delta.content, end='', flush=True)