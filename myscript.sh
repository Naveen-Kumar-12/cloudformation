#!/bin/bash
cfn_nag --debug vpc.json
if [[ $? != 0 ]];
then
  # stop the pipeline
fi
