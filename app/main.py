from fastapi import FastAPI

app = FastAPI(
    title="Simple FastAPI App",
    description="A simple FastAPI application deployed with ArgoCD",
    version="1.0.0"
)

@app.get("/")
async def root():
    """Simple hello world endpoint"""
    return {"message": "Hello World from FastAPI!"}

@app.get("/health")
async def health_check():
    """Health check endpoint"""
    return {"status": "healthy"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000) 