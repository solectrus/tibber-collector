[![Continuous integration](https://github.com/solectrus/tibber-collector/actions/workflows/push.yml/badge.svg)](https://github.com/solectrus/tibber-collector/actions/workflows/push.yml)
[![wakatime](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/018c1bd2-0182-4fb4-a801-4bdd567f1a76.svg)](https://wakatime.com/badge/user/697af4f5-617a-446d-ba58-407e7f3e0243/project/018c1bd2-0182-4fb4-a801-4bdd567f1a76)
[![Maintainability](https://api.codeclimate.com/v1/badges/1b392dc7af3b0b5cb57d/maintainability)](https://codeclimate.com/repos/6572cf994f3c7e5e3e355636/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1b392dc7af3b0b5cb57d/test_coverage)](https://codeclimate.com/repos/6572cf994f3c7e5e3e355636/test_coverage)

# Tibber collector

Collect upcoming Tibber energy prices and push them to InfluxDB.

## Usage

1. Make sure your InfluxDB database is ready (not subject of this README)

2. Prepare an `.env` file (see `.env.example`) with your InfluxDB credentials and the Tibber API token.

3. Run the Docker container on your Linux box:

   ```bash
   docker run -it --rm \
              --env-file .env \
              ghcr.io/solectrus/tibber-collector
   ```

It's recommended to integrate the `tibber-collector` into your [SOLECTRUS hosting](https://github.com/solectrus/hosting).

To charge your SENEC.Home battery when energy is cheap, you can use the [SENEC Charger](https://github.com/solectrus/senec-charger).

## License

Copyright (c) 2023-2024 Georg Ledermann, released under the MIT License

Sponsored by [EP: Bölsche Frikom GmbH](https://www.ep.de/boelsche)
