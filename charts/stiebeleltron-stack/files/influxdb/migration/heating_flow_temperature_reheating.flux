sBucket = "netdata/autogen"
tBucket = "stiebeleltron_archive"
sMeasurement = "netdata.heating.stiebeleltron_system.heating.flowtemp.reheating"
tMeasurement = "stiebeleltron_heating_flow_temperature"
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
  |> set(key: "type", value: "reheating")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: tBucket)
