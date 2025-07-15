{# ------------------------------------------------------------------------------
@Author:        F. Paul Spitzner
@Created:       2025-07-14 11:22:02
@Last Modified: 2025-07-15 09:29:36

This is a dummy source, which has to be build before running unit tests.
Unfortunately, dbt's test need an input, even if it is completely mocked in the yml.
dbt build --select _dummy_source

------------------------------------------------------------------------------ #}



select 1 as id
