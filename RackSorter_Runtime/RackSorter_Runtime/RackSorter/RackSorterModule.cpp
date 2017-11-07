///////////////////////////////////////////////////////////////////////////////
// RackSorterModule.cpp
#include "TcPch.h"
#pragma hdrstop

#include "RackSorterModule.h"
#include "RackSorterModuleAds.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif
DEFINE_THIS_FILE()

///////////////////////////////////////////////////////////////////////////////
// CRackSorterModule
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Collection of interfaces implemented by module CRackSorterModule
BEGIN_INTERFACE_MAP(CRackSorterModule)
	INTERFACE_ENTRY_ITCOMOBJECT()
	INTERFACE_ENTRY(IID_ITcADI, ITcADI)
	INTERFACE_ENTRY(IID_ITcWatchSource, ITcWatchSource)
///<AutoGeneratedContent id="InterfaceMap">
	INTERFACE_ENTRY(IID_ITcCyclic, ITcCyclic)
///</AutoGeneratedContent>
END_INTERFACE_MAP()

IMPLEMENT_ITCOMOBJECT(CRackSorterModule)
IMPLEMENT_ITCOMOBJECT_SETSTATE_LOCKOP2(CRackSorterModule)
IMPLEMENT_ITCADI(CRackSorterModule)
IMPLEMENT_ITCWATCHSOURCE(CRackSorterModule)

///////////////////////////////////////////////////////////////////////////////
// Set parameters of CRackSorterModule 
BEGIN_SETOBJPARA_MAP(CRackSorterModule)
	SETOBJPARA_DATAAREA_MAP()
///<AutoGeneratedContent id="SetObjectParameterMap">
	SETOBJPARA_VALUE(PID_TcTraceLevel, m_TraceLevelMax)
	SETOBJPARA_VALUE(PID_RackSorterModuleDefaultAdsPort, m_DefaultAdsPort)
	SETOBJPARA_VALUE(PID_Ctx_AdsPort, m_ContextAdsPort)
	SETOBJPARA_VALUE(PID_RackSorterModuleCounter, m_Counter)
	SETOBJPARA_ITFPTR(PID_Ctx_TaskOid, m_spCyclicCaller)
///</AutoGeneratedContent>
END_SETOBJPARA_MAP()

///////////////////////////////////////////////////////////////////////////////
// Get parameters of CRackSorterModule 
BEGIN_GETOBJPARA_MAP(CRackSorterModule)
	GETOBJPARA_DATAAREA_MAP()
///<AutoGeneratedContent id="GetObjectParameterMap">
	GETOBJPARA_VALUE(PID_TcTraceLevel, m_TraceLevelMax)
	GETOBJPARA_VALUE(PID_RackSorterModuleDefaultAdsPort, m_DefaultAdsPort)
	GETOBJPARA_VALUE(PID_Ctx_AdsPort, m_ContextAdsPort)
	GETOBJPARA_VALUE(PID_RackSorterModuleCounter, m_Counter)
	GETOBJPARA_ITFPTR(PID_Ctx_TaskOid, m_spCyclicCaller)
///</AutoGeneratedContent>
	GETOBJPARA_TYPE_CODE(PID_RackSorterModuleAdsPort, WORD, *p = AmsGetPort())
END_GETOBJPARA_MAP()

///////////////////////////////////////////////////////////////////////////////
// Get watch entries of CRackSorterModule
BEGIN_OBJPARAWATCH_MAP(CRackSorterModule)
	OBJPARAWATCH_DATAAREA_MAP()
///<AutoGeneratedContent id="ObjectParameterWatchMap">
	OBJPARAWATCH_VALUE(PID_RackSorterModuleCounter, m_Counter)
///</AutoGeneratedContent>
END_OBJPARAWATCH_MAP()

///////////////////////////////////////////////////////////////////////////////
// Get data area members of CRackSorterModule
BEGIN_OBJDATAAREA_MAP(CRackSorterModule)
///<AutoGeneratedContent id="ObjectDataAreaMap">
	OBJDATAAREA_VALUE(ADI_RackSorterModuleInputs, m_Inputs)
	OBJDATAAREA_VALUE(ADI_RackSorterModuleOutputs, m_Outputs)
///</AutoGeneratedContent>
END_OBJDATAAREA_MAP()


