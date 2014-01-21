# Harvest Overlord

[Harvest](http://www.harvestapp.com) time tracking does not have a view of time entries grouped by user on a single page. Using the API, this project gives you a grouped view of time on a specific day for a list of users.

- It defaults to the previous business day.
- You can change to any day.

## Requirements

1. You need a Harvest account.
2. Add your credentials to config/harvest.yml. The user_emails hash is optional, but slows performance at a rate of n + 1.
3. Rails 4, Ruby 2.0
