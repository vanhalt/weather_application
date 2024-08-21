# Weather Application

Game plan:

-   identify API capabilities: basic info, rates and bonus info
-   UI: create basic UI with input field and display area
-   initial basic implementation: consider rate limiting and cache for 30 mins
-   extras: ...

## Initial implementation

-   create a basic class that fetches information from a weather API
-   need to figure out a way to get the zip code of the lat and lon provided
-   implement the caching for 30 minutes
-   would be cool to be aware of the rate limiting

# Gems used

-   `httparty`: Needed a HTTP client and liked the fact that I can include the client on a class. Seems good for my plan of using the `Strategy` pattern to include more weather services. Will see...

# services

Added a `docker-compose.yml` file for services.

-   redis
-   postgresql

## APIs used

### Open Meteo

No API key needed. Has rate limiting on its endpoints.

```bash
curl 'https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m&timezone=auto'
```

## TODOS:

-   Use the addresses API health endpoint to see if the service is available
-   Definitely implement the `Strategy` pattern to support multiple weather services