///////////////////////////////////////////////////////////////////////////////
CRackSorterModule::CRackSorterModule()
	: m_Trace(m_TraceLevelMax, m_spSrv)
{
///<AutoGeneratedContent id="MemberInitialization">
	m_TraceLevelMax = tlAlways;
	m_DefaultAdsPort = 0;
	m_ContextAdsPort = 0;
	m_Counter = 0;
	memset(&m_Inputs, 0, sizeof(m_Inputs));
	memset(&m_Outputs, 0, sizeof(m_Outputs));
///</AutoGeneratedContent>
	// point position arrays to inputs
	m_xSwitches[0] = &(m_Inputs.x_switch_00);
	m_xSwitches[1] = &(m_Inputs.x_switch_01);
	m_xSwitches[2] = &(m_Inputs.x_switch_02);
	m_xSwitches[3] = &(m_Inputs.x_switch_03);
	m_xSwitches[4] = &(m_Inputs.x_switch_04);
	m_xSwitches[5] = &(m_Inputs.x_switch_05);
	m_xSwitches[6] = &(m_Inputs.x_switch_06);
	m_xSwitches[7] = &(m_Inputs.x_switch_07);
	m_xSwitches[8] = &(m_Inputs.x_switch_08);
	m_xSwitches[9] = &(m_Inputs.x_switch_09);
	m_ySwitchesU[0] = &(m_Inputs.y_floorSwitch_00_upstairs);
	m_ySwitchesU[1] = &(m_Inputs.y_floorSwitch_01_upstairs);
	m_ySwitchesU[2] = &(m_Inputs.y_floorSwitch_02_upstairs);
	m_ySwitchesU[3] = &(m_Inputs.y_floorSwitch_03_upstairs);
	m_ySwitchesL[0] = &(m_Inputs.y_floorSwitch_00_downstairs);
	m_ySwitchesL[1] = &(m_Inputs.y_floorSwitch_01_downstairs);
	m_ySwitchesL[2] = &(m_Inputs.y_floorSwitch_02_downstairs);
	m_ySwitchesL[3] = &(m_Inputs.y_floorSwitch_03_downstairs);
}

///////////////////////////////////////////////////////////////////////////////
CRackSorterModule::~CRackSorterModule() 
{
}

///////////////////////////////////////////////////////////////////////////////
// State Transitions 
///////////////////////////////////////////////////////////////////////////////
IMPLEMENT_ITCOMOBJECT_SETOBJSTATE_IP_PI(CRackSorterModule)

///////////////////////////////////////////////////////////////////////////////
// State transition from PREOP to SAFEOP
//
// Initialize input parameters 
// Allocate memory
HRESULT CRackSorterModule::SetObjStatePS(PTComInitDataHdr pInitData)
{
	m_Trace.Log(tlVerbose, FENTERA);
	HRESULT hr = S_OK;
	IMPLEMENT_ITCOMOBJECT_EVALUATE_INITDATA(pInitData);

	hr = SUCCEEDED(hr) ? InitAmsPort(m_spSrv, m_DefaultAdsPort) : hr;

	// cleanup on failure
	if (FAILED(hr))
	{
		ShutdownAmsPort();
	}
	m_Trace.Log(tlVerbose, FLEAVEA "hr=0x%08x", hr);
	return hr;
}

///////////////////////////////////////////////////////////////////////////////
// State transition from SAFEOP to OP
//
// Register with other TwinCAT objects
HRESULT CRackSorterModule::SetObjStateSO()
{
	m_Trace.Log(tlVerbose, FENTERA);
	HRESULT hr = S_OK;

	// TODO: Add any additional initialization


	// If following call is successful the CycleUpdate method will be called, 
	// possibly even before this method has been left.
	hr = FAILED(hr) ? hr : AddModuleToCaller(); 

	// Cleanup if transition failed at some stage
	if ( FAILED(hr) )
	{
		RemoveModuleFromCaller(); 
	}
	m_Trace.Log(tlVerbose, FLEAVEA "hr=0x%08x", hr);
	return hr;
}

