#!/bin/bash

ENDPOINT_URL="http://localhost:4566"  # default localstack endpoint
FUNCTION_NAME="example-python"
OUTFILE="/dev/stdout"                 # throws away lambda output rather than returning it in a file. If you want an actual file, change this to something like response.json
PAYLOAD='{"Message":"Greetings__from__localstack!"}'

while getopts e:f:o:p: flag
do
  case "${flag}" in
    e) ENDPOINT_URL=${OPTARG};;
    f) FUNCTION_NAME=${OPTARG};;
    o) OUTFILE=${OPTARG};;
    p) PAYLOAD=${OPTARG};;
  esac
done

# invoke lambda
aws lambda invoke \
  --function-name $FUNCTION_NAME \
  --endpoint-url $ENDPOINT_URL \
  --cli-binary-format raw-in-base64-out \
  --payload $PAYLOAD \
  $OUTFILE
