package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	appv1 "k8s.io/api/apps/v1"
)

var tplDeployment = []string{"templates/deployment.yaml"}

func Test_Deployment_GivenAdditionalVolumeMounts_ThenRenderMountPaths(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/deployment_1.yaml"},
	}

	deployment := renderDeployment(t, options)
	volumeMounts := deployment.Spec.Template.Spec.Containers[0].VolumeMounts
	assert.Equal(t, "/mnt", volumeMounts[0].MountPath)
	assert.Equal(t, "test", volumeMounts[0].Name)
}

func Test_Deployment_GivenAdditionalVolumes_ThenRenderVolumes(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/deployment_1.yaml"},
	}

	deployment := renderDeployment(t, options)
	volumes := deployment.Spec.Template.Spec.Volumes
	assert.Equal(t, "test", volumes[0].Name)
	assert.Equal(t, "testClaim", volumes[0].PersistentVolumeClaim.ClaimName)
}

func Test_Deployment_GivenPersistenceEnabled_ThenRenderVolume(t *testing.T) {
	options := &helm.Options{
		SetValues: map[string]string{
			"persistence.enabled": "true",
		},
	}

	expectedName := "config"
	deployment := renderDeployment(t, options)
	volumes := deployment.Spec.Template.Spec.Volumes
	volumeMounts := deployment.Spec.Template.Spec.Containers[0].VolumeMounts
	assert.Equal(t, expectedName, volumes[0].Name)
	assert.Equal(t, releaseName+"-emby-config", volumes[0].PersistentVolumeClaim.ClaimName)
	assert.Equal(t, "/config", volumeMounts[0].MountPath)
	assert.Equal(t, expectedName, volumeMounts[0].Name)
}

func renderDeployment(t *testing.T, options *helm.Options) appv1.Deployment {
	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplDeployment)
	var deployment appv1.Deployment
	helm.UnmarshalK8SYaml(t, output, &deployment)
	return deployment
}
