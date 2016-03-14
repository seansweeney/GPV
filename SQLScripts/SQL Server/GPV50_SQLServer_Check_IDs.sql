/*
  Copyright 2016 Applied Geographics, Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

  GPV50_SQLServer_Check_IDs.sql

  Checks for case-sensitive mismatches between primary and foreign keys.
  If any mismatches are found, they must be corrected before running
  GPV50_SQLServer_AddConstraints.sql.

*/

declare @prefix nvarchar(50)
set @prefix = 'GPV50'

declare @sql nvarchar(4000)
declare @count int

set @sql = '
  select ''' + @prefix + 'ApplicationMapTab'' as [From Table], ''ApplicationID'' as [Column], ''' + @prefix + 'Application'' as [To Table], count(*) as Mismatches 
    from ' + @prefix + 'ApplicationMapTab
    where ApplicationID not in (select ApplicationID from ' + @prefix + 'Application)
  union
    select ''' + @prefix + 'ApplicationMapTab'' as [From Table], ''MapTabID'' as [Column], ''' + @prefix + 'MapTab'' as [To Table], count(*) as Mismatches 
    from ' + @prefix + 'ApplicationMapTab
    where MapTabID not in (select MapTabID from ' + @prefix + 'Application)
'
exec (@sql)
