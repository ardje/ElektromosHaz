#!/usr/bin/lua-any
-- Lua-Versions: 5.4 5.3 5.2 5.1
local sgsub=string.gsub
local function gs(s,p)
		return sgsub(s,"@_(%w+)_@",p)
end
local function mpii(tag,location,title)
	local data=[[
	@_TAG_@ [ pos="@_LOCATION_@" shape=plain label=<
<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">
<TR> <TD COLSPAN="9">@_TITLE_@</TD> </TR>
<TR>
<TD COLSPAN="3">ACIN</TD>
<TD COLSPAN="3">ACO2</TD>
<TD COLSPAN="3">ACO1</TD>
</TR>
<TR>
<TD PORT="ACINP">P</TD>
<TD PORT="ACINE">E</TD>
<TD PORT="ACINN">N</TD>
<TD PORT="ACO2N">N</TD>
<TD PORT="ACO2E">E</TD>
<TD PORT="ACO2P">P</TD>
<TD PORT="ACO1N">N</TD>
<TD PORT="ACO1E">E</TD>
<TD PORT="ACO1P">P</TD>
</TR>
</TABLE>>];
]]
	return (gs(data,{TAG=tag,LOCATION=location,TITLE=title}))
end
print[[
digraph Power {
	graph [
		rankdir ="TB"
		ranksep ="2"
	];
]]
for p = 0,2 do
	for m=0,1 do
		local M={"M","S"}
		local tag=("VMPL%d%s"):format(p+1,M[m+1])
		local title=("MPII L%d %s"):format(p+1,M[m+1])
		location=("%d,%d!"):format(10,(p*2+m)*3)
		print(mpii(tag,location,title))
	end
end
print[[
	Elem1
	Elem2
	Elem3
	Elem4
	BusbarIn1L1 [ pos="0,2!" ];
	BusbarIn1L2 [ pos="1,3!" ];
	BusbarIn1L3 [ pos="2,4!" ];
	BusbarIn1N [ pos="3,5!" ];
	BusbarOut1L1
	BusbarOut1L2
	BusbarOut1L3
	BusbarOut1N
	CEE3PNI
	CEE3PNP
	LynxDist1
	LynxDist2
	LynxDist3
	EarthBar
	}
	{
		edge [ color = "brown" ]
	CEE3PNI->BusbarIn1L1
	VML1M:ACINP->BusbarIn1L1
	VML1S:ACINP->BusbarIn1L1
	VML1M:ACO1P->BusbarOut1L1
	VML1S:ACO1P->BusbarOut1L1
	BusbarOut1L1->CEE3PNP
	}
	{
		edge [ color = "black" ]
	CEE3PNI->BusbarIn1L2
	VML2M:ACINP->BusbarIn1L2
	VML2S:ACINP->BusbarIn1L2
	VML2M:ACO1P->BusbarOut1L2
	VML2S:ACO1P->BusbarOut1L2
	BusbarOut1L2->CEE3PNP
	}
	{
		edge [ color = "darkgray" ]
	CEE3PNI->BusbarIn1L3
	VML3M:ACINP->BusbarIn1L3
	VML3S:ACINP->BusbarIn1L3
	VML3M:ACO1P->BusbarOut3L2
	VML3S:ACO1P->BusbarOut3L2
	BusbarOut1L3->CEE3PNP
	}
	{
		edge [ color = "blue" ]
		CEE3PNI->BusbarIn1N
		VML1M:ACINN->BusbarIn1N
		VML1S:ACINN->BusbarIn1N
		VML2M:ACINN->BusbarIn1N
		VML2S:ACINN->BusbarIn1N
		VML3M:ACINN->BusbarIn1N
		VML3S:ACINN->BusbarIn1N
		VML1M:ACO1N->BusbarOut1N
		VML1S:ACO1N->BusbarOut1N
		VML2M:ACO1N->BusbarOut1N
		VML2S:ACO1N->BusbarOut1N
		VML3M:ACO1N->BusbarOut1N
		VML3S:ACO1N->BusbarOut1N
		BusbarOut1N->CEE3PNP
	}
	{
		edge [ stype="dashed" color = "yellow" fillcolor="green" ]
		VML1M->EarthBar
		VML1S->EarthBar
		VML2M->EarthBar
		VML2S->EarthBar
		VML3M->EarthBar
		VML3S->EarthBar
	}
}
]]
