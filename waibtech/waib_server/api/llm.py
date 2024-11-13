from langchain_core.output_parsers.json import SimpleJsonOutputParser
from langchain.prompts import PromptTemplate
from langchain_community.llms import Ollama

prompt = PromptTemplate.from_template(
   '''
   Explain the concert {data} and return in string format.
   '''
)

## I am using Ollama locally. Hence the simple solution. 

def get_summary(data):
    model = Ollama(
                model='phi3',  top_p=0.01,
                temperature=0.01,
            )
    chain = prompt | model 
    llm_response = chain.invoke({ "data":data})
    return llm_response 