#!/bin/bash
set -e

OUTPUT_FILE=`mktemp`

time (tar -czf "${OUTPUT_FILE}.xz" .)

# Use the pinata_api.py script to pin the file to IPFS
echo "Uploading the compressed image to IPFS.."
response=$(python pinata_api.py "${OUTPUT_FILE}.xz")

# Extract the IpfsHash from the response using Python
echo "Extracting IpfsHash.."
ipfs_hash=$(python -c "import json; data = $response; print(data.get('IpfsH`ash', ''))")
echo "Model definition IPFS hash: $ipfs_hash"

