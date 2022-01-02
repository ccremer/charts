sBucket = "netdata/autogen"
tBucket = "stiebeleltron_archive"
sMeasurement = "netdata.heating.stiebeleltron_system.general.output.water_pump"
tMeasurement = "stiebeleltron_general_output_activity_ratio"
site = "sirius"

multiplyByX = (x, tables=<-) =>
  tables
    |> map(fn: (r) => ({
        r with
        _value: r._value * x
      })
    )

from(bucket: sBucket)
  |> range(start: -5y, stop: 0s)
  |> filter(fn:(r) =>
    r._measurement == sMeasurement
  )
  |> map(fn: (r) => ({r with _measurement: tMeasurement}))
  |> multiplyByX(x: 0.01)
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> set(key: "site", value: site)
  |> set(key: "pump", value: "water")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: tBucket)
