#!/bin/bash
cfn_nag --debug vpc.json
if [[ $? != 0 ]];
then
  exit 1
  # stop the pipeline
fi
