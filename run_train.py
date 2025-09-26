# run_train.py
import pathlib, torch
torch.serialization.add_safe_globals([pathlib.PosixPath])

from piper.train.__main__ import main
if __name__ == "__main__":
    main()
