#!/bin/bash

UPLOAD_COMMAND="localazy upload"

if [ ! -z "$INPUT_CONFIG_FILE" ]; then
  UPLOAD_COMMAND="$UPLOAD_COMMAND -c $INPUT_CONFIG_FILE"
fi

if [ ! -z "$INPUT_READ_KEY" ]; then
  UPLOAD_COMMAND="$UPLOAD_COMMAND -r $INPUT_READ_KEY"
fi

if [ ! -z "$INPUT_WRITE_KEY" ]; then
  UPLOAD_COMMAND="$UPLOAD_COMMAND -w $INPUT_WRITE_KEY"
fi

if [ ! -z "$INPUT_WORKDIR" ]; then
  cd $INPUT_WORKDIR
fi

$UPLOAD_COMMAND

BRANCH="${GITHUB_REF##*/}"

if [ ! -z "$INPUT_PUBLISH" ]; then
  PUBLISH_COMMAND="localazy tag publish"
  TAG_NAME=$(jq -r --arg branch "$BRANCH" '.[$branch]' <<< "$INPUT_PUBLISH")

  if [ ! -z "$TAG_NAME" ]; then
    $PUBLISH_COMMAND $TAG_NAME
  fi
fi

if [ ! -z "$INPUT_PROMOTE" ]; then
  PROMOTE_COMMAND="localazy tag promote"
  FROM_TAG=$(jq -r --arg branch "$BRANCH" '.[$branch].from' <<< "$INPUT_PROMOTE")
  TO_TAG=$(jq -r --arg branch "$BRANCH" '.[$branch].to' <<< "$INPUT_PROMOTE")

  if [ ! -z "$FROM_TAG" ]; then
    $PROMOTE_COMMAND $FROM_TAG $TO_TAG
  fi
fi
