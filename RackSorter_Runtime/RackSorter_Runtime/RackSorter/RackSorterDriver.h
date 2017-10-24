///////////////////////////////////////////////////////////////////////////////
// RackSorterDriver.h

#ifndef __RACKSORTERDRIVER_H__
#define __RACKSORTERDRIVER_H__

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "TcBase.h"

#define RACKSORTERDRV_NAME        "RACKSORTER"
#define RACKSORTERDRV_Major       1
#define RACKSORTERDRV_Minor       0

#define DEVICE_CLASS CRackSorterDriver

#include "ObjDriver.h"

class CRackSorterDriver : public CObjDriver
{
public:
	virtual IOSTATUS	OnLoad();
	virtual VOID		OnUnLoad();

	//////////////////////////////////////////////////////
	// VxD-Services exported by this driver
	static unsigned long	_cdecl RACKSORTERDRV_GetVersion();
	//////////////////////////////////////////////////////
	
};

Begin_VxD_Service_Table(RACKSORTERDRV)
	VxD_Service( RACKSORTERDRV_GetVersion )
End_VxD_Service_Table


#endif // ifndef __RACKSORTERDRIVER_H__