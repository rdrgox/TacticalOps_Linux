# Tactical Ops: Assault on Terror for Linux

## Tested on 
- Ubuntu 22.04 Lts 
- Fedora Linux 43
- Arch

This script is based on `TO-Fixed-Pack-v469d.7z` and `TOFP-LinuxFiles.zip` and automates the patch installation for `v3.4.0` and `v3.5.0`.

Original files can be found here:  
[tactical-ops.eu](https://tactical-ops.eu/to-aot-fixed-pack.php)

---

## Installation

```bash
chmod +x install.sh
./install.sh
```

### Run game

```bash
chmod +x TacticalOps/TO3X0/System/TacticalOps.sh
./TacticalOps/TO3X0/System/TacticalOps.sh
```

## Troubleshooting

Audio crash / ALAudio.so issue

If the game crashes or fails during startup with audio-related errors, the problem is related to the `ALAudio.so` library.

Example error:

```bash
[41] /home/user/TacticalOps/TO350/System/ut-bin-amd64() [0x405b0a] Signal: SIGIOT [iot trap] Aborting. Signal: SIGIOT [iot trap] History: appGetDllHandle <- UPackage::BindPackage <- UPackage::UPackage <- UObject::CreatePackage <- UObject::ResolveName <- UObject::StaticLoadObject <- UObject::StaticLoadClass <- UEngine::InitAudio <- UGameEngine::Init <- InitEngine <- main Exiting due to error ./TacticalOps.sh: línea 15: 11787 Abortado
```

Fix

- Run the install script normally.
- Download and extract the fixed ALAudio.so file from the Unreal repository. [UnrealTournamentPatches](https://github.com/OldUnreal/UnrealTournamentPatches/releases/tag/v469e) -> 
`OldUnreal-UTPatch469e-Linux-amd64.tar.bz2`
- Replace the file located at:

```bash
TacticalOps/TO3X0/System/ALAudio.so
```

Screen resolution issues

Edit: TacticalOps.ini

```bash
[WinDrv.WindowsClient]
WindowedViewportX=1024
WindowedViewportY=768
WindowedColorBits=32
```

Rendering issues (OpenGL driver)

If you experience graphical issues, try switching to XOpenGLDrv.

```bash
[Engine.Engine]
GameRenderDevice=XOpenGLDrv.XOpenGLRenderDevice
WindowedRenderDevice=XOpenGLDrv.XOpenGLRenderDevice
RenderDevice=XOpenGLDrv.XOpenGLRenderDevice
```

Dual monitor issues

If the game behaves incorrectly on dual monitor setups, disable one monitor or force the game to run on the primary monitor.

```bash
[WinDrv.WindowsClient]
StartupFullscreen=False
```

![TO-Linux](https://github.com/rdrgox/TacticalOps_Linux/assets/37422880/81e5523c-0cd0-43f9-b4fa-427a93f8b96e)


## Support

Discord [Tactical Ops Community](https://discord.com/invite/EHMfnqr)

## Appreciation
Special thanks to **jo0Oey** for hosting the files [tactical-ops.eu](https://tactical-ops.eu)
