///////////////////////////////////////////////////////////////////////////////
// RackSorterDriver.cpp
#include "TcPch.h"
#pragma hdrstop

#include "RackSorterDriver.h"
#include "RackSorterClassFactory.h"

DECLARE_GENERIC_DEVICE(RACKSORTERDRV)

IOSTATUS CRackSorterDriver::OnLoad( )
{
	TRACE(_T("CObjClassFactory::OnLoad()\n") );
	m_pObjClassFactory = new CRackSorterClassFactory();

	return IOSTATUS_SUCCESS;
}

VOID CRackSorterDriver::OnUnLoad( )
{
	delete m_pObjClassFactory;
}

unsigned long _cdecl CRackSorterDriver::RACKSORTERDRV_GetVersion( )
{
	return( (RACKSORTERDRV_Major << 8) | RACKSORTERDRV_Minor );
}

