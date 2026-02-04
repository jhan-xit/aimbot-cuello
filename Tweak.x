#import <substrate.h>

struct Vector3 { float x, y, z; };
struct Vector3 (*orig_GetBonePos)(void *instance, int boneID);

struct Vector3 hook_GetBonePos(void *instance, int boneID) {
    if (instance != NULL) {
        if (boneID == 9) return orig_GetBonePos(instance, 10);
    }
    return orig_GetBonePos(instance, boneID);
}

%ctor {
    unsigned long offset = 0x104D658E0; 
    unsigned long slide = (unsigned long)_dyld_get_image_header(0);
    MSHookFunction((void *)(slide + offset), (void *)hook_GetBonePos, (void **)&orig_GetBonePos);
}
