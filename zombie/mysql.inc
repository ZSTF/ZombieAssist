Handle MySQL = INVALID_HANDLE;
void MySQL_OnPluginStart()
{
	if (MySQL == INVALID_HANDLE)
	{
		SQL_TConnect(MySQL_Connect, "moeub");
	}
}
void MySQL_OnPluginEnd()
{
	if (MySQL == INVALID_HANDLE)
	{
		return;
	}
	if (!CloseHandle(MySQL))
	{
		return;
	}
	MySQL = INVALID_HANDLE;
}
void MySQL_Connect(Handle Owner, Handle Child, const char[] Error, any Data)
{
	if (Owner == INVALID_HANDLE || Child == INVALID_HANDLE)
	{
		LogError("MySQL Connect Failure");
		return;
	}
	SQL_SetCharset(Child, "utf8");
	MySQL = Child;
	PrintToServer("MySQL Connect Success");
	Map_Load();
	Info_Load();
	Skill_Load();
	Model_Load();
	Credit_Load();
	Weapon_Load();
}
void MySQL_Query(Handle Owner, Handle Child, const char[] Error, any Data)
{
}