# convert_ckpt.py
import sys, torch
src, dst = sys.argv[1], sys.argv[2]
ckpt = torch.load(src, weights_only=False, map_location="cpu")  # ONLY if you trust this file
state_dict = ckpt.get("state_dict", ckpt)
torch.save(state_dict, dst)
print(f"Saved weights-only checkpoint to {dst}")
