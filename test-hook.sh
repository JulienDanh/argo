#!/bin/bash

# Test script for the pre-sync and post-sync hooks

echo "Testing pre-sync hook locally..."
echo "Running pre-sync hook script:"
python app/hooks/pre-sync.py hello

echo ""
echo "Testing post-sync hook locally..."
echo "Running post-sync hook script:"
python app/hooks/post-sync.py complete

echo ""
echo "Testing health commands:"
echo "Pre-sync health:"
python app/hooks/pre-sync.py health
echo "Post-sync health:"
python app/hooks/post-sync.py health

echo ""
echo "Hook tests completed!" 