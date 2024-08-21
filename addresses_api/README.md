# Address API

This is a service that's going to:

-   retrieve the zipcode of an address

# Models

## Address

-   This model will store addresses information in order to be able to reply with `zipcodes` to be cached
-   Even when the cache on the main service expires and the same address is queried. It should return the same `zipcode`

# Services (pattern)

I am using `Service Objects` here:

-   `ValidatorService`: is in charge of checking whether there is a similar address on the database. If not, validate entered addresss and store it on the database for future searches.

# Database

I am relying on PostgreSQL database extension [pg_trgm](https://www.postgresql.org/docs/current/pgtrgm.html#PGTRGM-INDEX) in order to search for similar addresses and get their postal code.
