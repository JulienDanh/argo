#!/usr/bin/env python3

import typer
import sys
from datetime import datetime

app = typer.Typer()

@app.command()
def hello():
    """Simple hello world command for ArgoCD pre-sync hook"""
    print(f"🚀 Hello World from pre-sync hook!")
    print(f"⏰ Timestamp: {datetime.now().isoformat()}")
    print(f"✅ Pre-sync hook completed successfully")
    sys.exit(0)

@app.command()
def health():
    """Health check command"""
    print("healthy")
    sys.exit(0)

if __name__ == "__main__":
    app() 