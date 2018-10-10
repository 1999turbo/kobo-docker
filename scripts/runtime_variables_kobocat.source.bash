if [[ ! -z "${PUBLIC_DOMAIN_NAME}" ]]; then
    if [ ${NGINX_PORT} != "" ]; then
        PUBLIC_PORT=":${NGINX_PORT}"
    else
        PUBLIC_PORT=""
    fi
    # Server configuration.
    export KOBOFORM_URL="${PUBLIC_REQUEST_SCHEME}://${KOBOFORM_PUBLIC_SUBDOMAIN}.${PUBLIC_DOMAIN_NAME}${PUBLIC_PORT}"
    export KOBOFORM_INTERNAL_URL="http://${KOBOFORM_PUBLIC_SUBDOMAIN}.${INTERNAL_DOMAIN_NAME}" # Always use HTTP internally.
    export ENKETO_URL="${PUBLIC_REQUEST_SCHEME}://${ENKETO_EXPRESS_PUBLIC_SUBDOMAIN}.${PUBLIC_DOMAIN_NAME}${PUBLIC_PORT}"
    export CSRF_COOKIE_DOMAIN=".${PUBLIC_DOMAIN_NAME}"
    export DJANGO_ALLOWED_HOSTS=".${PUBLIC_DOMAIN_NAME} .${INTERNAL_DOMAIN_NAME}"
elif [[ ! -z "${HOST_ADDRESS}" ]]; then
    # Local.
    export KOBOFORM_URL="http://${HOST_ADDRESS}:${KPI_PUBLIC_PORT}"
    export KOBOFORM_INTERNAL_URL="${KOBOFORM_INTERNAL_URL}" # FIXME: Use an actual internal URL.
    export ENKETO_URL="http://${HOST_ADDRESS}:${ENKETO_EXPRESS_PUBLIC_PORT}"
    export CSRF_COOKIE_DOMAIN="${HOST_ADDRESS}"
    export DJANGO_ALLOWED_HOSTS='*'
else
    echo 'Please fill out your `envfile`!'
    exit 1
fi

export KOBOCAT_AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export KOBOCAT_AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
export KPI_URL="${KOBOFORM_URL}"
export KPI_INTERNAL_URL="${KOBOFORM_INTERNAL_URL}"  # Copy the same logic as before but why do we need another variable?
export DJANGO_DEBUG="${KOBOCAT_DJANGO_DEBUG}"
export RAVEN_DSN="${KOBOCAT_RAVEN_DSN}"
