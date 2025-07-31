[![Continuous integration](https://github.com/solectrus/tibber-collector/actions/workflows/push.yml/badge.svg)](https://github.com/solectrus/tibber-collector/actions/workflows/push.yml)
[![wakatime](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/018c1bd2-0182-4fb4-a801-4bdd567f1a76.svg)](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/018c1bd2-0182-4fb4-a801-4bdd567f1a76)
[![Maintainability](https://qlty.sh/badges/3c99f5be-a278-4961-8550-08fd3c8ad4ef/maintainability.svg)](https://qlty.sh/gh/solectrus/projects/tibber-collector)
[![Code Coverage](https://qlty.sh/badges/3c99f5be-a278-4961-8550-08fd3c8ad4ef/coverage.svg)](https://qlty.sh/gh/solectrus/projects/tibber-collector)

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

Copyright (c) 2023-2025 Georg Ledermann, released under the MIT License

Sponsored by [EP: Bölsche Frikom GmbH](https://www.ep.de/boelsche)
