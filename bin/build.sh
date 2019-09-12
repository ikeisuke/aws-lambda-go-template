#!/bin/bash
WORKSPACE=$(cd $(dirname $0)/../; pwd)
find ./handlers -name '*.go' | while read FILE; do
  FUNCDIR=$(dirname ${FILE})
  EXECNAME=$(basename ${FUNCDIR})
  cd ${WORKSPACE}
  cd ${FUNCDIR}
  go mod download
  GOARCH=amd64 GOOS=linux go build -o ${WORKSPACE}/build/${EXECNAME}
done
