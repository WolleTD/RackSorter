#pragma once

#include "TcDef.h"

enum RackSorterModuleIndexGroups : ULONG
{
	Group1AdminStatus = 0x00000001,
	Group2RackControl = 0x00000002,
	Group3AuxControl = 0x00000003
};

enum RackSorterModuleIndexOffsets : ULONG
{
	Offset1 = 0x00000001,
	Offset2 = 0x00000002,
	Offset3 = 0x00000003,
	Offset4 = 0x00000004
};
