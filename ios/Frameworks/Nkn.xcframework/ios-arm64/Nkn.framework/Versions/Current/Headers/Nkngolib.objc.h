// Objective-C API for talking to nkngolib Go package.
//   gobind -lang=objc nkngolib
//
// File is generated by gobind. Do not edit.

#ifndef __Nkngolib_H__
#define __Nkngolib_H__

@import Foundation;
#include "ref.h"
#include "Universe.objc.h"

#include "Nkn.objc.h"
#include "Dnsresolver.objc.h"
#include "Ethresolver.objc.h"
#include "Nkngomobile.objc.h"

FOUNDATION_EXPORT void NkngolibAddClientConfigWithDialContext(NknClientConfig* _Nullable config);

#endif
