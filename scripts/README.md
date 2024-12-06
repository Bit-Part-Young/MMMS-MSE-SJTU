# Scripts

- 《多尺度材料模拟与计算》课程用脚本

- **该仓库中的所有脚本仅供课程参考学习，请勿直接复制粘贴至自己的作业中！！！**

- 脚本介绍

```bash
mmms.sh                                   # 克隆多尺度材料模拟与计算课程材料（弃）
interlayer_separations.py                 # 统计原子层间距变化（适用于表面/界面模型弛豫前后的原子层间距变化）
surface_generation_ase.py                 # FCC (100), (110), (111) 表面模型构建（使用 ASE build 模块）
surface_generation_atomsk.sh              # FCC (100), (110), (111) 表面模型构建（使用 atomsk）
in_slab_relaxation.lmp                    # 表面能计算 LAMMPS in 文件（使用 read_data 命令导入表面构型）
HamonicOscillator_Free.ipynb              # 两端自由的简谐振子的 velocity verlet 算法实现
HamonicOscillator_Fixed.ipynb             # 一端固定的弹簧简谐振子的 velocity verlet 算法实现
LennardJonesPotential.ipynb               # Lennard-Jones 势
```
