///////////////////////////////////////////////////////////////////////////////
// RackSorterCtrl.h

#ifndef __RACKSORTERCTRL_H__
#define __RACKSORTERCTRL_H__

#include <atlbase.h>
#include <atlcom.h>

#define RACKSORTERDRV_NAME "RACKSORTER"

#include "resource.h"       // main symbols
#include "RackSorterW32.h"
#include "TcBase.h"
#include "RackSorterClassFactory.h"
#include "TcOCFCtrlImpl.h"

class CRackSorterCtrl 
	: public CComObjectRootEx<CComMultiThreadModel>
	, public CComCoClass<CRackSorterCtrl, &CLSID_RackSorterCtrl>
	, public IRackSorterCtrl
	, public ITcOCFCtrlImpl<CRackSorterCtrl, CRackSorterClassFactory>
{
public:
	CRackSorterCtrl();
	virtual ~CRackSorterCtrl();

DECLARE_REGISTRY_RESOURCEID(IDR_RACKSORTERCTRL)
DECLARE_NOT_AGGREGATABLE(CRackSorterCtrl)

DECLARE_PROTECT_FINAL_CONSTRUCT()

BEGIN_COM_MAP(CRackSorterCtrl)
	COM_INTERFACE_ENTRY(IRackSorterCtrl)
	COM_INTERFACE_ENTRY(ITcCtrl)
	COM_INTERFACE_ENTRY(ITcCtrl2)
END_COM_MAP()

};

#endif // #ifndef __RACKSORTERCTRL_H__
