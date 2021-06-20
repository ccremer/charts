import "influxdata/influxdb/v1"

bucket = "netdata/autogen"

multiplyByX = (x, tables=<-) =>
  tables
    |> map(fn: (r) => ({
        r with
        _value: r._value * x
      })
    )

from(bucket: bucket)
  |> range(start: -5y, stop: -10d)
  |> filter(fn:(r) =>
    r._measurement == "netdata.solar.fronius_solar.consumption.load"
  )
  |> multiplyByX(x: -1.0)
  |> map(fn: (r) => ({r with _measurement: "fronius_site_power_load"}))
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> set(key: "site", value: "sirius")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: "fronius_archive")