///////////////////////////////////////////////////////////////////////////////
// State transition from OP to SAFEOP
HRESULT CRackSorterModule::SetObjStateOS()
{
	m_Trace.Log(tlVerbose, FENTERA);

	HRESULT hr = S_OK;

	RemoveModuleFromCaller(); 

	m_Trace.Log(tlVerbose, FLEAVEA "hr=0x%08x", hr);
	return hr;
}

///////////////////////////////////////////////////////////////////////////////
// State transition from SAFEOP to PREOP
HRESULT CRackSorterModule::SetObjStateSP()
{
	m_Trace.Log(tlVerbose, FENTERA);

	HRESULT hr = S_OK;
	ShutdownAmsPort();

	m_Trace.Log(tlVerbose, FLEAVEA "hr=0x%08x", hr);
	return hr;
}

///<AutoGeneratedContent id="ImplementationOf_ITcCyclic">
HRESULT CRackSorterModule::CycleUpdate(ITcTask* ipTask, ITcUnknown* ipCaller, ULONG_PTR context)
{
	HRESULT hr = S_OK;

	// handle pending ADS indications and confirmations
	CheckOrders();

	// TODO: Additional evaluation of input from ADS indication or confirmations

	// TODO: Submit your ADS requests 
	ULONGLONG cnt = 0;
	if (SUCCEEDED(ipTask->GetCycleCounter(&cnt)))
	{
		if (cnt%100 == 0)
		{
			SubmitAdsReadReq();
		}
	}

	// While not initialized, Ads packets are ignored.
	if (!m_Initialized)
	{
		InitializeRackSorter();
	}

	SetOutputs();

	return hr;
}
///</AutoGeneratedContent>

///////////////////////////////////////////////////////////////////////////////
HRESULT CRackSorterModule::AddModuleToCaller()
{
	m_Trace.Log(tlVerbose, FENTERA);

	HRESULT hr = S_OK;
	if ( m_spCyclicCaller.HasOID() )
	{
		if ( SUCCEEDED_DBG(hr = m_spSrv->TcQuerySmartObjectInterface(m_spCyclicCaller)) )
		{
			if ( FAILED(hr = m_spCyclicCaller->AddModule(m_spCyclicCaller, THIS_CAST(ITcCyclic))) )
			{
				m_spCyclicCaller = NULL;
			}
		}
	}
	else
	{
		hr = ADS_E_INVALIDOBJID; 
		SUCCEEDED_DBGT(hr, "Invalid OID specified for caller task");
	}
	m_Trace.Log(tlVerbose, FLEAVEA "hr=0x%08x", hr);
	return hr;
}

///////////////////////////////////////////////////////////////////////////////
VOID CRackSorterModule::RemoveModuleFromCaller()
{
	m_Trace.Log(tlVerbose, FENTERA);

	if ( m_spCyclicCaller )
	{
		m_spCyclicCaller->RemoveModule(m_spCyclicCaller);
	}
	m_spCyclicCaller	= NULL;
	m_Trace.Log(tlVerbose, FLEAVEA);
}

void CRackSorterModule::SetOutputs()
{
	// Simple PWM fits for this case
	m_pwm = (m_pwm + 1) % PWM_INTERVAL;
	bool isPWM = (m_pwm == 0);
	
	switch (xMotor)
	{
	case Left:
		m_Outputs.x_motor_right = false;
		m_Outputs.x_motor_left = isPWM;
		break;
	case Right:
		m_Outputs.x_motor_left = false;
		m_Outputs.x_motor_right = isPWM;
		break;
	case Off:
	default:
		m_Outputs.x_motor_left = false;
		m_Outputs.x_motor_right = false;
		break;
	}

	switch (yMotor)
	{
	case Up:
		m_Outputs.y_motor_down = false;
		m_Outputs.y_motor_up = isPWM;
		break;
	case Down:
		m_Outputs.y_motor_up = false;
		m_Outputs.y_motor_down = isPWM;
		break;
	case Off:
	default:
		m_Outputs.y_motor_down = false;
		m_Outputs.y_motor_up = false;
		break;
	}

	// Z-Motor is the Crane pickup thingy ("crossbeam"?)
	// Forward is a movement towards the rack, Backward is obviously the other way
	switch (zMotor)
	{
	case Forward:
		m_Outputs.z_motor_back = false;
		m_Outputs.z_motor_forward = true;
		break;
	case Backward:
		m_Outputs.z_motor_forward = false;
		m_Outputs.z_motor_back = true;
		break;
	case Off:
	default:
		m_Outputs.z_motor_back = false;
		m_Outputs.z_motor_forward = false;
		break;
	}
}

