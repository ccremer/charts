package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/helm"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	corev1 "k8s.io/api/core/v1"
)

var (
	tplTelegrafSecret = []string{"templates/telegraf-secret.yaml"}
)

func Test_TelegrafSecret_WhenDefiningGlobalTags_ThenRenderEachKeyValue(t *testing.T) {
	options := &helm.Options{
		ValuesFiles: []string{"values/telegraf_1.yaml"},
	}

	expectedLine1 := "key1 = value1"
	expectedLine2 := "key2 = value2"
	expectedSection := "[global_tags]"
	config := "telegraf.conf"
	secret := renderSecret(t, options, false, tplTelegrafSecret)

	assert.True(t, strings.Contains(secret.StringData[config], expectedLine1))
	assert.True(t, strings.Contains(secret.StringData[config], expectedLine2))
	assert.True(t, strings.Contains(secret.StringData[config], expectedSection))
}

func renderSecret(t *testing.T, options *helm.Options, wantErr bool, paths []string) *corev1.Secret {
	output, err := helm.RenderTemplateE(t, options, helmChartPath, releaseName, paths)
	if wantErr {
		require.Error(t, err)
		return nil
	}
	require.NoError(t, err)
	subject := corev1.Secret{}
	helm.UnmarshalK8SYaml(t, output, &subject)
	return &subject
}
