#!/bin/bash

# Test script for the pre-sync hook

echo "Testing pre-sync hook locally..."

# Test the hook script directly
echo "Running hook script:"
python hooks/pre-sync.py hello

echo ""
echo "Testing health command:"
python hooks/pre-sync.py health

echo ""
echo "Hook test completed!" 