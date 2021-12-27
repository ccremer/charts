sBucket = "netdata/autogen"
tBucket = "stiebeleltron_archive"
sMeasurement = "netdata.heating.stiebeleltron_system.heating.hc1.actual"
tMeasurement = "stiebeleltron_heating_temperature"
site = "sirius"

from(bucket: sBucket)
  |> range(start: -5y, stop: 0s)
  |> filter(fn:(r) =>
    r._measurement == sMeasurement
  )
  |> map(fn: (r) => ({r with _measurement: tMeasurement}))
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> set(key: "site", value: site)
  |> set(key: "state", value: "actual")
  |> set(key: "circuit", value: "hc1")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: tBucket)
