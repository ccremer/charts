
#
# "Interface" for parent Makefile
#
prepare: ## Prepare helm chart
	helm repo add ccremer https://ccremer.github.io/charts
	helm repo add influx https://helm.influxdata.com
	helm dep build
