# Tactical Ops: Assault on Terror for Linux

## Tested on Ubuntu 22.04 Lts

Script created over TO-Fixed-Pack-v469d.7z and TOFP-LinuxFiles.zip that automates and applies the patch for v3.4.0 and v3.5.0.
The original files can be found at page [tactical-ops.eu](https://tactical-ops.eu/to-aot-fixed-pack.php)

```bash
chmod +x install.sh
./install.sh
```

### run game

```bash
./TacticalOps/TO3X0/System/TacticalOps.sh
```

### Troubleshooting

Open: TacticalOps.ini

- Change screen resolution if unable to do so within the game.

```bash
[WinDrv.WindowsClient]
WindowedViewportX=1024
WindowedViewportY=768
WindowedColorBits=32
```

- Switch to XOpenGLDrv driver if needed.

```bash
[Engine.Engine]
GameRenderDevice=XOpenGLDrv.XOpenGLRenderDevice
WindowedRenderDevice=XOpenGLDrv.XOpenGLRenderDevice
RenderDevice=XOpenGLDrv.XOpenGLRenderDevice
```

- Problem with Dual Monitors: disable one monitor or set the game to run on the primary monitor.

```bash
[WinDrv.WindowsClient]
StartupFullscreen=False
```

![TO-Linux](https://github.com/rdrgox/TacticalOps_Linux/assets/37422880/81e5523c-0cd0-43f9-b4fa-427a93f8b96e)


## Support

Discord [Tactical Ops Community](https://discord.com/invite/EHMfnqr)

## Appreciation
Special thanks to **jo0Oey** for hosting the files [tactical-ops.eu](https://tactical-ops.eu)
