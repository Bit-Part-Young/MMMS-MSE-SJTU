#!/usr/bin/env python3

"""
统计原子层间距变化（适用于表面/界面模型弛豫前后的原子层间距变化）

Author: SLY
Date: 2024-11-29
"""

import argparse

import numpy as np
import pandas as pd
from ase.atoms import Atoms
from ase.io import read


def get_distance(
    atoms: Atoms,
    precision: float = 0.001,
) -> tuple[np.ndarray, int]:
    """
    统计原子层间距
    """

    positions = atoms.positions

    z_coords = positions[:, 2]
    z_coords_rounded = precision * np.round(z_coords / precision)

    z_unique = np.unique(z_coords_rounded)

    distance = np.diff(z_unique)

    return distance, len(z_unique)


def interlayer_separations_cal(
    atoms_final: Atoms,
    atoms_init: Atoms,
    precision: float = 0.001,
) -> pd.DataFrame:
    """
    计算原子层间距变化（适用于表面/界面模型弛豫前后的原子层间距变化）
    """

    distance_final, layer_final_count = get_distance(atoms_final, precision)
    distance_init, layer_init_count = get_distance(atoms_init, precision)

    if layer_final_count != layer_init_count:
        raise ValueError(
            "Layer count of two structures is different! Exit. "
            "Maybe the Final structure xy plane is not perpendicular to z axis. "
            "Please check it!"
        )
    else:
        interlayer_separations = distance_final - distance_init
        ratio = (100 * (interlayer_separations / distance_init)).round(2)

        print(f"\nInerlayer separations info:\n")

        data = {
            "Layer_Distance_Final": distance_final,
            "Layer_Distance_Init": distance_init,
            "Inerlayer_Separations": interlayer_separations,
            "Ratio(%)": ratio,
        }
        index = [
            f"{i}-{i+1}" for i in range(1, len(interlayer_separations) + 1)
        ]

        df = pd.DataFrame(
            data=data,
            index=index,
        )

        # 逆序
        df = df[::-1]

    return df


if __name__ == "__main__":

    parser = argparse.ArgumentParser(
        description="Interlayer separations calculation (for Surface/Interface model after and before relaxation).",
        epilog="Author: SLY.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )

    parser.add_argument(
        "dump_fn",
        nargs="?",
        default="dump.lammpstrj",
        type=str,
        help="LAMMPS dump filename.",
    )

    args = parser.parse_args()

    dump_fn = args.dump_fn

    atoms_list = read(dump_fn, index=":")
    atoms_final = atoms_list[-1]
    atoms_init = atoms_list[0]

    interlayer_separations_info = interlayer_separations_cal(
        atoms_final=atoms_final,
        atoms_init=atoms_init,
    )
    print(interlayer_separations_info)
