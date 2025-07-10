use test.public;

list @stage1;

-- ===========================================================
-- from IMPORT clause
CREATE OR REPLACE FUNCTION show_employee_names()
    RETURNS STRING
    LANGUAGE PYTHON
    RUNTIME_VERSION = 3.9
    IMPORTS = ('@stage1/employee-names.csv')
    HANDLER = 'process'
AS $$
import sys, os

with open(os.path.join(
    sys._xoptions["snowflake_import_directory"],
    'employee-names.csv'), "r") as f:
    s = f.read()

def process():
    return s
$$;

select show_employee_names();

-- ===========================================================
-- w/ SnowflakeFile (for unstructured data)
CREATE OR REPLACE FUNCTION get_employee_names(stagefile string, scoped boolean)
    RETURNS TABLE (id int, name string)
    LANGUAGE PYTHON
    RUNTIME_VERSION = '3.9'
    PACKAGES = ('snowflake-snowpark-python')
    HANDLER = 'MyClass'
AS $$
from snowflake.snowpark.files import SnowflakeFile

class MyClass:
    def process(self, stagefile, scoped):
        with SnowflakeFile.open(stagefile, require_scoped_url=scoped) as f:
            for line in f.readlines():
                lineStr = line.strip()
                row = lineStr.split(",")
                yield (int(row[0]), str(row[1]))
$$;

-- w/ scoped URL
SELECT * FROM TABLE(get_employee_names(
    build_scoped_file_url(@stage1, 'employee-names.csv'), True));

-- w/ unscoped URL
SELECT * FROM TABLE(get_employee_names(
    '@stage1/employee-names.csv', False));
