# Notes on DFT hands-on session of MSE6701H-CHN

**Content:**
[TOC]



---

## 0. Notice

同学们好，今晚的课程为 DFT 部分上机实操课：

1. 请同学们尽量都准备好笔记本电脑并充保持充足的电量（充电器也可以带上），条件允许的同学可以把排插带上
2. 本次上机实操课将涉及 DFT 性质计算（如晶格常数、能带、键长、空位形成能、表面能等）及 VASP 实操（如收敛性测试、静态计算、弛豫计算、能带计算、态密度计算等）等内容
3. **不同性质的计算，VASP 输入文件相关参数会有所不同，查阅官网手册了解参数设置含义，体会 “some practical concerns - First principles calculations within DFT” 课程内容的关联**
4. 在使用课程材料前，请先阅读该目录下的 `README` 文件内容来大致了解其使用说明、框架及功能，不要一开始就 “盲目” 进行操作（提交任务），以免出现不必要的错误
5. **使用课程材料过程中，请熟悉课程材料的目录及文件结构**！课程材料及该 Notes 均测试正常


---

可能有帮助的一些教程链接：

- 《多尺度材料模拟与计算》课程 MD、DFT 部分实验材料：[Course Materials for MSE6701H Multiscale Materials Modelling and Simulation](https://gitee.com/yangsl306/MMMS)
- 《多尺度材料模拟与计算》课程作业相关问题：[MMMS homework questions](https://mmms.seekanotherland.xyz/homework/mmms-homework-questions)
- WSL 安装与使用：[WSL 安装与使用 - Wiki of NES Lab](https://nesmm-wiki.seekanotherland.xyz/linux/wsl-usage)
- Linux 相关教程：[LINUX-TUTORIAL](https://dunwu.github.io/linux-tutorial/)
- VASP INCAR 参数：[Category:INCAR tag - Vaspwiki](https://www.vasp.at/wiki/index.php/Category:INCAR_tag)
- VASP POSCAR：[POSCAR - Vaspwiki](https://www.vasp.at/wiki/index.php/POSCAR)
- VASP KPOINTS：[KPOINTS - Vaspwiki](https://www.vasp.at/wiki/index.php/KPOINTS)
- VASP 赝势推荐：[Available PAW potentials - Vaspwiki](https://www.vasp.at/wiki/index.php/Available_PAW_potentials#Recommended_potentials_for_DFT_calculations)
- VASPKIT Features: [Features — VASPKIT 1.5 documentation](https://vaspkit.com/features.html)
- 模型构建相关开源程序
    - [Atomsk](https://atomsk.univ-lille.fr/)
    - [pymatgen](https://pymatgen.org/)
    - [ASE](https://wiki.fysik.dtu.dk/ase/)
    - [latgen](https://github.com/lingtikong/latgen)
    - [PyXtal](https://pyxtal.readthedocs.io/en/latest/)
    - ...



---

## 1. Preparation

### 1.1. Access to the cluster

We are still going to use Siyuan cluster for the hands-on session for the DFT part. Your temporary account should still be working.

If you forget how to access the Siyuan cluster, please refer to the [manual for the MD part](https://notes.sjtu.edu.cn/s/ULArhqGqt).


---

### 1.2. Update MMMS Course Materials

update(`git pull`) the latest MMMS Course Materials
```bash
cd ~/MSE6701H/MMMS

git pull
```


or
```bash
cd ~/MSE6701H
mv MMMS MMMS-bk  # any name you like
git clone https://gitee.com/yangsl306/MMMS.git
```


**Optional**: add DFT and MD part tools path to `~/.bashrc` file, then `source ~/.bashrc`.
```bash
# MD part tools
export PATH=$PATH:$HOME/MSE6701H/MMMS/2-MolecularDynamics/0-tools
# DFT part tools
export PATH=$PATH:$HOME/MSE6701H/MMMS/3-DFT/0-tools
```



---

## 2. Step by step instructions on the DFT examples

### 2.1. Single point calculation for FCC Cu

#### 2.1.1. Without convergence test

Get into the first example
```bash
cd ~/MSE6701H/MMMS/3-DFT/1-Convergence-Tests

ll
```

it should look like:

![Snipaste_2023-11-20_20-55-58.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311202110362.png)


We'll first try to carry out the calculation without convergence test. Get into the corresponding directory
```bash
cd 1-without-convergence-test

tree
```

directory structure:
```txt
.
├── INCAR
├── job.slurm
├── KPOINTS
├── POSCAR
├── POTCAR
├── README
└── run
```

!!! danger ""

    Please check the content of all the files to have an idea on the calculation. Especially the `README` and `job.slurm`:


```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```


Once the job is completed, you can check the results(Total energy) in `OUTCAR` or `OSZICAR`.
```bash
grep 'free  energy' OUTCAR
# or
tail -1 OSZICAR
```

!!! danger ""

    NOTE: there are exactly two spaces between “free” and “energy”.


![Snipaste_2023-11-20_21-14-22.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311202114769.png)

---

(**Optional**) Get the total k-points
```bash
head -n 38 IBZKPT | tail -n 35 | awk '{sum+=$4} END {print sum}'
```


---

#### 2.1.2. Convergence test with respect to k-mesh size

Get into the directory
```bash
cd ../2-convergence-k-mesh
# or
cd ~/MSE6701H/MMMS/3-DFT/1-Convergence-Tests/2-convergence-k-mesh

ls -l
```

!!! danger ""

    Please check the content of all the files to have an idea on the calculation. Especially the `README` and `job.slurm`:


```bash
cat README

cat job.slurm
```

Run your job
```bash
sbatch job.slurm
```

Once completed, check the `eng_k.dat` file for the convergence information
```bash
cat eng_k.dat
```

And you can use the `check_conv_k` script prepared to visualize the convergence information:
```bash
../../0-tools/check_conv_k
# or
check_conv_k
```

A figure should be shown to visualize the convergence information.


![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212158380.png)


---

#### 2.1.3. Convergence test with respect to plane wave cutoff energy

Get into the directory
```bash
cd ../3-convergence-ecut
# or
cd ~/MSE6701H/MMMS/3-DFT/1-Convergence-Tests/3-convergence-ecut

ls -l
```

!!! danger ""

    Please check the content of all the files to have an idea on the calculation. Especially the `README` and `job.slurm`:


```bash
cat README

cat job.slurm
```

Run the calculations, it might take some time
```bash
sbatch job.slurm
```

Once the calculation is completed, check the `eng_ecut.dat` file for the convergence information
```bash
cat eng_ecut.dat
```

You can also use the `check_conv_ecut` script prepared to visualize the convergence information:
```bash
../../0-tools/check_conv_ecut
# or
check_conv_ecut
```

A figure should be shown to visualize the convergence information.


![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212200876.png)


---

#### With convergence test

Get into the directory
```bash
cd ../4-with-optimized-k-ecut
# or
cd ~/MSE6701H/MMMS/3-DFT/1-Convergence-Tests/4-with-optimized-k-ecut
```

Run the calculation
```bash
sbatch job.slurm
```

Once completed, check the `OUTCAR` for the information. Compare the energy to that without convergence test
```bash
grep 'free  energy' ../1-without-convergence-test/OUTCAR
grep 'free  energy' OUTCAR
```

![Snipaste_2023-11-21_21-08-02.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212111066.png)


---

### 2.2. Lattice constant calculation

#### 2.2.1. FCC Cu

Get into the directory
```bash
cd ../../2-Lattice-Constant/1-FCC-Cu
# or
cd ~/MSE6701H/MMMS/3-DFT/2-Lattice-Constant/1-FCC-Cu
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCAR`


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Find the equilibrium lattice constant**: Once the job is completed, you should find a file named `eng_a.dat` with contents under your directory, you can fit the data to an [Equation of States](http://www.sklogwiki.org/SklogWiki/index.php/Murnaghan_equation_of_state) and obtain the equilibrium lattice constant by:
```bash
../../0-tools/eos_fit eng_a.dat
# or
eos_fit eng_a.dat
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212152737.png)

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212157853.png)



---

#### 2.2.2. BCC Fe

Get into the directory
```bash
cd ../2-BCC-Fe
# or
cd ~/MSE6701H/MMMS/3-DFT/2-Lattice-Constant/2-BCC-Fe
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCAR`


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

Find the equilibrium lattice constant
```bash
../../0-tools/eos_fit eng_a.dat
# or
eos_fit eng_a.dat
```


![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212204518.png)


![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212155859.png)



---

### 2.3. Band structure Calculations

For band structure calculations, generally one should perform two (or three if DOS is also wanted) calculations in sequence:

- **Self-consistent calculation**. By running a usual single point energy calculation on a uniform k-mesh to obtain the ground state electron density.

- **Non-self-consistent calculation of band structure**. By fixing the electron density as obtained from the previous run (**ICHARG = 11** in `INCAR`), the eigenvalues for different bands along a prescribed k-path will be calculated. Since in this case the k-path is not a uniform sampling of the reciprocal space.

- **Non-self-consistent calculation of density of states**. Generally this step is not quite necessary, but sometime useful. One also keeps the electron density from the first step fixed (**ICHARG = 11** in `INCAR`), but performs a calculation on a much denser k-mesh than the first step to obtain a smooth electron density of states.


---

#### 2.3.1. FCC Cu

Get into the directory
```bash
cd ../../3-Band-Structure/1-FCC-Cu
# or
cd ~/MSE6701H/MMMS/3-DFT/3-Band-Structure/1-FCC-Cu
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCARs` and `KPOINTSs`. The three `INCARs` and three `KPOINTSs` correspond to the scf and nscf calculations, respectively.


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Examine the band structure and DOS**: Once the job is completed, you should be able to get the band structure via the following command:
```bash
../../0-tools/plot_cu_bs
# or
plot_cu_bs
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212206550.png)


You should also be able to get the electronic DOS via the following command:
```bash
../../0-tools/plot_cu_dos
# or
plot_cu_dos
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212205472.png)


!!! danger ""

    Note: The Fermi energy has been shifted to be zero.


---

#### 2.3.2. BCC Fe

Get into the directory
```bash
cd ../2-BCC-Fe           
# or
cd ~/MSE6701H/MMMS/3-DFT/3-Band-Structure/2-BCC-Fe
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCARs` and `KPOINTSs`.


Check the scripts
```bash
cat README         

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Examine the band structure and DOS**: Once the job is completed, you should be able to get the band structure via the following command:
```bash
../../0-tools/plot_fe_bs
# or
plot_fe_bs
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212206483.png)


You should also be able to get the electronic DOS via the following command:
```bash
../../0-tools/plot_fe_dos
# or
plot_fe_dos
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212207250.png)


---

#### 2.3.3. Graphene

Graphene structure:

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311301044329.png)


---

Get into the directory
```bash
cd ../3-Graphene/            
cd ~/MSE6701H/MMMS/3-DFT/3-Band-Structure/3-Graphene
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCARs` and `KPOINTSs`.


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Examine the band structure and DOS**: Once the job is completed, you should be able to get the band structure via the following command:
```bash
../../0-tools/plot_graphene_bs
# or
plot_graphene_bs
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212208994.png)


You should also be able to get the electronic DOS via the following command:
```bash
../../0-tools/plot_graphene_dos
# or
plot_graphene_dos
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212208573.png)


---

#### 2.3.4. Polyethylene (-CH$_2$CH$_2$-)

This example illustrates the calculation of band structure for polyethylene (-CH$_2$CH$_2$-) molecule chain (of infinite length):

![](https://notes.sjtu.edu.cn/uploads/upload_921ea934b1b980d971c26846a4753374.png)

It has periodicity along **x** direction, while free boundary (supercell) condition along the other two. Large vacuum along **y** and **z** are therefore introduced.

---

Get into the directory
```bash
cd ../4-Polyhexene/
# or
cd ~/MSE6701H/MMMS/3-DFT/3-Band-Structure/4-Polyhexene
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCARs` and `KPOINTSs`.


Check the scripts
```bash
cat run
# or
cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Examine the band structure**: Once the job is completed, you should be able to get the band structure via the following command:
```bash
../../0-tools/plot_polyethylene_bs
# or
plot_polyethylene_bs
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212210435.png)


---

### 2.4. Bond length for H$_2$ molecule

#### 2.4.1. Ground state of H atom

Get into the directory
```bash
cd ../../4-Bond-Length/1-H-atom
# or
cd ~/MSE6701H/MMMS/3-DFT/4-Bond-Length/1-H-atom
```

Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

!!! danger ""

    Note: Since we are calculating a single isolated atom, a large supercell is used, and no periodicity is expected. Therefore we use only the $\Gamma$ k-point. And since the supercell is large, many $\mathbf{G}$ are within the cutoff radius and in turn the calculation will take some time.


**Examine the energy level**: Once the job is completed, you should be able to get the energy level via the following command:
```bash
../0-tools/plot_eng_level
# or
plot_eng_level
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212211372.png)


You should also be able to get the total energy of $H$ atom via the following command:
```bash
grep 'free  energy' OUTCAR
```

!!! danger ""

    NOTE: there are exactly two spaces between “free” and “energy”.


![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212140017.png)

Let's denote the ground state energy of a single $H$ atom as $E_H$.


---

#### 2.4.2. Relaxation of $H_2$ molecule

Get into the directory
```bash
cd ../2-H2-molecule       
# or
cd ~/MSE6701H/MMMS/3-DFT/4-Bond-Length/2-H2-molecule
```

Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Examine the energy level of** $H_2$: Once the job is completed, you should be able to get the energy level via the following command:
```bash
../../0-tools/plot_eng_level
# or
plot_eng_level
```

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212212195.png)


You should also be able to get the total energy of $H$ atom via the following command:
```bash
grep 'free  energy' OUTCAR | tail -n 1
```

!!! danger ""

    NOTE: there are exactly two spaces between “free” and “energy”.


![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212141245.png)


---

Let's denote the ground state energy of $H_2$ as $E_{H_2}$, the $H-H$ bond energy can be derived as:

$$
E_{bond} = E_{H_2} – 2*E_H
$$

**Bond length and energy of** $H_2$: The bond length and bond energy can be obtained from the final geometry:
```bash
../../0-tools/get_h2_bondlen_eng
# or
get_h2_bondlen_eng
```

!!! info ""

    The experimental bond length and bond energy are about $0.74$ Å and $4.52$ eV, respectively.


![Snipaste_2023-11-21_21-37-20.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212137245.png)


---

### 2.5. Surface energy calculation

In this example, we will illustrate the calculation of surface energy for Cu(001). Generally, the surface energy of a clean metal surface can be calculated by three steps:

 - **Static calculation of a bulk crystal, serving as a reference**; here we will skip it, as it has been calculated in determining the lattice constant of Cu. Assuming the calculated bulk energy is $E_{bulk}$ (per atom).

 - **Construct a surface model, and make a static calculation**, assuming the obtained total energy is $E_{unrelaxed}$ and the total number of atoms in the surface model (slab) is $N$.

 - **Fix bottom three layers of the surface model, and allow the other atoms to relax freely**. Make a relaxation run, and then a static run with the relaxed configuration (`mv CONTCAR POSCAR` and run a static calculation.) Assuming the final energy of the relaxed surface model is $E_{relaxed}$.

 The surface energy of the model should be given by:

 $$
 \gamma = \frac{E_{unrelaxed}-N E_{bulk}}{2A} + \frac{E_{relaxed}-E_{unrelaxed}}{A}
 $$

The as-cleaved surface model has two surfaces, and therefore a faction of 2 in the first term of the above equation; while the relaxation is performed only on the top surface, hence no factor of 2 in the second term.

---

FCC-Cu(001) 1x1x7+12 Ang vacuum structure:

![image.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311301053881.png)


---

Get into the directory
```bash
cd ../../5-Surface-Energy/                 
# or
cd ~/MSE6701H/MMMS/3-DFT/5-Surface-Energy/
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCARs` and `POSCARs`.


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

**Work out the surface energy and interlayer distance change**: Once the calculations are done, you can check the `OUTCAR` to confirm the force on each atom, and check the atomic position for the atoms, so as to work out the change in interlayer distance for the surface model. Alternatively, you can also use the script provided to find out the surface energy and the relative change in interlayer distances:
```bash
./calculate_surface_energy.sh
./calculate_interlayer_deform.sh
```

![Snipaste_2023-11-21_21-24-49.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212125765.png)


---

### 2.6. Vacancy formation energy

The vancancy formation energy is defined as the excess energy when creating a vacancy in an otherwise ideal crystal:

$$
E_{v}^{f} = E_{vac} - \frac{N-1}{N}E_{bulk}
$$

where $E_{vac}$ is the total energy of the supercell with a vacancy, while $E_{bulk}$ is the total energy of the supercell without any vacancy.

Theoretically speaking, $E_{bulk}$ can also be obtained from the calculation for a pritimive bulk cell. **In practice, however, due to the difference in smearing method, k-mesh size, etc., there might be some difference in the total energy between a bulk supercell and a primitive one. This might translate into large uncertainty in the obtained vacancy formation**. It is therefore advised to perform two separate calculations:

- Static calculation for supercell without vacancy;

- Relaxation of the supercell with a vacancy, and then continue with a static calculation.

The energies obtained from these calculations can then be used to calculate the vacancy formation energy.


---

#### 2.6.1. Static calculation for supercell without vacancy

Get into the directory
```bash
cd ../6-Vacancy-formation-energy/1-without-vacancy     
# or
cd ~/MSE6701H/MMMS/3-DFT/6-Vacancy-formation-energy/1-without-vacancy
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCAR`、`POSCAR` and `KPOINTS`.


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

The total energy can be find by:
```bash
grep 'free  energy' OUTCAR
```

!!! danger ""

    NOTE: there are exactly two spaces between “free” and “energy”.


![Snipaste_2023-11-21_20-40-26.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212123593.png)


---

#### 2.6.2. Relaxation and then static calculation for supercell with a vacancy

Get into the directory
```bash
cd ../2-with-a-vacancy/
# or
cd ~/MSE6701H/MMMS/3-DFT/6-Vacancy-formation-energy/2-with-a-vacancy/
```

!!! danger ""

    Please read through all the main input files of vasp, especially `INCARs`、`POSCAR` and `KPOINTS`.


Check the scripts
```bash
cat README

cat job.slurm
```

Run the calculation
```bash
sbatch job.slurm
```

Work out the vacancy formation energy
```bash
./calculate_vacancy_formation_energy.sh
```

![Snipaste_2023-11-21_20-43-07.png](https://cdn.jsdelivr.net/gh/Bit-Part-Young/BTY-imgs/images/202311212122464.png)



---

## 3. DFT Course Project

!!! info ""

    This will be your second course project. The due is: **Dec 13th, 2023**.


You can follow the examples of **1-single-point-fcc-Cu** and **2-lattice-constant-fcc-Cu** to finish your homework. The pseudopotential file needed can be obtained by:
```bash
cp  ~/MSE6701H/MMMS/3-DFT/0-tools/potcars/POTCAR.Al  POTCAR
```
