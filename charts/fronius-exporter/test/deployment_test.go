package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	appv1 "k8s.io/api/apps/v1"
)

var tplDeployment = []string{"templates/deployment.yaml"}

func Test_Deployment_GivenTimeoutOverridden_ThenRenderNewValue(t *testing.T) {
	options := &helm.Options{
		SetValues: map[string]string{
			"exporter.timeoutSeconds": "3",
		},
	}

	deployment := renderDeployment(t, options)
	args := deployment.Spec.Template.Spec.Containers[0].Args
	assert.Contains(t, args, "--symo.timeout=3")
}

func Test_Deployment_GivenAdditionalArgs_ThenRenderMoreCliArgs(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/deployment_1.yaml"},
	}

	deployment := renderDeployment(t, options)
	args := deployment.Spec.Template.Spec.Containers[0].Args
	assert.Contains(t, args, "--arg1")
	assert.Contains(t, args, "--arg2=key=value")
}

func renderDeployment(t *testing.T, options *helm.Options) appv1.Deployment {
	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplDeployment)
	var deployment appv1.Deployment
	helm.UnmarshalK8SYaml(t, output, &deployment)
	return deployment
}
