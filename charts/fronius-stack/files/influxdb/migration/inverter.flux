import "influxdata/influxdb/v1"

bucket = "netdata/autogen"

from(bucket: bucket)
  |> range(start: -4y, stop: -10d)
  |> filter(fn:(r) =>
    r._measurement == "netdata.solar.fronius_solar.inverters.output.inverter_1"
  )
  |> map(fn: (r) => ({r with _measurement: "fronius_inverter_power"}))
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> set(key: "site", value: "sirius")
  |> set(key: "_field", value: "gauge")
  |> set(key: "inverter", value: "1")
  |> to(bucket: "fronius_archive")
