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
    # Print the contents of the ConfigMap JSON if available
    try:
        with open("/config/config.json", "r") as f:
            config_json = f.read()
        print("📦 ConfigMap config.json contents:")
        print(config_json)
    except Exception as e:
        print(f"⚠️ Could not read /config/config.json: {e}")
    print(f"🚀 Post-sync hook finished successfully")
    sys.exit(0)

@app.command()
def health():
    """Health check command"""
    print("healthy")
    sys.exit(0)

if __name__ == "__main__":
    app() 