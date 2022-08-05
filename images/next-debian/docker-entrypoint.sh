#!/bin/sh
set -ea

if [ "$*" = "next" ]; then

  if [ ! -f "package.json" ]; then

    DATABASE_CLIENT=${DATABASE_CLIENT:-sqlite}

    EXTRA_ARGS=${EXTRA_ARGS}

    echo "Using next $(next version)"
    echo "No project found at /srv/app. Creating a new strapi project ..."

    DOCKER=true yarn create next-app $EXTRA_ARGS

  elif [ ! -d "node_modules" ] || [ ! "$(ls -qAL node_modules 2>/dev/null)" ]; then

    if [ -f "yarn.lock" ]; then

      echo "Node modules not installed. Installing using yarn ..."
      yarn install --prod --silent

    else

      echo "Node modules not installed. Installing using npm ..."
      npm install --only=prod --silent

    fi

  fi

  if [ "$NODE_ENV" = "production" ]; then
    APP_MODE="start"
  elif [ "$NODE_ENV" = "development" ]; then
    APP_MODE="dev"
  fi

  echo "Starting your app (with ${APP_MODE:-develop})..."
  exec yarn "${APP_MODE:-develop}"

else
  exec "$@"
fi