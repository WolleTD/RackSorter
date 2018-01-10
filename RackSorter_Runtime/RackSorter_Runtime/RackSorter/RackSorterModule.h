///////////////////////////////////////////////////////////////////////////////
// RackSorterModule.h
#pragma once

#include "RackSorterInterfaces.h"
#include "AdsR0.h"

// delcare physical rack size
#define RACKSIZE_X 10
#define RACKSIZE_Y 4
#define HOME_X 5
#define HOME_Y 0
#define PWM_INTERVAL 2
#define IS_READY() (m_xPos == m_xTarget && m_yPos == m_yTarget && m_loaderTask == Nothing)

// motor state enum type
enum MotorState {
	Forward,
	Backward,
	Up,
	Down,
	Left,
	Right,
	Off
};

enum LoaderPosition {
	Belt,
	Neutral,
	Rack
};

enum LoaderTask {
	Load,
	Unload,
	Nothing
};

enum AdsResponse : UINT8 {
	OK = 0x00,
	BUSY = 0x01,
	ERROR_CLIENT = 0x02,
	ERROR_SERVER = 0x04
};

// parameter ids for TwinCAT module RackSorterModule with disabled code generation
// could be moved to RackSorterServices.h
const PTCID PID_RackSorterModuleAdsPort        = 0x00000002;

class CRackSorterModule 
	: public ITComObject
	, public ITcADI
	, public ITcWatchSource
///<AutoGeneratedContent id="InheritanceList">
	, public ITcCyclic
///</AutoGeneratedContent>
	, public CAdsR0FifoPort
{
public:
	DECLARE_IUNKNOWN()
	DECLARE_IPERSIST(CID_RackSorterCRackSorterModule)
	DECLARE_ITCOMOBJECT_LOCKOP()
	DECLARE_ITCADI()
	DECLARE_ITCWATCHSOURCE()
	DECLARE_OBJPARAWATCH_MAP()
	DECLARE_OBJDATAAREA_MAP()

	CRackSorterModule();
	virtual	~CRackSorterModule();


///<AutoGeneratedContent id="InterfaceMembers">
	// ITcCyclic
	virtual HRESULT TCOMAPI CycleUpdate(ITcTask* ipTask, ITcUnknown* ipCaller, ULONG_PTR context);

///</AutoGeneratedContent>

	// CAds
	virtual	void	AdsReadWriteInd
	(
		AmsAddr& rAddr, 
		ULONG invokeId, 
		ULONG indexGroup,
		ULONG indexOffset, 
		ULONG cbReadLength, 
		ULONG cbWriteLength, 
		PVOID pData 
	);

	virtual void AdsReadCon
	(
		AmsAddr& rAddr, 
		ULONG invokeId, 
		ULONG result, 
		ULONG cbLength, 
		PVOID pData
	);

protected:
	DECLARE_ITCOMOBJECT_SETSTATE();

	HRESULT AddModuleToCaller();
	VOID RemoveModuleFromCaller();

	// Read input states and update system position
	void UpdateSystemPosition();
	// Sets physical outputs according to MotorStates
	void SetOutputs();
	// Initialization routine to reach a defined state
	void InitializeRackSorter();

	// Tracing
	CTcTrace m_Trace;

///<AutoGeneratedContent id="Members">
	TcTraceLevel m_TraceLevelMax;
	WORD m_DefaultAdsPort;
	WORD m_ContextAdsPort;
	ULONG m_Counter;
	RackSorterModuleInputs m_Inputs;
	RackSorterModuleOutputs m_Outputs;
	ITcCyclicCallerInfoPtr m_spCyclicCaller;
///</AutoGeneratedContent>

	void SubmitAdsReadReq();
	enum 
	{
		invokeIdReadByOidAndPid = 1
	};
	ULONG  m_ReadByOidAndPid;

	// PWM thingy
	UINT8 m_pwm = 0;
	
	// System state variables
	// Initialization routine finished?
	bool m_Initialized = false;
	// Is the system active?
	bool m_Active = false;
	// Is the carriage loaded with something?
	bool m_Loaded = false;
	// Current (last known) position of the carriage
	UINT8 m_xPos = 0;
	UINT8 m_yPos = 0;
	// Extra-Flag do differ between upper and lower Y-Position (meh.)
	bool m_yUpper = false;
	// Loader carriage position
	LoaderPosition m_loaderPos = Neutral;

	// System movement state variables
	// Target position the system currently tries to reach
	UINT8 m_xTarget = 0;
	UINT8 m_yTarget = 0;
	bool m_yTargetUpper = false;

	LoaderTask m_loaderTask = Nothing;

	// Input/Output
	// Arrays of pointers to switch inputs
	// We don't want to always copy the input data
	bool* m_xSwitches[RACKSIZE_X];
	bool* m_ySwitchesU[RACKSIZE_Y];
	bool* m_ySwitchesL[RACKSIZE_Y];
	// Motor states
	MotorState m_xMotor = Off;
	MotorState m_yMotor = Off;
	MotorState m_zMotor = Off;
};
