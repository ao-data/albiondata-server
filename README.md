# Albion Online Data Server

The aim of this project is to condense the amount of running services on the docker stack and to provide a place to add/migrate functionality needed to run the entire stack.

## How to run it?

Copy `.env.sample` to `.env`, modify the contents of `.env` to match your environment and then `docker compose up`.

## Services

### MarketHistoryService

This service accepts `month` and `year` parameters. It will export the market history data for the given month/year and then remove the data from the database. As of today, 2023-03-12, this job is kicked off manually. Eventually, it will be configured to run once a month to backup and delete `now()-7.months`, leaving 6 months + current month of data in market history database table.