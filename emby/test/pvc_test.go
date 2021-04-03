package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	v1 "k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/resource"
)

var tplPvc = []string{"templates/pvc.yaml"}

func Test_PVC_GivenStorageClass_ThenRenderStorageClass(t *testing.T) {
	expectedClass := "class"
	options := &helm.Options{
		SetValues: map[string]string{
			"persistence.enabled":      "true",
			"persistence.storageClass": expectedClass,
		},
	}

	pvc := renderPvc(t, options)
	assert.Equal(t, expectedClass, *pvc.Spec.StorageClassName)
}

func Test_PVC_GivenSize_ThenRenderSize(t *testing.T) {
	expectedSize := "1Gi"
	options := &helm.Options{
		SetValues: map[string]string{
			"persistence.enabled": "true",
			"persistence.size":    expectedSize,
		},
	}

	pvc := renderPvc(t, options)
	expected := resource.MustParse(expectedSize)
	assert.True(t, expected.Equal(pvc.Spec.Resources.Requests[v1.ResourceStorage]))
}

func renderPvc(t *testing.T, options *helm.Options) v1.PersistentVolumeClaim {
	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplPvc)
	var result v1.PersistentVolumeClaim
	helm.UnmarshalK8SYaml(t, output, &result)
	return result
}
