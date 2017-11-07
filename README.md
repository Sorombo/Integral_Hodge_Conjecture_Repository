# Integral Hodge Conjecture for Fermat Varieties

In this repository it can be found an implementation of the algorithms described in [Aljovin, Movasati, and Villaflor 2017](http://w3.impa.br/~aljovin/docs/IntHodgeConj.pdf). It is important to say, that the present version is a light version. If you want the full version (all decompositions computed), you can download it from [Google Drive]()


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

The files are divided into three sections
* Main data (including the Smith Decomposition of main matrices)
* Auxiliar data (necessary data to produce the main data)
* Scripts

## Prerequisites

In order to run all the codes developed, you will need to install the following programs:

* [Python](https://www.python.org/) - The library NumPy will be used.
* [Singular](https://www.singular.uni-kl.de/) - Used to construct the Hodge Cycles matrix
* [Matlab](https://www.mathworks.com/products/matlab.html) - Used to construct the Linear Cycles matrix. 
* [Mathematica](https://www.wolfram.com/mathematica/) - Used to perfom the Smith Decomposition of integer matrices. It will be needed a 11.0 or newer version.



## Instructions

It will be common that at the beginning of the source files you will find lines like 

```python
n_arr = np.array([2, 4])
d_arr_min = np.array([3, 3]) 
d_arr_max = np.array([14, 6])	
```
These lines mean that the program will produce its outcome for the cases (n,d) = (2, 3), (2, 4), ..., (2, 14), (4, 3), ..., (4, 6). In that particularly order. Thus, if you want to compute a different set of cases, you can change these lines according to your purposes. 


### Hodge Cycles

1. Run Singular scripts to generate both Hodge Cycles and Vanishing Intersection matrices. There is a file for The script is located in scripts/singular. Here is an example code to produce the desired matrices for n = 2.
      ```
      execute(read("hodge_and_vanishing_cycles_matrix_script_n_2.txt"))
      ```
   When running the program it is strongly recommended to do it from the very same folder where it is located.

2. Convert raw files into matrix format files using the python script. Such script is located in **scripts/python** and goes under the name *matrix_format_hodge_and_vanishing_int_matrix.py*

3. Run the Mathematica script *smith_decomp_hodge_and_vanishing_matrices.m*, which is located in **scripts/mathematica**. Do not forget to edit the variable **parentDir**. You have to assign the path to this project folder.  
   E.g
      ```
      parentDir = "/home/myUser/Documents/Integral_Hodge_Conjecture_Repository/";
      ```
   It is important to include the backslash at the end of the string.


### Linear Cycles


1. Run the script which goes under the name *linear_cycles_matrix_script.m*, which is located in **scripts/matlab**.

   Do not forget to edit the variable **parent_dir**. Same considerations as in the step 2 of the calculation of Hodge Cycles should be taken.

   At this point you have produced both primitive and nonprimitive linear cycles matrices.


2. Run the following two Mathematica scripts
      * *smith_decomp_primitive_linear_cycles.m*
      * *smith_decomp_nonprimitive_linear_cycles.m*  
   
   Do not forget to edit the variable **parent_dir**. Same considerations as in the step 2 of the calculation of Hodge Cycles should be taken.

### Elementary divisors

1. To collect the elementary divisors from the data already produced, one just needs to run the following scripts
      * *primitive_elementary_divisors_counting.py*
      * *nonprimitive_elementary_divisors_counting.py*
      * *hodge_cycles_elementary_divisors_counting.py*
      
   These scripts will generate a *.tex* file including the elementary divisors for each case. As usual, the cases to be computed could be set in the scripts, editing the lines mentioned at the beginning of this section.
