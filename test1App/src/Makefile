TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += test1Support

# Compile and add code to the support library
test1Support_SRCS += xxxRecord.c
test1Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
test1Support_SRCS += dbSubExample.c
test1Support_SRCS += devtest1Version.c
test1Support_SRCS += test1Hello.c
test1Support_SRCS += initTrace.c

test1Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = test1Version.h
# Macro name
GENVERSIONMACRO = test1VERSION

# Build the IOC application
PROD_IOC = test1

# test1.dbd will be created and installed
DBD += test1.dbd

# test1.dbd will include these files:
test1_DBD += base.dbd
test1_DBD += xxxSupport.dbd
test1_DBD += dbSubExample.dbd
test1_DBD += devtest1Version.dbd
test1_DBD += test1Hello.dbd
test1_DBD += initTrace.dbd

# test1_registerRecordDeviceDriver.cpp derives from test1.dbd
test1_SRCS += test1_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
test1_SRCS_DEFAULT += test1Main.cpp
test1_SRCS_vxWorks += -nil-

# Link in the code from our support library
test1_LIBS += test1Support

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into test1Support
    sncExample_SNCFLAGS += +r
    test1_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    test1Support_SRCS += sncExample.stt
    test1Support_LIBS += seq pv
    test1_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    test1_LIBS += qsrv
    test1_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    test1_DBD += PVAServerRegister.dbd
    test1_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
test1_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devtest1Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
