"""
简单立方结构 没有施加周期性边界条件 没有采用近邻列表 下的 MD 模拟
结果不正确 请勿采用 仅供参考！！！
请勿直接复制粘贴该代码并分析该代码的结果！！！
"""

# reference code: https://github.com/glennklockwood/md-intro/blob/master/md.py

import os
from time import time
from typing import List, Tuple

import numpy as np
import pandas as pd

# 常量 为简化计算，均设为 1.0，得到的热力学数据不具有实际参考意义，仅供代码演示
ATOMIC_MASS = 1.0
EPSILON = 1.0
SIGMA = 1.0
TIMESTEP = 1.0e-3


def timer(func):
    """用于计时的装饰器"""

    def wrapper(*args, **kwargs):
        start_time = time()
        result = func(*args, **kwargs)
        end_time = time()
        print(
            f"Function <{func.__qualname__}> Total time used: {round(end_time - start_time, 3)} s."
        )
        return result

    return wrapper


def cal_force_energy_lj(
    distance: float, epsilon: float = EPSILON, sigma: float = SIGMA
) -> Tuple[float]:
    """
    计算 LJ 势函数下的两个原子之间的能量和力
    """

    pot_energy_ij = (
        4.0 * epsilon * ((sigma / distance) ** 6.0 - (sigma / distance) ** 12.0)
    )
    force_ij = (
        24.0
        * epsilon
        * (2.0 * sigma**12.0 / distance**13.0 - sigma**6.0 / distance**7.0)
    )

    return force_ij, pot_energy_ij


def velocity_verlet(
    pos: np.ndarray,
    vel: np.ndarray,
    accel: np.ndarray,
    mass: float = ATOMIC_MASS,
    epsilon: float = EPSILON,
    sigma: float = SIGMA,
    dt: float = TIMESTEP,
) -> List[float]:
    """
    使用 Velocity Verlet 算法更新原子的位置、速度和加速度
    """

    natoms = pos.shape[0]
    force = np.zeros(pos.shape)
    pot_energy = np.zeros(natoms)
    kin_energy = np.zeros(natoms)

    # Velocity Verlet, part I
    for i in range(natoms):
        vel[i, :] += 0.5 * dt * accel[i, :]
        pos[i, :] += dt * vel[i, :]

    # 位置更新后，得到新构型，计算每个原子的能量和力
    for i in range(0, natoms - 1):
        for j in range(i + 1, natoms):
            dpos = pos[j, :] - pos[i, :]
            r = np.sqrt(np.dot(dpos, dpos))

            force_ij, pot_energy_ij = cal_force_energy_lj(
                distance=r, epsilon=epsilon, sigma=sigma
            )

            pot_energy[i] += pot_energy_ij
            pot_energy[j] += pot_energy_ij
            force[i, :] -= force_ij * dpos / r
            force[j, :] += force_ij * dpos / r

    # Velocity Verlet, part II
    for i in range(natoms):
        accel[i, :] = force[i, :] / mass
        vel[i, :] += 0.5 * dt * accel[i, :]
        kin_energy[i] = 0.5 * mass * np.dot(vel[i, :], vel[i, :])

    # 总动能、总势能、总能量
    total_kin_energy = np.sum(kin_energy)
    total_pot_energy = np.sum(pot_energy)
    total_energy = total_kin_energy + total_pot_energy

    return [total_kin_energy, total_pot_energy, total_energy]


def save_xyz(types: List[str], pos: np.ndarray, save_fn: str = "output.xyz") -> None:
    """
    将原子位置等相关信息保存为 xyz 格式文件，可用 ovito 软件可视化，查看构型演化
    """

    natoms = pos.shape[0]

    if not os.path.exists(save_fn):
        f = open(save_fn, "w")
    else:
        f = open(save_fn, "a")

    f.write(f"{natoms}\n\n")
    for i in range(natoms):
        f.write(
            "  {:2s}  {:10.6f} {:10.6f} {:10.6f}\n".format(
                types[i].title(), *(pos[i, :])
            )
        )
    f.close()


def load_xyz(fn: str) -> Tuple[List[str], np.ndarray]:
    """导入 xyz 格式构型文件"""

    with open(fn, "r") as xyzfile:
        while True:
            try:
                num_atoms = int(xyzfile.readline())
            except ValueError:
                break
            xyzfile.readline()
            positions = np.zeros((num_atoms, 3))
            types = []
            for i in range(num_atoms):
                atom_type, x, y, z = xyzfile.readline().strip().split()
                types.append(atom_type.lower())
                positions[i, :] = [float(x), float(y), float(z)]

    return types, positions


@timer
def main():
    """主函数"""

    types, pos = load_xyz("input.xyz")
    vel = np.zeros(pos.shape)
    accel = np.zeros(pos.shape)
    mass = ATOMIC_MASS
    dt = TIMESTEP

    thermo_data_list = []

    for i in range(20000):
        thermo_data = velocity_verlet(pos=pos, vel=vel, accel=accel, mass=mass, dt=dt)
        if (i % 100) == 0:
            time = round(i * dt, 2)
            thermo_data.append(time)
            thermo_data_list.append(thermo_data)
            save_xyz(types, pos)

    # 保存热力学数据
    colname_list = ["kin_energy", "pot_energy", "total_energy", "time"]
    df = pd.DataFrame(thermo_data_list, columns=colname_list)
    df.to_csv("thermo_data.csv", index=False, sep=",")


if __name__ == "__main__":
    main()

    print("Done!")