void CRackSorterModule::InitializeRackSorter()
{
	bool zInitialized = false;
	bool yInitialized = false;
	bool xInitialized = false;
	// First thing to initialize is the crane loader thingy
	// Target position is neutral as loaderPos is initialized with
	if (m_Inputs.stackerCrane_position_neutral)
	{
		// Do nothing or stop whatever you were doing
		m_zMotor = Off;
		zInitialized = true;
	}
	else if (m_Inputs.stackerCrane_position_conveyor)
	{
		// Move towards rack
		m_zMotor = Forward;
	}
	else if (m_Inputs.stackerCrane_position_stack)
	{
		// Move away from rack
		m_zMotor = Backward;
	}
	else if (m_zMotor == Off)
	{
		// If we got here, just go somewhere (forward)
		m_zMotor = Forward;
	}
	else {
		// THIS SHOULD NEVER HAPPEN
		m_zMotor = Off;
	}
	// End of Z-Motor init. return if it's not initialized
	if (!zInitialized) return;

	// Next, initialize Y. Check if any Y-Switch is on
	// Only check lower switches because thats the reference for initial position
	INT8 yLower = -1;
	for (int i = 0; i < RACKSIZE_Y; i++)
	{
		if (*m_ySwitchesL[i])
		{
			yLower = i;
			break;
		}
	}
	// Check the cases
	if (yLower == HOME_Y) {
		// Correct case first
		m_yMotor = Off;
		yInitialized = true;
	}
	else if ((yLower == -1 && m_yMotor == Off) || (yLower > HOME_Y))
	{
		// No position found, move down until we find one
		// yLower[0] is endstop, so we are safe in this regard
		m_yMotor = Down;
	}
	else if (yLower > -1 && yLower < HOME_Y)
	{
		m_yMotor = Up;
	}
	if (!yInitialized) return;

	// Finally, initialize X. This is basically the same as Y
	INT8 xPos = -1;
	for (int i = 0; i < RACKSIZE_X; i++)
	{
		if (*m_xSwitches[i])
		{
			xPos = i;
			break;
		}
	}
	// Check the cases
	if (xPos == HOME_X) {
		// Correct case first
		m_xMotor = Off;
		xInitialized = true;
	}
	else if ((xPos == -1 && m_xMotor == Off) || (xPos > HOME_X))
	{
		// No position found, move down until we find one
		// yLower[0] is endstop, so we are safe in this regard
		m_xMotor = Left;
	}
	else if (xPos > -1 && xPos < HOME_X)
	{
		m_xMotor = Right;
	}
	if (!xInitialized) return;
	// Initialized
	m_xPos = HOME_X;
	m_yPos = HOME_Y;
	
	m_Initialized = zInitialized && yInitialized && xInitialized;
}

