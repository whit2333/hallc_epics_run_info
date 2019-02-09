#!../../bin/linux-x86_64/test1

#- You may have to change test1 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/test1.dbd"
test1_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "db/user.substitutions"

#dbLoadRecords "db/test1Version.db", "user=whit"

#dbLoadRecords "db/simulate.db"

dbLoadRecords "db/hallc.db"
dbLoadRecords "db/daq_run.db", "runtype=COIN"
dbLoadRecords "db/daq_run.db", "runtype=SHMS"
dbLoadRecords "db/daq_run.db", "runtype=HMS"
dbLoadRecords "db/run_settings.db"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=whit"
