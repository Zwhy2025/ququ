from openai import OpenAI

client = OpenAI(
    base_url='https://api-inference.modelscope.cn/v1',
    api_key='ms-3d1072a4-1f51-4852-a7bf-58ab9888dd97', # ModelScope Token
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