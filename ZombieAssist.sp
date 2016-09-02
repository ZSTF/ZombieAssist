#pragma semicolon 1
#include <sourcemod>
#include <cstrike>
#include <sdkhooks>
#include <sdktools>
#include <zombiereloaded>
#include <morecolors>
#include <stringescape>
#include "zombie/function"
#include "zombie/alert"
#include "zombie/sound"
#include "zombie/check"
#include "zombie/clan"
#include "zombie/mode"
#include "zombie/navbar"
#include "zombie/entity"
#include "zombie/mysql"
#include "zombie/client"
#include "zombie/alpha"
#include "zombie/info"
#include "zombie/model"
#include "zombie/weapon"
#include "zombie/damage"
#include "zombie/leader"
#include "zombie/event"
#include "zombie/map"
#include "zombie/translate"
#include "zombie/admin"

public Plugin myinfo =
{
	name = "Zombie Assist",
	author = "Yuera",
	description = "Zombiei Assist",
	version = "1.0",
	url = "http://www.moeub.com/"
};
public void OnPluginStart()
{
	MySQL_Start();
	Alert_Init();
	Event_Init();
	RegConsoleCmd("say", Say_Command);
	RegConsoleCmd("sm_skin", Model_Command);
	RegAdminCmd("sm_info_reload", Info_Reload_Command, ADMFLAG_GENERIC);
	RegConsoleCmd("sm_model", Model_Command);
	RegAdminCmd("sm_model_reload", Model_Reload_Command, ADMFLAG_GENERIC);
	RegConsoleCmd("sm_zbuy", Weapon_Command);
	RegConsoleCmd("sm_weapon", Weapon_Command);
	RegAdminCmd("sm_weapon_reload", Weapon_Reload_Command, ADMFLAG_GENERIC);
	RegConsoleCmd("sm_alpha", Alpha_Command);
	RegAdminCmd("sm_zeadmin", Admin_Command, ADMFLAG_GENERIC);
	CreateTimer(1.0, Navbar_Timer, _, TIMER_REPEAT);
	CreateTimer(20.0, Info_Timer, _, TIMER_REPEAT);
	CreateTimer(30.0, Entity_Timer, _, TIMER_REPEAT);
}
public void OnPluginEnd()
{
	MySQL_Close();
}
public void OnMapStart()
{
	Map_Init();
	Map_Load();
	Info_Load();
	Model_Load();
	Weapon_Load();
}
public void OnMapEnd()
{
	Map_OnMapEnd();
	Mode_OnMapEnd();
}
public void OnConfigsExecuted()
{
	Mode_Init();
}
public void OnClientPostAdminCheck(int Client)
{
	Clan_Init(Client);
	Admin_Init(Client);
}
public void OnClientConnected(int Client)
{
	Client_Init(Client);
}
public void OnClientPutInServer(int Client)
{
	Client_Load(Client);
	Damage_Hook(Client);
}
public void OnClientDisconnect(int Client)
{
	Client_Clean(Client);
	Damage_Unhook(Client);
}
public void OnGameFrame()
{
	Alpha_OnGameFrame();
}