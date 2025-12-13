#!/bin/bash
# -----------------------------------------------------------------------------
# Script:      optimism-setup.sh
# Description: Automates the setup of a Node.js-based Optimism DApp development environment.
# Author:      [YOUR_NAME_OR_USERNAME]
# Version:     1.0.0
# License:     MIT
# -----------------------------------------------------------------------------

# --- Configuration ---
PROJECT_NAME="optimism-dapp-starter"

# --- Functions ---

# Function to check if a required command exists
check_command() {
    echo -n "Checking for $1... "
    if command -v "$1" &> /dev/null; then
        echo "✅ Found."
    else
        echo "❌ Error: Required command '$1' is not installed. Please install it first." >&2
        exit 1
    fi
}

# --- Main Execution ---

echo "--- 🚀 Starting Optimism Dev Environment Setup ---"

# 1. Check dependencies
echo "1. Checking required tools (node, npm, git)..."
check_command "node"
check_command "npm"
check_command "git"

# 2. Create and enter the project directory
if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️ Directory $PROJECT_NAME already exists. Skipping creation."
    cd $PROJECT_NAME
else
    echo "2. Creating project directory: $PROJECT_NAME"
    mkdir $PROJECT_NAME
    cd $PROJECT_NAME
fi

# 3. Initialize Node.js project
echo "3. Initializing Node.js project and package.json..."
# Create a default package.json without prompts
npm init -y > /dev/null 2>&1

# 4. Install Optimism-related dependencies
echo "4. Installing core dependencies (ethers, dotenv) for L2 interaction..."
# Install ethers v6 (modern standard) and dotenv
npm install ethers@^6 dotenv > /dev/null 2>&1

# 5. Create a simple entry file
echo "5. Creating a placeholder index.js file..."
cat <<EOF > index.js
// Optimism Starter Project Entry File

const ethers = require('ethers');
const dotenv = require('dotenv');
dotenv.config();

// Example RPC URL (ensure you configure .env file)
const rpcUrl = process.env.OP_RPC_URL || 'https://mainnet.optimism.io';

const provider = new ethers.JsonRpcProvider(rpcUrl);

async function checkConnection() {
    try {
        const network = await provider.getNetwork();
        const blockNumber = await provider.getBlockNumber();
        console.log("-----------------------------------------");
        console.log(\`✅ Connected to network: \${network.name}\`);
        console.log(\`Current Block Number: \${blockNumber}\`);
        console.log("-----------------------------------------");
        console.log("Setup verified! Start coding your dApp.");
    } catch (error) {
        console.error("❌ Failed to connect to Optimism RPC. Check your .env file.");
    }
}

checkConnection();
EOF

echo ""
echo "--- 🎉 Setup Complete! ---"
echo "Project created in: ./$PROJECT_NAME"
echo "Next steps:"
echo "1. cd $PROJECT_NAME"
echo "2. Create a .env file and set: OP_RPC_URL=YOUR_OPTIMISM_RPC"
echo "3. Run: node index.js to verify connection."
echo "---------------------------"
