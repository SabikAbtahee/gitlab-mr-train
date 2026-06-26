import { execa } from "execa";

export type SoundKind = "error" | "done";

export function isSoundEnabled(): boolean {
  const raw = process.env.MR_TRAIN_SOUNDS;
  if (raw === "0" || raw?.toLowerCase() === "false" || raw?.toLowerCase() === "off") {
    return false;
  }
  return true;
}

export function playSound(kind: SoundKind): void {
  if (!isSoundEnabled()) return;
  void playSoundAsync(kind).catch(() => {});
}

async function playSoundAsync(kind: SoundKind): Promise<void> {
  if (process.platform === "darwin") {
    const file =
      kind === "error"
        ? "/System/Library/Sounds/Basso.aiff"
        : "/System/Library/Sounds/Glass.aiff";
    await execa("afplay", [file]);
    return;
  }

  if (process.platform === "linux") {
    const file =
      kind === "error"
        ? "/usr/share/sounds/freedesktop/stereo/dialog-error.oga"
        : "/usr/share/sounds/freedesktop/stereo/complete.oga";
    await execa("paplay", [file]);
    return;
  }

  if (process.platform === "win32") {
    const freq = kind === "error" ? 400 : 800;
    await execa("powershell", ["-NoProfile", "-c", `[console]::beep(${freq},300)`]);
    return;
  }

  process.stdout.write("\u0007");
}
