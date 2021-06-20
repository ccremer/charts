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
    r._measurement == "netdata.solar.fronius_solar.autonomy.self_consumption"
  )
  |> map(fn: (r) => ({r with _measurement: "fronius_site_selfconsumption_ratio"}))
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> multiplyByX(x: 0.01)
  |> set(key: "site", value: "sirius")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: "fronius_archive")
