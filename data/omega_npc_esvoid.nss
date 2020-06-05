#include "omega_include"
#include "spawn_main"
void main()
{
SetLocalInt(oMyTarget, "PatrolScriptRunning", TRUE);
AssignCommand(oMyTarget, ClearAllActions());
}
