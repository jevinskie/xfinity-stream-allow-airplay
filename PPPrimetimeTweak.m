#include "CaptainHook/CaptainHook.h"

CHDeclareClass(AVPlayer);
CHDeclareClass(PlayerObserver);

CHMethod(2, BOOL, PlayerObserver, isExternalPlaybackActive, AVPlayer *, player, mpController, id, mpc)
{
    NSLog(@"PlayerObserver(%@) isExternalPlaybackActive:%@ mpController:%@", self, player, mpc);
    return FALSE;
}


CHConstructor {
	CHLoadLateClass(AVPlayer);
	CHLoadLateClass(PlayerObserver);
	CHHook(2, PlayerObserver, isExternalPlaybackActive, mpController);
}
