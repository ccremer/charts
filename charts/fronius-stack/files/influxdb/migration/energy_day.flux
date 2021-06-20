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
  |> range(start: -5y, stop: -12d)
  |> filter(fn:(r) =>
    r._measurement == "netdata.solar.fronius_solar.energy.today.today"
  )
  |> map(fn: (r) => ({r with _measurement: "fronius_site_energy_consumption"}))
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> multiplyByX(x: 1000.0)
  |> set(key: "site", value: "sirius")
  |> set(key: "time_frame", value: "day")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: "fronius_archive")
