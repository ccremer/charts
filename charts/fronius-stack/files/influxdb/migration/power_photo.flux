import "influxdata/influxdb/v1"

bucket = "netdata/autogen"

from(bucket: bucket)
  |> range(start: -5y, stop: -10d)
  |> filter(fn:(r) =>
    r._measurement == "netdata.solar.fronius_solar.power.photovoltaics"
  )
  |> map(fn: (r) => ({r with _measurement: "fronius_site_power_photovoltaic"}))
  |> aggregateWindow(every: 10m, fn: mean, createEmpty: false)
  |> set(key: "site", value: "sirius")
  |> set(key: "_field", value: "gauge")
  |> to(bucket: "fronius_archive")
