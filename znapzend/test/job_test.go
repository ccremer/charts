package test

import (
	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	batchv1 "k8s.io/api/batch/v1"
	v1 "k8s.io/api/core/v1"
	"testing"
)

var tplJob = []string{"templates/job.yaml"}

func Test_Job_GivenBackupPlans_WhenEnabled_ThenRenderEnvironmentVariables(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/job_1.yaml"},
	}

	expectedKeys := []string{"KEY1", "ANOTHER_KEY"}
	expectedValues := []string{"value", "another value"}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplJob)

	var job batchv1.Job
	helm.UnmarshalK8SYaml(t, output, &job)

	envs := job.Spec.Template.Spec.Containers[0].Env
	for i, _ := range envs {
		require.Contains(t, envs, v1.EnvVar{
			Name:  expectedKeys[i],
			Value: expectedValues[i],
		})
	}
}

func Test_Job_GivenBackupPlans_WhenSshIdentitiesProvided_ThenRenderVolumes(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/job_2.yaml"},
	}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplJob)

	var job batchv1.Job
	helm.UnmarshalK8SYaml(t, output, &job)

	volumeMounts := job.Spec.Template.Spec.Containers[0].VolumeMounts
	assertSshVolumeMounts(t, volumeMounts)

	volumes := job.Spec.Template.Spec.Volumes
	assertSshVolume(t, volumes)
}

func Test_Job_GivenBackupPlans_WhenMultiplePlans_ThenRenderCommandArgs(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/job_2.yaml"},
	}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplJob)

	var job batchv1.Job
	helm.UnmarshalK8SYaml(t, output, &job)

	args := job.Spec.Template.Spec.Containers[0].Args
	expectedArgs := `set -e &&
znapzendzetup import --write pool/dataset1 /etc/znapzend/plan0 &&
znapzendzetup import --write pool/dataset2 /etc/znapzend/plan1 &&
echo "$?" > /tmp/znapzend/success
`

	assert.Equal(t, args[0], expectedArgs)
}
