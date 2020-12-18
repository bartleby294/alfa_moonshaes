#include "omega_include"
void main()
{
int nEffect = VFX_FNF_SCREEN_SHAKE;
OmegaVisualEffectAtLocation(nEffect);
DelayCommand(2.0, OmegaVisualEffectAtLocation(nEffect));
DelayCommand(3.0, OmegaVisualEffectAtLocation(nEffect));
DelayCommand(4.0, OmegaVisualEffectAtLocation(nEffect));
DelayCommand(5.0, OmegaVisualEffectAtLocation(nEffect));
DelayCommand(6.0, OmegaVisualEffectAtLocation(nEffect));

   }
