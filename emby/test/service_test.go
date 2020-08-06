package test

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	corev1 "k8s.io/api/core/v1"
)

var (
	tplService = []string{"templates/service.yaml"}
)

func Test_Service_WhenServicePortOverridden_ThenRenderNewPort(t *testing.T) {
	expectedHttpPort := int32(8080)
	expectedHttpsPort := int32(8443)
	options := &helm.Options{
		SetValues: map[string]string{
			"service.httpPort":  fmt.Sprintf("%d", expectedHttpPort),
			"service.httpsPort": fmt.Sprintf("%d", expectedHttpsPort),
		},
	}

	service := renderService(t, options, false)

	assert.Equal(t, expectedHttpPort, service.Spec.Ports[0].Port, "Service does not use configured port")
	assert.Equal(t, expectedHttpsPort, service.Spec.Ports[1].Port, "Service does not use configured port")
}

func Test_Service_GivenTypeNodePort_WhenNodePortDefine_ThenRenderNodePort(t *testing.T) {
	expectedHttpPort := int32(30080)
	expectedHttpsPort := int32(30443)
	options := &helm.Options{
		SetValues: map[string]string{
			"service.httpNodePort":  fmt.Sprintf("%d", expectedHttpPort),
			"service.httpsNodePort": fmt.Sprintf("%d", expectedHttpsPort),
			"service.type":          "NodePort",
		},
	}

	service := renderService(t, options, false)

	assert.Equal(t, expectedHttpPort, service.Spec.Ports[0].NodePort, "Service does not use configured node port")
	assert.Equal(t, expectedHttpsPort, service.Spec.Ports[1].NodePort, "Service does not use configured node port")
	assert.Equal(t, corev1.ServiceTypeNodePort, service.Spec.Type, "Service does not use configured type")
}

func renderService(t *testing.T, options *helm.Options, wantErr bool) *corev1.Service {
	output, err := helm.RenderTemplateE(t, options, helmChartPath, releaseName, tplService)
	if wantErr {
		require.Error(t, err)
		return nil
	}
	require.NoError(t, err)
	service := corev1.Service{}
	helm.UnmarshalK8SYaml(t, output, &service)
	return &service
}
