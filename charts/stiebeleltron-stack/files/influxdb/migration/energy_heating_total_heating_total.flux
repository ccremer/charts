sBucket = "netdata/autogen"
tBucket = "stiebeleltron_archive"
sMeasurement = "netdata.heating.stiebeleltron_heatpump.energy.compressortotal.heating"
tMeasurement = "stiebeleltron_energy_heating_total"
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
  |> multiplyByX(x: 3600000000.0)
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> set(key: "site", value: site)
  |> set(key: "timeframe", value: "total")
  |> set(key: "compressor", value: "heating")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: tBucket)
