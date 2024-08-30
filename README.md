[![Continuous integration](https://github.com/solectrus/tibber-collector/actions/workflows/push.yml/badge.svg)](https://github.com/solectrus/tibber-collector/actions/workflows/push.yml)
[![wakatime](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/018c1bd2-0182-4fb4-a801-4bdd567f1a76.svg)](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/018c1bd2-0182-4fb4-a801-4bdd567f1a76)
[![Maintainability](https://api.codeclimate.com/v1/badges/1b392dc7af3b0b5cb57d/maintainability)](https://codeclimate.com/repos/6572cf994f3c7e5e3e355636/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1b392dc7af3b0b5cb57d/test_coverage)](https://codeclimate.com/repos/6572cf994f3c7e5e3e355636/test_coverage)

# Tibber collector

Collect upcoming Tibber energy prices and push them to InfluxDB.

This is a companion service to the [SENEC Charger](https://github.com/solectrus/senec-charger), which allows you to charge your SENEC.Home battery when energy is cheap.

## Usage

1. Prepare an `.env` file (see `.env.example`)

2. Run the Docker containers on your Linux box:

   ```bash
   docker compose up
   ```

In the `senec-charger` repository you can find an [example](https://github.com/solectrus/senec-charger/blob/develop/compose.yml) of how to use `tibber-collector` with the SENEC charger.

It's recommended to add `tibber-collector` and `senec-charger` to your [SOLECTRUS hosting](https://github.com/solectrus/hosting).


## License

Copyright (c) 2023-2024 Georg Ledermann, released under the MIT License

Sponsored by [EP: Bölsche Frikom GmbH](https://www.ep.de/boelsche)
