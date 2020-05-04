package test

import (
	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	v1 "k8s.io/api/core/v1"
	"testing"
)

var tplConfigMap = []string{"templates/configmap.yaml"}

func Test_ConfigMap_GivenBackupPlans_WhenCustomField_ThenRenderCustomFile(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/configmap_1.yaml"},
	}

	expectedContent := "mycustomcontent=invalid-znapzend-config"

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplConfigMap)

	var configmap v1.ConfigMap
	helm.UnmarshalK8SYaml(t, output, &configmap)

	assert.Equal(t, expectedContent, configmap.Data["plan0"])

}

func Test_ConfigMap_GivenPlanField_WhenMinimalConfig_ThenRenderPlanWithDefaults(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/configmap_2.yaml"},
		SetValues: map[string]string{
			"metrics.enabled": "false",
		},
	}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplConfigMap)

	var configmap v1.ConfigMap
	helm.UnmarshalK8SYaml(t, output, &configmap)

	plan := configmap.Data["plan0"]
	expectedPlan := `enabled=on
src_plan=1days=>2hours,2weeks=>1days,6months=>1weeks
recursive=off
tsformat=%Y-%m-%d-%H%M%S
mbuffer_size=1G
mbuffer=off
zend_delay=0`

	assert.Equal(t, expectedPlan, plan)
}

func Test_ConfigMap_GivenPlanField_WhenMetricsEnabled_ThenRenderSourceWithReset(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/configmap_2.yaml"},
	}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplConfigMap)

	var configmap v1.ConfigMap
	helm.UnmarshalK8SYaml(t, output, &configmap)

	plan := configmap.Data["plan0"]
	expectedPlan := `enabled=on
src_plan=1days=>2hours,2weeks=>1days,6months=>1weeks
pre_znap_cmd=/usr/bin/curl -sS localhost:8080/presnap/tank/test/dataset
post_znap_cmd=/usr/bin/curl -sS localhost:8080/postsnap/tank/test/dataset?SelfResetAfter=5m
recursive=off
tsformat=%Y-%m-%d-%H%M%S
mbuffer_size=1G
mbuffer=off
zend_delay=0`

	assert.Equal(t, expectedPlan, plan)
}

func Test_ConfigMap_GivenPlanField_WhenTargetsGiven_ThenRenderTargets(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/configmap_3.yaml"},
		SetValues: map[string]string{
			"metrics.enabled": "false",
		},
	}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplConfigMap)

	var configmap v1.ConfigMap
	helm.UnmarshalK8SYaml(t, output, &configmap)

	plan := configmap.Data["plan0"]
	expectedPlan := `enabled=on
src_plan=1days=>2hours,2weeks=>1days,6months=>1weeks
dst_0=target.host:backup/target
dst_0_plan=1days=>2hours
recursive=on
tsformat=%Y-%m-%d-%H%M%S
mbuffer_size=1G
mbuffer=off
zend_delay=600`

	assert.Equal(t, expectedPlan, plan)
}

func Test_ConfigMap_GivenPlanField_WhenTargetsAndMetricsGiven_ThenRenderTargetsWithMetrics(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/configmap_3.yaml"},
	}

	output := helm.RenderTemplate(t, options, helmChartPath, releaseName, tplConfigMap)

	var configmap v1.ConfigMap
	helm.UnmarshalK8SYaml(t, output, &configmap)

	plan := configmap.Data["plan0"]
	expectedPlan := `enabled=on
src_plan=1days=>2hours,2weeks=>1days,6months=>1weeks
dst_0=target.host:backup/target
dst_0_plan=1days=>2hours
dst_0_precmd=/usr/bin/curl -sS localhost:8080/presend/tank/test/dataset
dst_0_pstcmd=/usr/bin/curl -sS localhost:8080/postsend/tank/test/dataset?SelfResetAfter=1h
pre_znap_cmd=/usr/bin/curl -sS localhost:8080/presnap/tank/test/dataset
post_znap_cmd=/usr/bin/curl -sS localhost:8080/postsnap/tank/test/dataset
recursive=on
tsformat=%Y-%m-%d-%H%M%S
mbuffer_size=1G
mbuffer=off
zend_delay=600`

	assert.Equal(t, expectedPlan, plan)
}
