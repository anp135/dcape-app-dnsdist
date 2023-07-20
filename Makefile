## dcape-app-dnsdist Makefile
## This file extends Makefile.app from dcape
#:

SHELL               = /bin/bash
CFG                ?= .env

#- App name
APP_NAME           ?= service-dnsdist

#- Docker image name
IMAGE              ?= powerdns/dnsdist-18

#- Docker image tag
IMAGE_VER          ?= 1.8.0

# DNS Dist config for .env

#- Listen IP:PORT
LISTEN             ?= 169.254.255.0:53

#- DNSDist console KEY from config for `make console`
AUTH_KEY            =

# ------------------------------------------------------------------------------

-include $(CFG)
export

# ------------------------------------------------------------------------------
# Find and include DCAPE_ROOT/Makefile
DCAPE_COMPOSE   ?= dcape-compose
DCAPE_ROOT      ?= $(shell docker inspect -f "{{.Config.Labels.dcape_root}}" $(DCAPE_COMPOSE))

ifeq ($(shell test -e $(DCAPE_ROOT)/Makefile.app && echo -n yes),yes)
  include $(DCAPE_ROOT)/Makefile.app
else
  include /opt/dcape/Makefile.app
endif

# ------------------------------------------------------------------------------

# Console access to dnsdist
console: CMD=exec -ti app dnsdist -k "$(AUTH_KEY)" -c 127.0.0.1:52
console: dc
