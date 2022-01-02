sBucket = "netdata/autogen"
tBucket = "stiebeleltron_archive"
sMeasurement = "netdata.heating.stiebeleltron_system.roomtemp.hc2.actual"
tMeasurement = "stiebeleltron_room_temperature_heating_circuit"
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
  |> set(key: "circuit", value: "hc2")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: tBucket)
