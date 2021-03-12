import concurrent.futures
import os
import re
import shlex
import time
import traceback
from pathlib import Path
from subprocess import Popen


MOUNT_POINT = os.getenv("MOUNT_POINT")
COMSKIP_PROCESSES = int(os.getenv("COMSKIP_PROCESSES"))
COMSKIP_COMMAND = os.getenv("COMSKIP_COMMAND")

def main():
    while True:
        with concurrent.futures.ProcessPoolExecutor(max_workers=COMSKIP_PROCESSES) as executor:
            futures = executor.map(handle_wrap, enumerate_paths())
            concurrent.futures.wait(futures)

        time.sleep(10)

# MOUNT_POINT 以下の m2ts ファイルを列挙
def enumerate_paths():
    return Path(MOUNT_POINT).glob("**/*.m2ts")

def handle_wrap(path):
    try:
        handle(path)
    except:
        print(f"Failed: {path}")
        traceback.print_exc()

def handle(path):
    # chapters ディレクトリがないなら作る
    chapters_dir = path.parent / "chapters"
    if not chapters_dir.exists():
        chapters_dir.mkdir()

    # chapter ファイルを作成済なら無視
    chapter_path = chapters_dir / path.with_suffix(".chapter").name
    if chapter_path.exists():
        return

    # 1秒前のファイルサイズと比較し変動があればファイルが使用中と判断して無視
    size = path.stat().st_size
    time.sleep(1)
    if size != path.stat().st_size:
        return

    # comskip を実行
    command = f"{COMSKIP_COMMAND} {path}"
    print(f"Popen: {command}")
    with Popen(shlex.split(command)) as p:
        p.wait()

    # txt ファイル, vdr ファイルがないなら失敗と判断
    txt_path = path.with_suffix(".txt")
    vdr_path = path.with_suffix(".vdr")
    if not txt_path.exists() or not vdr_path.exists():
        return

    # vdr ファイルを読み込み chapter を作成
    with vdr_path.open() as f:
        vdr = f.read()
    chapters = create_chapters(vdr)

    # chapter ファイルに UTF-8 with BOM で保存
    with chapter_path.open("w", encoding="utf_8_sig") as f:
        f.write(chapters)

    # 不要な txt, vdr ファイルを削除
    txt_path.unlink()
    vdr_path.unlink()

    print(f"Success: {path}")

vdr_line_pattern = re.compile(r"^(\d):(\d+):(\d+).(\d+) (start|end)$")

def extract_cm_ranges(vdr):
    last_ms = None

    for line in vdr.splitlines():
        if (m := vdr_line_pattern.match(line)) is None:
            continue

        hours, minutes, seconds, ms, flag = m.groups()
        hours = int(hours)
        minutes = int(minutes) + hours * 60
        seconds = int(seconds) + minutes * 60
        ms = int(ms) * 10 + seconds * 1000

        if flag == "start":
            last_ms = ms
        elif flag == "end":
            yield (last_ms, ms)
        else:
            raise Exception(f"Unknown flag: {flag}")

def create_chapters(vdr):
    chapters = ["c"]

    for start, end in extract_cm_ranges(vdr):
        chapters.append(f"{start}cix")
        chapters.append(f"{end}cox")

    chapters.append("c")
    return "-".join(chapters)

if __name__ == "__main__":
    main()