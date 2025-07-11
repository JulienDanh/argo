#!/usr/bin/env python3

import typer
import sys
from datetime import datetime

app = typer.Typer()

@app.command()
def complete():
    """Post-sync completion command for ArgoCD"""
    print(f"🎉 Deployment completed successfully!")
    print(f"⏰ Completed at: {datetime.now().isoformat()}")
    print(f"✅ FastAPI app is now running and ready")
    print(f"🚀 Post-sync hook finished successfully")
    sys.exit(0)

@app.command()
def health():
    """Health check command"""
    print("healthy")
    sys.exit(0)

if __name__ == "__main__":
    app() 