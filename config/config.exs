import Config

config :req_noaa,
  name: "ReqNOAA",
  contact: "https://github.com/Morgahl/req_noaa",
  cache_dir: Path.join([System.tmp_dir(), "req_noaa"])
