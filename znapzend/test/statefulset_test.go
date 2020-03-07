package test

import (
	"github.com/stretchr/testify/require"
	v1 "k8s.io/api/core/v1"
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	appv1 "k8s.io/api/apps/v1"
)

var tplStatefulSet = []string{"templates/statefulset.yaml"}

func Test_StatefulSet_ShouldRender_EnvironmentVariables(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/statefulset_1.yaml"},
	}

	expectedKeys := []string{"KEY1", "ANOTHER_KEY"}
	expectedValues:= []string{"value", "another value"}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplStatefulSet)

	var statefulset appv1.StatefulSet
	helm.UnmarshalK8SYaml(t, output, &statefulset)

	envs := statefulset.Spec.Template.Spec.Containers[0].Env
	for i, _ := range envs {
		require.Contains(t, envs, v1.EnvVar{
			Name:      expectedKeys[i],
			Value:     expectedValues[i],
		})
	}
}