///////////////////////////////////////////////////////////////////////////////
void CRackSorterModule::AdsReadWriteInd
(
	AmsAddr& rAddr, 
	ULONG invokeId, 
	ULONG indexGroup,
	ULONG indexOffset, 
	ULONG cbReadLength, 
	ULONG cbWriteLength, 
	PVOID pData 
)
{
	m_Trace.Log(tlVerbose, FENTERA "oid=0x%08x, invokeId=%d, indexGroup=0x%08x, indexOffset=0x%08x, cbReadLength=%d, cbWriteLength=%d, pData=0x%p",
		m_objId.value, invokeId, indexGroup, indexOffset, cbReadLength, cbWriteLength, pData);

	switch(indexGroup)
	{
	case Group1AdminStatus:
		switch(indexOffset)
		{
		// Operation ON/OFF
		case Offset1:

			// TODO: add custom code here

			AdsReadWriteRes(rAddr, invokeId, ADSERR_NOERR, 0, NULL); 
			break;
		// Return current system position
		case Offset2:

			// TODO: add custom code here
			pData = &m_Counter;

			AdsReadWriteRes(rAddr, invokeId, ADSERR_NOERR, 4, pData);
			// AdsReadWriteRes(rAddr, invokeId, ADSERR_NOERR, 0, NULL);
			break;
		// Return current loaded-status
		case Offset3:
			break;
		// Reset the runtime
		case Offset4:
			break;
		}
		break;
	case Group2RackControl:
		switch(indexOffset)
		{

		case Offset1:
			m_Trace.Log(tlInfo, FNAMEA "oid=0x%08x indexGroup=0x%08x, indexOffset=0x%08x", 
				m_objId.value, indexGroup, indexOffset );

			// TODO: add custom code here
			pData = &m_Counter;

			AdsReadWriteRes(rAddr, invokeId, ADSERR_NOERR, 4, pData);
			break;

		case Offset2:
			m_Trace.Log(tlInfo, FNAMEA "oid=0x%08x indexGroup=0x%08x, indexOffset=0x%08x", 
				m_objId.value, indexGroup, indexOffset );

			// TODO: add custom code here
			m_Counter = 0;
			pData = &m_Counter;

			AdsReadWriteRes(rAddr, invokeId, ADSERR_NOERR, 4, pData);
			break;
		}
		break;
	case Group3AuxControl:
		switch (indexOffset)
		{
		case Offset1:
			ULONG *pCounter = (ULONG*)pData;
			m_Counter = *pCounter;

			AdsReadWriteRes(rAddr, invokeId, ADSERR_NOERR, 4, pData);
			break;
		}
		break;
	default:
		__super::AdsReadWriteInd(rAddr, invokeId, indexGroup, indexOffset, cbReadLength, cbWriteLength, pData); 
		break;
	}
	m_Trace.Log(tlVerbose, FLEAVEA);
}


void CRackSorterModule::SubmitAdsReadReq()
{
	m_Trace.Log(tlVerbose, FENTERA);
	// m_ContextAdsPort contains the ADS port number of the task associated with context 1
	// amsAddr refers to the ADS port of this task 
	AmsAddr amsAddr(this->AmsGetNetId(), m_ContextAdsPort);

	// Request the value of a parameter from a TwinCAT module instance
	// via the task ADS port.
	// The object id of the instance is passed as index group and
	// the parameter id is passed as index offset.
	// The result is delivered by a call to AdsReadCon and can 
	// be identified by the invoke id. 
	int nRes = 
		AdsReadReq
		(
			amsAddr, 
			invokeIdReadByOidAndPid, 
			m_objId.value, 
			PID_RackSorterModuleCounter,
			sizeof(m_ReadByOidAndPid)
		);
	if (nRes != ADSERR_NOERR)
	{
		m_Trace.Log(tlError, FNAMEA "AdsReadReq failed with error=0x%08x(%s)", nRes, AdsGetErrorText(nRes));
	}
	else
	{
		m_Trace.Log(tlInfo, FNAMEA "AdsReadReq by oid=0x%08x and pid=0x%08x", m_objId.value, PID_RackSorterModuleAdsPort);
	}
	m_Trace.Log(tlVerbose, FLEAVEA);
}

///////////////////////////////////////////////////////////////////////////////
void CRackSorterModule::AdsReadCon
(
	AmsAddr& rAddr,
	ULONG invokeId,
	ULONG nResult,
	ULONG cbLength,
	PVOID pData
)
{
	m_Trace.Log(tlVerbose, FENTERA "oid=0x%08x, invokeId=%d, nResult=0x%08x, cbLength=%d, pData=0x%p",
		m_objId.value, invokeId, nResult, cbLength, pData);

	if (invokeId == invokeIdReadByOidAndPid)
	{
		if (nResult != ADSERR_NOERR)
		{
			m_Trace.Log(tlWarning, FNAMEA "ReadByOidAndPid failed with error=0x%x(%s)",
				nResult, AdsGetErrorText(nResult));
		}
		else if (cbLength == sizeof(m_ReadByOidAndPid))
		{
			m_ReadByOidAndPid = *static_cast<PULONG>(pData); 
			m_Trace.Log(tlInfo, FNAMEA "m_ReadByOidAndPid=0x%x", m_ReadByOidAndPid);
		}
	}
	else
	{
		__super::AdsReadWriteCon( rAddr, invokeId, nResult, cbLength, pData );
	}
	m_Trace.Log(tlVerbose, FLEAVEA);
}

