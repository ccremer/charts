
repo: ## Initialize depedant repositories
	helm repo add ccremer https://ccremer.github.io/charts
	helm repo add influx https://helm.influxdata.com

update: repo ## Update helm dependencies
	helm dep update

#
# "Interface" for parent Makefile
#
prepare: repo ## Prepare helm chart
	helm dep build
