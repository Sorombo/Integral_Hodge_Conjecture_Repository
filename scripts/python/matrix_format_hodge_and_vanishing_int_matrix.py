# ===========================================
# ===========================================
# ======== REFORMAT P TILDE MATRICES ========
# ===========================================
# ===========================================

# Importing numpy
import numpy as np

parent_dir = "../../auxiliar_data/hodge_cycles/"

hodge_cycle_dir = parent_dir + "raw/hodge_cycles_matrix/"
hodge_cycle_new_dir = parent_dir + "matrix_format/hodge_cycles_matrix/"

vanishing_int_dir = parent_dir + "raw/vanishing_intersection_matrix/"
vanishing_int_new_dir = parent_dir + "matrix_format/vanishing_intersection_matrix/"

n_arr = np.array([2, 4])
d_arr_min = np.array([4, 3]) 
d_arr_max = np.array([10, 6])

for s in np.arange(0, len(n_arr)):
	n = n_arr[s]
	for d in np.arange(d_arr_min[s], d_arr_max[s] + 1):
		# Setting filename
		basic_filename = "n_" + str(n) + "_d_" + str(d);
		
		hodge_cycle_prefix = "hodge_cycles_"
		vanishing_int_prefix = "vanishing_intersection_" 
		ext_file = ".txt"
		
		hodge_cycle_filename =  hodge_cycle_dir + hodge_cycle_prefix + basic_filename + ext_file
		vanishing_int_filename = vanishing_int_dir + vanishing_int_prefix + basic_filename + ext_file
		
		# ==================
		# Hodge Cycle matrix
		# ==================
		
		# Loading file
		arxiv_hodge_cyc = open(hodge_cycle_filename, 'r')
		arxiv_text = arxiv_hodge_cyc.read()

		# Parsing the file
		X    = arxiv_text.split(",")
		Y    = arxiv_text.split("\n")
		Z    = X[0].split("\n")
		X[0] = Z[-1]
		rows = int(Y[0])
		cols = int(Y[1])

		# Construct the matrix
		M = np.zeros((rows, cols))
		for k in np.arange(0, len(X)):
			index_1 = int(np.floor(k/cols))
			index_2 = np.mod(k, cols)
			M[index_1, index_2] = X[k]

		# Print a file containing the formatted matrix
		hodge_cycle_new_filename = hodge_cycle_new_dir + hodge_cycle_prefix + basic_filename + ext_file
		np.savetxt(hodge_cycle_new_filename, M, fmt='%i', delimiter = '\t\t')
		arxiv_hodge_cyc.close()
		
		# ==============================
		# Vanishing intersection  matrix
		# ==============================
		
		# Loading file
		arxiv_vanishing_int = open(vanishing_int_filename, 'r')
		arxiv_text = arxiv_vanishing_int.read()

		# Parsing the file
		X    = arxiv_text.split(",")
		Y    = arxiv_text.split("\n")
		Z    = X[0].split("\n")
		X[0] = Z[-1]
		rows = int(Y[0])
		cols = int(Y[1])

		# Construct the matrix
		M = np.zeros((rows, cols))
		for k in np.arange(0, len(X)):
			index_1 = int(np.floor(k/cols))
			index_2 = np.mod(k, cols)
			M[index_1, index_2] = X[k]

		# Print a file containing the formatted matrix
		vanishing_int_new_filename = vanishing_int_new_dir + vanishing_int_prefix + basic_filename + ext_file
		np.savetxt(vanishing_int_new_filename, M, fmt='%i', delimiter = '\t\t')
		arxiv_vanishing_int.close()


