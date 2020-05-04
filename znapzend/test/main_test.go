package test

import (
	"github.com/stretchr/testify/require"
	v1 "k8s.io/api/core/v1"
	"testing"
)

var (
	helmChartPath = ".."
	releaseName = "test-release"
)

func assertSshVolume(t *testing.T, volumes []v1.Volume) {
	require.Contains(t, volumes, v1.Volume{
		Name: "ssh",
		VolumeSource: v1.VolumeSource{
			Secret: &v1.SecretVolumeSource{
				SecretName:  releaseName + "-znapzend",
				DefaultMode: getIntPointer(0600),
			},
		},
	})
}

func assertSshVolumeMounts(t *testing.T, volumeMounts []v1.VolumeMount) {
	require.Contains(t, volumeMounts, v1.VolumeMount{
		Name:      "zfs",
		MountPath: "/dev/zfs",
	})
	require.Contains(t, volumeMounts, v1.VolumeMount{
		Name:      "ssh",
		MountPath: "/root/.ssh",
	})
}
