MAKEFLAGS += --warn-undefined-variables
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
.SUFFIXES:

# git tag of the app version to fetch
# defaults to tag specified in values.yaml, as this gets maintained by renovate
APP_VERSION := $(shell grep -E "^  tag: " values.yaml | cut -d " " -f 4 | sed s/\"//g)

SED_CMD := sed
HELM_DOCS_IMAGE := jnorwood/helm-docs:v1.4.0
GITHUB_RELEASE_URL := https://github.com/ccremer/clustercode/releases/download
REPLACE_LABEL := {{- include "clustercode.staticLabels" . | nindent 4 }}
REPLACE_NAME_PREFIX := {{ include "clustercode.fullname" . }}-
REPLACE_SA_NAME := {{ include "clustercode.serviceAccountName" . }}

.PHONY: rbac
rbac: templates/rbac.yaml ## Update the RBAC templates by building them from Kustomize

.PHONY: templates/rbac.yaml
templates/rbac.yaml:
	kustomize build kustomize -o $@
	$(SED_CMD) -i -e '1i{{- if .Values.rbac.create -}}' $@
	$(SED_CMD) -i -e 's/replace: LABELS/$(REPLACE_LABEL)/g' $@
	$(SED_CMD) -i -e 's/PREFIX-/$(REPLACE_NAME_PREFIX)/g' $@
	$(SED_CMD) -i -e 's/name: default/name: $(REPLACE_SA_NAME)/g' $@
	$(SED_CMD) -i -e '$$a{{- end }}' $@

.PHONY: appVersion
appVersion: ## Replaces "appVersion" in Chart.yaml with 'image.tag' from values.yaml
	$(SED_CMD) -i -e 's/^appVersion.*/appVersion: $(APP_VERSION)/' Chart.yaml

.PHONY: update
update: rbac appVersion ## Updates all templates

.PHONY: help
help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

#
# "Interface" for parent Makefile
#
prepare: ## Prepare helm chart
