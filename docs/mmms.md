+++
description = " 多尺度材料模拟与计算 "
external_link = ""
vacancy_id = ""
+++

# 多尺度材料模拟与计算

- 课程代码：MSE6701H
- 学分/学时：3.0/48
- 授课对象：研究生
- 授课语言：中文
- 开课学期：秋季学期
- 课程类型：专业基础课
- 开课学院：材料科学与工程学院
- 任课教师：孔令体、刘桂森、刘泓


---

## 课程内容介绍

本课程是对材料科学与工程学科研究生的专业基础课，旨在培养学生材料科学计算的理念、概念与技能。主要讲授材料科学问题中跨尺度模拟与计算的概念与方法，着重介绍采用电子层次的第一性原理计算、原子及分子尺度的分子动力学模拟等方法的基本概念、基本原理、基本方法和典型应用，简要介绍介观、宏观尺度模拟方法，以及跨尺度模拟与计算、高通量计算与材料基因组的概念，使学生较为系统地掌握多尺度材料模拟与计算的基本概念和技能，深化对材料 " 结构 - 性能 " 本构关系的理解，激发并拓宽学生的材料研究理念与思维模式，使其能够运用新方法解决材料科学中的多尺度问题。本课程的实验教学内容涵盖数值模拟、统计分析、数据可视化等相关技术，并将介绍各尺度模拟计算的常用软件及可视化软件。


---

## 课程大纲

课程大纲 pdf 请点击：[MSE6701H《多尺度材料模拟与计算》教学大纲.pdf](https://smse.sjtu.edu.cn/storage/smse/web/article/2022/09/789b17f0155b997c31a47093cd36ac1c.pdf)。

---

1. Overview
	- Introduction
	- Materials Science and Engineering
	- Modeling and Simulation
	- Multiscale: temporal and spatial
	- Multiscale Modeling and Simulation: examples
	- MMMS: history, state of the art, and outlook
	- Tools and requirements
	- Course outline

2. Electronic Scale method：Density functional theory
	- Quantum mechanics
	- Born-Oppenhemier Approximation
	- Hartree Fock
	- DFT
	- Kohn-Sham
	- Exchange-correlation functionals

3. DFT for crystals
	- Math: Fourier Transformation
	- Delta function
	- Crystal lattice: density distribution, unit cell
	- Bloch theorem
	- Plane waves

4. Practical concerns
	- k-sampling
	- convergence tests
	- Smearing methods
	- Plane wave cutoff energy
	- Pseudopotential
	- Boundary condition

5. DFT Hands-on
	- Linux and VASP
	- Single point energy calculation
	- Convergence tests
	- Lattice constant and bulk modulus
	- Bond length and relaxation
	- Band structure of Cu
	- Band structure of graphene

6. Atomic Scale Method
	- Development and algorithm
	- Development of MD
	- Basic idea, flowchart
	- Basic algorithm
	- Demonstration: spring oscillator
	- Timestep and temporal-spatial limitations
	- Periodic boundary condition
	- Minimum image convention
	- Intro to LAMMPS

7. Classical Interatomic potentials
	- Pair potentials
	- Truncation scheme
	- Many-body potentials
	- Force evaluation
	- Neighbor list
	- Demonstration: a system of Lennard-Jones particles

8. Molecular Statics to Molecular dynamics
	- Molecular statics：Minimization
	- Statistical Mechanics: Ensembles (NVE, NVT, …)
	- Temperature, pressure: Thermostat, barostat
	- Molecular dynamics: algorithm

9. Model preparation and results analysis
	- Crystal structure
	- Surface, Dislocations
	- Molecular Statics: relaxation
	- Visualization: Ovito
	- Running a simulation: initialization, running, and analysis
	- Structure analysis (pair correlation function, common neighbor analysis), Property evaluation (Energy, temperature, pressure, thermal capacity, deformation, melting and solidification)

10. MD Hands-on (I)
	- Model creation and using of LAMMPS
	- Molecular statics
	- Dislocation motion under shear
	- Structure analysis

11. MD Hands-on (II)
	- Melting point calculation: FCC Cu
	- Diffusion coefficients from Einstein relation
	- Phonon dispersion of di-atomic chain and Cu
	- Discussion: how long, how large?

12. Mesoscale Method
	- Basic idea, basic physical law
	- Order parameter (field of phases)
	- Sharp interface, diffuse interface
	- Driving force for Micro-structure evolution: the 2nd law of thermodynamics, the reduction of free energy
	- Decrease of free energy → governing equation
	- Non-conserved field: Ginzburg-Landau,
	- Conserved field: Cahn-Hilliard,

13. Free energy functional, numerical methods to solve PDEs
	- Chemical energy
	- Interface energy (gradient energy)
	- Elastic energy
	- Others: electrostatic energy, magnetostatic energy, etc.)
	- Finite difference method
	- Finite element method
	- Fast Fourier Transformation

14. PF Hands-on (I)
	- solidification, liquid → solid
	- dendrite
	- recrystallization (multi-phase)

15. PF Hands-on (II)
	- dislocation

16. Summary and Outlooks


---

## 课程资源

- [《多尺度材料模拟与计算》课程网站](https://mmms.seekanotherland.xyz/)

- [《多尺度材料模拟与计算》课程资料](https://gitee.com/yangsl306/courses-mse-sjtu/tree/main/3-%E5%A4%9A%E5%B0%BA%E5%BA%A6%E6%9D%90%E6%96%99%E6%A8%A1%E6%8B%9F%E4%B8%8E%E8%AE%A1%E7%AE%97)

- [《多尺度材料模拟与计算》课程实验材料](https://gitee.com/yangsl306/MMMS)

- [《多尺度材料模拟与计算》课程实验报告及作业 LaTeX、Markdown 模板](https://gitee.com/yangsl306/report-template-MMMS)

- [《多尺度材料模拟与计算》课程实验报告及作业 Typst 模板](https://gitee.com/yangsl306/report-template-MMMS-typst)


---

## 参考教材

1. June Gunn Lee, Computational Materials Science: An Introduction, CRC press, 2016.
2. Richard LeSar, Introduction to Computational Materials Science Fundamentals to Applications, Cambridge University Press, 2013.
3. D. Frenkel and B. Smit. Understanding Molecular Simulation. 2nd ed. Burlington, MA: Academic Press, 2001.
4. K Capelle, A Bird's-Eye View of Density-Functional Theory, Brazilian Journal of Physics, 36(4A):1318-1343, 2006.
5. Ellad B. Tadmor and Ronald E. Miller, Modeling Materials: Continuum, Atomistic and Multiscale Techniques, Cambridge University Press, 2011.
6. S. Yip, Handbook of Materials Modeling, Springer, New York, 2005.
