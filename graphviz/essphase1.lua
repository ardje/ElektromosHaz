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
local function busbar(tag,location,size,title)
	local pre=[[
	@_TAG_@ [ pos="@_LOCATION_@" shape=plain label=<
<TABLE BORDER="0" CELLBORDER="1" CELLSPACING="0" CELLPADDING="4">
<TR> <TD>@_TITLE_@</TD>
]]
	local post=[[
	</TR>
	</TABLE> >];
	]]
	local s={pre}
	for i = 1,size do
		s[#s+1]=([[<TD PORT="%d">%d</TD>]]):format(i,i)
	end
	s[#s+1]=post
	return gs(table.concat(s),{TAG=tag,LOCATION=location,TITLE=title})
end
print[[
digraph Power {
	splines = true;
	graph [
		rankdir ="TB"
		ranksep ="2"
	];
	{
		node [ shape="rectangle" ];
]]
for p = 0,2 do
	for m=0,1 do
		local M={"M","S"}
		local tag=("VML%d%s"):format(p+1,M[m+1])
		local title=("MPII L%d %s"):format(p+1,M[m+1])
		location=("%d,%d!"):format((p*2+m)*3,10)
		print(mpii(tag,location,title))
	end
end
print(busbar("INL1",("0,2!"),4,"INL1"))
print(busbar("INL2",("1,3!"),4,"INL2"))
print(busbar("INL3",("2,4!"),4,"INL3"))
print(busbar("INN",("3,5!"),8,"INN"))
print(busbar("INE",("4,6!"),8,"INE"))
print(busbar("OUT1L1",("5,2!"),4,"OUT1L1"))
print(busbar("OUT1L2",("6,3!"),4,"OUT1L2"))
print(busbar("OUT1L3",("7,4!"),4,"OUT1L3"))
print(busbar("OUT1N",("8,5!"),8,"OUT1N"))
print(busbar("OUT1E",("9,6!"),8,"OUT1E"))
print[[
	Elem1
	Elem2
	Elem3
	Elem4
	CEE3PNI
	CEE3PNP
	LynxDist1
	LynxDist2
	LynxDist3
	EarthBar
	}
	{
		edge [ color = "brown" ]
	CEE3PNI->INL1:1
	VML1M:ACINP->INL1:2
	VML1S:ACINP->INL1:3
	VML1M:ACO1P->OUT1L1:2
	VML1S:ACO1P->OUT1L1:3
	OUT1L1->CEE3PNP
	}
	{
		edge [ color = "black" ]
	CEE3PNI->INL2
	VML2M:ACINP->INL2:2
	VML2S:ACINP->INL2:3
	VML2M:ACO1P->OUT1L2:2
	VML2S:ACO1P->OUT1L2:3
	OUT1L2->CEE3PNP
	}
	{
		edge [ color = "darkgray" ]
	CEE3PNI->INL3
	VML3M:ACINP->INL3:2
	VML3S:ACINP->INL3:3
	VML3M:ACO1P->OUT1L3:2
	VML3S:ACO1P->OUT1L3:3
	OUT1L3->CEE3PNP
	}
	{
		edge [ color = "blue" ]
		CEE3PNI->INN:1
		VML1M:ACINN->INN:2
		VML1S:ACINN->INN:3
		VML2M:ACINN->INN:4
		VML2S:ACINN->INN:5
		VML3M:ACINN->INN:6
		VML3S:ACINN->INN:7
		VML1M:ACO1N->OUT1N:2
		VML1S:ACO1N->OUT1N:3
		VML2M:ACO1N->OUT1N:4
		VML2S:ACO1N->OUT1N:5
		VML3M:ACO1N->OUT1N:6
		VML3S:ACO1N->OUT1N:7
		OUT1N:1->CEE3PNP
	}
	{
		edge [ style="dashed" color = "yellow" fillcolor="green" ]
		VML1M:ACINE->INE:2
		VML1S:ACINE->INE:3
		VML2M:ACINE->INE:4
		VML2S:ACINE->INE:5
		VML3M:ACINE->INE:6
		VML3S:ACINE->INE:7
	}
}
]]
